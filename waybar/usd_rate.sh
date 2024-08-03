rate=$(curl -s https://www.cbr.ru/currency_base/daily/ | xmllint --html --xpath '//tr[td[contains(text(),"840")]]/td[5]/text()' - 2>/dev/null)
echo "{\"text\": \"$rate₽\", \"tooltip\": \"Курс доллара США\"}"
