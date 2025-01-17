#' Reset the Project Environment
#'
#' Resets the project environment to the initial settings
#' created from the Google Spreadsheet inputs.
#'
#' @export
reset_project_env <- function() {
  correct_env()

  # Confirmation prompt
  selection <- utils::menu(c('No', 'Yes'),
                          title = paste('Are you sure you want to reset your project environment',
                                        'to its default settings?\nNote: this cannot be undone.'))

  if (selection == 1) { # No
    message('Cancelling reset...')
  } else { # Yes
    repo <- Sys.getenv('COURSE_REPO')

    if (repo == 'NA') {
      repo <- readline(prompt = "Please paste in your course blog repo link: ")
    } else {
      googlesheets4::gs4_deauth()
      row <- retrieve_row(repo)

      # Valid row
      if (length(row)) {
        file.remove('.env')
        initialize_env(row)
        message('Success. Environment reset.')
      # Invalid row
      } else {
        warning('Repo not found. Please try again.')
      }
    }
  }
}
