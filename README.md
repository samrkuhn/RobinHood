![Travis-CI](https://travis-ci.org/JestonBlu/RobinHood.svg?branch=master)
![Commit-Activity](https://img.shields.io/github/commit-activity/4w/JestonBlu/RobinHood.svg)
![CRAN Version](http://www.r-pkg.org/badges/version/RobinHood)
![CRAN Downloads](http://cranlogs.r-pkg.org/badges/RobinHood)

--------------------------------------------------------------------------------

## RobinHood
An R Interface for the RobinHood.com no commision investing site.

This project is in early development. Once I get a basic set of usuable features created then I will do a first release, submit the package to CRAN, and stop making changes to the master branch. Until then things could structurally change without notice. Please see the project page for a list of features I am working on for the initial release.

## Install with devtools
```r
devtools::install_github("jestonblu/RobinHood")
```

## Examples
```r
library(RobinHood)

# Establishes a connection with your account and generates an oauth2 token
# Returns a list style object of relevant API keys and IDs needed to interact with your account
RH = RobinHood(username = "username", password = "password")

# Returns a data.frame of positions
get_positions(RH, simple = TRUE)

#   simple_name symbol quantity average_buy_price last_trade_price cost current_value          updated_at
# 1          GE     GE        1               8.5             8.73  8.5          8.73 2019-01-10 04:19:01
# 2       Zynga   ZNGA        2               0.0             4.27  0.0          8.54 2019-01-06 16:44:03

# Get quotes
get_quote(RH, ticker = c("CAT", "GE"), simple = TRUE)

#    symbol last_trade_price last_trade_price_source
# 1    CAT       131.660000            consolidated
# 2     GE         8.980000            consolidated

# Place Order, should generate an email
x = place_order(RH = RH, symbol = "GE", type = "market", time_in_force = "gfd",
                trigger = "immediate", price = 8.96, quantity = 1, side = "buy")

# Cancel your order, should also generate an email
cancel_order(RH, x$url)

# Get market hours for a specific date
get_market_hours(RH)
#                            name     city             website   timezone acronym opens_at closes_at extended_opens_at extended_closes_at is_open       date
# 1                    IEX Market New York  www.iextrading.com US/Eastern     IEX 08:30:00  15:00:00          08:00:00           17:00:00    TRUE 2019-01-17
# 2                   Otc Markets New York  www.otcmarkets.com US/Eastern    OTCM 08:30:00  15:00:00          08:00:00           17:00:00    TRUE 2019-01-17
# 3                  NYSE Mkt Llc New York        www.nyse.com US/Eastern    AMEX 08:30:00  15:00:00          08:00:00           17:00:00    TRUE 2019-01-17
# 4                     NYSE Arca New York        www.nyse.com US/Eastern    NYSE 08:30:00  15:00:00          08:00:00           17:00:00    TRUE 2019-01-17
# 5 New York Stock Exchange, Inc. New York        www.nyse.com US/Eastern    NYSE 08:30:00  15:00:00          08:00:00           17:00:00    TRUE 2019-01-17
# 6          NASDAQ - All Markets New York      www.nasdaq.com US/Eastern  NASDAQ 08:30:00  15:00:00          08:00:00           17:00:00    TRUE 2019-01-17
# 7                 BATS Exchange New York www.batstrading.com US/Eastern    BATS 08:30:00  15:00:00          08:00:00           17:00:00    TRUE 2019-01-17

# Logout and revoke your oauth2 token
logout(RH)

```
