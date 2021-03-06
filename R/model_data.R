load_data <- function(dlmRS){
  dlmRS <- dlmRS %>%
    load_X_Y %>%
    load_dimensions
  return(dlmRS)
}

load_X_Y <- function(dlmRS){
  formula <- delete_intercept(dlmRS$input$formula)
  datset <- dlmRS$input$dataset
  mf <- model.frame(formula = formula, data = dataset)
  dlmRS$data$X <- model.matrix(attr(mf, "terms"), data = mf)
  dlmRS$data$Y <- model.response(data = mf)
  return(dlmRS)
}

load_dimensions <- function(dlmRS){
  dlmRS$data$m <- nrow(dlmRS$data$X)
  dlmRS$data$p <- ncol(dlmRS$data$X)
  return(dlmRS)
}

delete_intercept <- function(formula) {
  non_intercept_in_formula <- grepl("+0", gsub(" ", "", toString(formula[3])))
  if(!non_intercept_in_formula) {
    formula <- as.formula(paste(
      toString(formula[2]),
      "~",
      toString(formula[3]),
      "+0"
    ))
  }
  return(formula)
}