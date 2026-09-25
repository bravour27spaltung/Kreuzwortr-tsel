// Experimenteller Fuell-Solver fuer geschlossene Schwedenraetsel-Raster (Phase 2).
// Aufruf: solver <wortliste.tsv> <skelette.txt> <zeitlimit_s> <optionen...>
// Optionen (key=value): val=random|freq   alpha=<float>   var=mrv|wdeg   restart=<nodes|0>   seed=<int>
// Wortliste: TSV mit Kopfzeile, Spalten wort, laenge, haeufigkeit, ...
// Skelette:  je Skelett: "S ncells nents" dann je Eintrag "L c0 c1 ... cL-1" (eine Zeile)
// Ausgabe je Skelett: idx status nodes sekunden mean_logfreq min_freq restarts
#include <bits/stdc++.h>
using namespace std;
typedef unsigned long long u64;
static double now() { return chrono::duration<double>(chrono::steady_clock::now().time_since_epoch()).count(); }

struct LenIdx {
    int L = 0, n = 0, W = 0;
    vector<string> words; vector<double> lf; vector<int> freq;
    vector<u64> bits;                 // [pos][letter][W]
    u64* B(int pos, int ch) { return &bits[((size_t)pos * 26 + ch) * W]; }
    vector<u64> all;
};
static LenIdx idxs[16];

struct Opt { bool freqOrder = false; double alpha = 1.0; bool wdeg = false; long restart = 0; unsigned seed = 1; };

struct Skel { int ncells = 0; vector<vector<int>> ents; };

struct Solver {
    const Skel& S; Opt opt; mt19937_64 rng; double t0, tlimit;
    int ne; vector<char> cell; vector<int> assigned; vector<vector<int>> cellEnts; // cell -> entries
    vector<vector<int>> usedIdx;  // per length: bitset of used words (as words)
    vector<vector<u64>> used;
    vector<double> wt; long nodes = 0, runNodes = 0; int restarts = 0;
    vector<int> cnt;
    Solver(const Skel& s, Opt o, double tl) : S(s), opt(o), rng(o.seed), tlimit(tl) {
        ne = s.ents.size(); cell.assign(s.ncells, 0); assigned.assign(ne, -1); cellEnts.assign(s.ncells, {});
        for (int k = 0; k < ne; k++) for (int c : s.ents[k]) cellEnts[c].push_back(k);
        used.resize(16); for (int L = 0; L < 16; L++) used[L].assign(idxs[L].W, 0);
        wt.assign(ne, 1.0); cnt.assign(ne, 0);
    }
    // Kandidaten-Bitset fuer Eintrag k in buf; gibt Anzahl zurueck
    int cands(int k, vector<u64>& buf) {
        const auto& e = S.ents[k]; int L = e.size(); LenIdx& X = idxs[L];
        if (X.n == 0) return 0;
        buf.assign(X.all.begin(), X.all.end());
        for (int i = 0; i < L; i++) if (cell[e[i]]) {
            u64* b = X.B(i, cell[e[i]] - 1);
            for (int w = 0; w < X.W; w++) buf[w] &= b[w];
        }
        int c = 0; u64* u = used[L].data();
        for (int w = 0; w < X.W; w++) { buf[w] &= ~u[w]; c += __builtin_popcountll(buf[w]); }
        return c;
    }
    struct Timeout {};
    bool rec(int depth) {
        if ((++nodes & 255) == 0 && now() - t0 > tlimit) throw Timeout();
        // MRV / wdeg
        int best = -1; double bs = 1e18; static thread_local vector<u64> buf;
        int free_ = 0; vector<u64> bestbuf; int bestc = 0;
        for (int k = 0; k < ne; k++) if (assigned[k] < 0) {
            free_++;
            int c = cands(k, buf);
            if (c == 0) { if (opt.wdeg) wt[k] += 1; return false; }
            double sc = opt.wdeg ? c / wt[k] : c;
            if (sc < bs) { bs = sc; best = k; bestc = c; bestbuf = buf; }
        }
        if (!free_) return true;
        int L = S.ents[best].size(); LenIdx& X = idxs[L];
        vector<int> vals; vals.reserve(bestc);
        for (int w = 0; w < X.W; w++) { u64 x = bestbuf[w]; while (x) { int b = __builtin_ctzll(x); x &= x - 1; vals.push_back(w * 64 + b); } }
        if (opt.freqOrder) {   // gewichtete Zufallsreihenfolge (Efraimidis-Spirakis): key = u^(1/w), w = lf^alpha
            vector<pair<double, int>> ks; ks.reserve(vals.size());
            uniform_real_distribution<double> U(1e-12, 1.0);
            for (int v : vals) { double w = pow(max(0.5, X.lf[v]), opt.alpha); ks.push_back({pow(U(rng), 1.0 / w), v}); }
            sort(ks.begin(), ks.end(), [](auto& a, auto& b) { return a.first > b.first; });
            for (size_t i = 0; i < vals.size(); i++) vals[i] = ks[i].second;
        } else shuffle(vals.begin(), vals.end(), rng);
        const auto& e = S.ents[best];
        for (int v : vals) {
            runNodes++;
            if (opt.restart && runNodes > opt.restart) throw runtime_error("restart");
            vector<int> changed;
            const string& wd = X.words[v];
            for (int i = 0; i < L; i++) if (!cell[e[i]]) { cell[e[i]] = wd[i] - 'A' + 1; changed.push_back(e[i]); }
            assigned[best] = v; used[L][v >> 6] |= 1ULL << (v & 63);
            if (rec(depth + 1)) return true;
            for (int c : changed) cell[c] = 0;
            assigned[best] = -1; used[L][v >> 6] &= ~(1ULL << (v & 63));
        }
        if (opt.wdeg) wt[best] += 1;
        return false;
    }
    string run() {   // 'ok' | 'unsat' | 'timeout'
        t0 = now(); long limit = opt.restart;
        while (true) {
            runNodes = 0;
            try { bool ok = rec(0); return ok ? "ok" : "unsat"; }
            catch (Timeout&) { return "timeout"; }
            catch (runtime_error&) {
                restarts++;
                fill(cell.begin(), cell.end(), 0); fill(assigned.begin(), assigned.end(), -1);
                for (int L = 0; L < 16; L++) fill(used[L].begin(), used[L].end(), 0);
                if (now() - t0 > tlimit) return "timeout";
            }
        }
    }
};

