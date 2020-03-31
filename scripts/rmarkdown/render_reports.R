
make_report <- 
  function(ticker) {
  rmarkdown::render("scripts/rmarkdown/stock_market.Rmd",
                    output_file = paste0("mkt_reports/",ticker, ".html"),
                    params = list(ticker = ticker))
}

tickers <- c("ATVI", "MSFT", "SPCE", "TSLA", "NFLX", "ZM")

lapply(tickers, make_report)


E(x - y) = 
  
