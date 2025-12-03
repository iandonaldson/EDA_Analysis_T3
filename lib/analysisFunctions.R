# lib/analysisFunctions.R

# Version 1: Function that uses global variables from the calling environment
write_output_global <- function(content) {
  start_time <- Sys.time()
  writeLines(paste("Start time:", start_time), log_connection)  # Log start time

  # Write the content to the output file
  output_file <- file.path(OUTPUT_DIR, "output_global.txt")
  writeLines(content, output_file)

  end_time <- Sys.time()
  writeLines(paste("End time:", end_time), log_connection)  # Log end time
}

# Version 2: Function that uses variable passing (log and output directory passed as arguments)
write_output_pass <- function(content, output_dir, log_con) {
  start_time <- Sys.time()
  writeLines(paste("Start time:", start_time), log_con)  # Log start time

  # Write the content to the output file
  output_file <- file.path(output_dir, "output_pass.txt")
  writeLines(content, output_file)

  end_time <- Sys.time()
  writeLines(paste("End time:", end_time), log_con)  # Log end time
}