int main(int argc, char** argv) {
    if (argc < 4) { fprintf(stderr, "usage\n"); return 1; }
    string wl = argv[1], sk = argv[2]; double tl = atof(argv[3]); Opt opt;
    for (int i = 4; i < argc; i++) {
        string a = argv[i]; auto p = a.find('='); string k = a.substr(0, p), v = a.substr(p + 1);
        if (k == "val") opt.freqOrder = (v == "freq");
        else if (k == "alpha") opt.alpha = atof(v.c_str());
        else if (k == "var") opt.wdeg = (v == "wdeg");
        else if (k == "restart") opt.restart = atol(v.c_str());
        else if (k == "seed") opt.seed = atoi(v.c_str());
    }
    { ifstream f(wl); string line; getline(f, line);
      map<int, vector<pair<string, int>>> byl;
      while (getline(f, line)) { stringstream ss(line); string w, l, fr; getline(ss, w, '\t'); getline(ss, l, '\t'); getline(ss, fr, '\t');
          bool okc = true; for (char c : w) if (c < 'A' || c > 'Z') okc = false;
          if (!okc || w.size() < 2 || w.size() > 15) continue; byl[w.size()].push_back({w, atoi(fr.c_str())}); }
      for (auto& [L, v] : byl) { LenIdx& X = idxs[L]; X.L = L; X.n = v.size(); X.W = (X.n + 63) / 64;
          X.bits.assign((size_t)L * 26 * X.W, 0); X.all.assign(X.W, 0);
          for (int i = 0; i < X.n; i++) { X.words.push_back(v[i].first); X.freq.push_back(v[i].second); X.lf.push_back(log((double)v[i].second));
              X.all[i >> 6] |= 1ULL << (i & 63);
              for (int p = 0; p < L; p++) X.B(p, v[i].first[p] - 'A')[i >> 6] |= 1ULL << (i & 63); } } }
    ifstream f(sk); string tag; int idx = 0;
    while (f >> tag) {
        Skel S; int nents; f >> S.ncells >> nents; S.ents.resize(nents);
        for (auto& e : S.ents) { int L; f >> L; e.resize(L); for (int& c : e) f >> c; }
        Opt o = opt; o.seed = opt.seed * 1000003u + idx;
        Solver sv(S, o, tl); string st = sv.run(); double dt = now() - sv.t0;
        double mlf = 0; int mn = INT_MAX, cntw = 0;
        if (st == "ok") for (int k = 0; k < nents; k++) { int L = S.ents[k].size(); mlf += idxs[L].lf[sv.assigned[k]]; mn = min(mn, idxs[L].freq[sv.assigned[k]]); cntw++; }
        printf("%d %s %ld %.3f %.3f %d %d\n", idx, st.c_str(), sv.nodes, dt, cntw ? mlf / cntw : 0.0, cntw ? mn : 0, sv.restarts);
        if (st == "ok" && getenv("SOLFILE")) { FILE* sf = fopen(getenv("SOLFILE"), "a"); fprintf(sf, "%d", idx);
            for (int k = 0; k < nents; k++) { int L = S.ents[k].size(); fprintf(sf, " %s", idxs[L].words[sv.assigned[k]].c_str()); } fprintf(sf, "\n"); fclose(sf); }
        fflush(stdout); idx++;
    }
}
