#' Get *p*-Value from 'lm' Object
#' 
#' @description 
#' Retrieve the *p*-value associated with a univariate linear regression. 
#' 
#' @param mod An object of class `lm`.
#' 
#' @return 
#' A `numeric` *p*-value.
#' 
#' @source  
#' [retrieving p-values in lm](https://stat.ethz.ch/pipermail/r-help/2005-December/084308.html)
#' on R-help mailing list.
#' 
#' @seealso 
#' [stats::lm()].
#' 
#' @examples 
#' ## taken from ?lm
#' ctl <- c(4.17,5.58,5.18,6.11,4.50,4.61,5.17,4.53,5.33,5.14)
#' trt <- c(4.81,4.17,4.41,3.59,5.87,3.83,6.03,4.89,4.32,4.69)
#' group <- gl(2, 10, 20, labels = c("Ctl","Trt"))
#' weight <- c(ctl, trt)
#' lm.D9 <- lm(weight ~ group)
#' 
#' pvalue(lm.D9)
#' 
#' @export
pvalue <- function(mod) {
  
  mod_sum <- summary(mod)
  coef(mod_sum)[2, 4]
  
}
