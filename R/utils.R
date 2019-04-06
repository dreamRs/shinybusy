
create_id <- function() {
  paste(as.raw(sample.int(255, 12)), collapse = "")
}

dropNulls <- function(x) {
  x[!vapply(x, is.null, FUN.VALUE = logical(1))]
}
