#' Example dataset for network meta-analysis
#'
#' This example dataset represents a previously published network of interventions
#' for the treatment of Bovine Respiratory Disease (BRD) in feedlot cattle
#' (O’Connor, Yuan, Cullen, Coetzee, Da Silva, and Wang, 2016). The dataset is
#' comprised of 98 trials, 13 treatments and 204 arms. Each row represents the
#' summary statistics for a pairwise comparison between two treatment in a trial.
#'
#' @docType data
#'
#' @usage data(BRDdat)
#'
#' @format An object of class \code{"data.frame"}
#' \describe{
#'  \item{studlab}{study id (integer)}
#'  \item{treat1}{name of treatment 1 (character)}
#'  \item{treat2}{name of treatment 2 (character)}
#'  \item{TE}{estimated treatment effect size (log odds ratio) between
#'    treat1 and treat2}
#'  \item{seTE}{standard error of TE}
#' }
#' @references \href{https://pubmed.ncbi.nlm.nih.gov/27612392/}{O’Connor, A. M., Yuan, C., Cullen, J. N., Coetzee, J. F., Da Silva, N., & Wang, C. (2016). A mixed treatment meta-analysis of antibiotic treatment options for bovine respiratory disease–an update. Preventive veterinary medicine, 132, 130-139.}.
#' @keywords datasets
#' @examples
#'
#' data(BRDdat)
#' head(BRDdat)
#'
"BRDdat"
