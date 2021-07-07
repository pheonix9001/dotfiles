#define MODULE_START std::cout << "%{B#3B4252}%{+u} "
#define MODULE_END std::cout << " %{B-}%{-u}"
#define MIN(A, B)         ((A) < (B) ? (A) : (B))

void loadModule(const char *, char *, int);
void redraw();
