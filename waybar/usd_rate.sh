rate=$(curl -s "https://api.coingecko.com/api/v3/simple/price?ids=tether&vs_currencies=rub" | jq '.tether.rub' 2>/dev/null)
echo "{\"text\": \"$rate\", \"tooltip\": \"USDT to RUB rate\"}"
