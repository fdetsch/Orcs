#include <Rcpp.h>
using namespace Rcpp;

//' Substrings of a Character Vector (C++ Style)
//' 
//' @description Extract substrings from a `character` vector in C++.
//' 
//' @param x A `character` vector.
//' @param pos The start point of the substring as `integer`. Position 
//'   indications start from `1L`, which is the default in R.
//' @param len The length of the substring as `integer`.
//' 
//' @return
//' A `character` vector of the same length as 'x'.
//' 
//' @seealso
//' <https://cplusplus.com/reference/string/string/substr/>, [substr()].
//' 
//' @examples
//' substrC("Hello, world!", pos = 1, len = 5)
//' 
//' @export
// [[Rcpp::export]]
Rcpp::StringVector substrC(Rcpp::StringVector x, int pos, int len) {

  // translate position indication from R to C++ 
  pos = pos - 1;
  
  // initialize variables
  std::string s;

  int n = x.size();
  Rcpp::StringVector out(n);
  
  // cycle through elements in 'x'
  for (int i = 0; i < n; i++) {
    s = as<std::string>(x[i]);
    out[i] = s.substr(pos, len);
  }

  return out;
}
