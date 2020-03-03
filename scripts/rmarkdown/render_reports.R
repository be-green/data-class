
make_report <- 
  function(ticker) {
  rmarkdown::render("scripts/rmarkdown/stock_market.Rmd",
                    output_file = paste0(ticker, ".html"),
                  params = list(ticker = ticker))
}

tickers <- c("ATVI", "MSFT", "SPCE", "TSLA")

lapply(tickers, make_report)


