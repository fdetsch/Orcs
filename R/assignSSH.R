#' Assign SSH Key to Local Git Repository
#' 
#' @description 
#' Assign an SSH key to a local Git repository to bypass user/password prompts 
#' during `git push. See 
#' [Generating an SSH Key](https://docs.github.com/articles/generating-an-ssh-key/) 
#' for further information on how to generate an SSH key and add it to your 
#' GitHub account.
#' 
#' @param user GitHub user name as `character`. If not specified, information on
#'   GitHub user and repository name is taken from the current working 
#'   environment.
#' @param repo GitHub repository name as `character`, see 'user'. 
#' 
#' @seealso 
#' <https://docs.github.com/articles/generating-an-ssh-key/>.
#' 
#' @examples 
#' \dontrun{
#' ## for an arbitrary git repository
#' assignSSH()
#' 
#' ## for this very git repository
#' assignSSH(user = "fdetsch", repo = "Orcs")
#' }
#' 
#' @export
assignSSH <- function(user, repo) {
  
  ## if 'user' or 'repo' are missing, try to get information from current 
  ## working environment
  repo <- if (missing(user) | missing(repo)) {
    system("git config --local remote.origin.url", intern = TRUE)
  } else {
    paste0("git@github.com:", user, "/", repo, ".git")
  }
  
  ## assign ssh key
  system(
    paste("git remote set-url origin", repo)
  )
  
  return(invisible())
}
