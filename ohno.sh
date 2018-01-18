DIFF_DAYS=$((($(TZ=":Europe/London" date +%s) - $(TZ=":Europe/London" date -f last_date +%s)) / (60*60*24)))
CURR_BEST=$(cat curr_record)

if [ "$DIFF_DAYS" -gt "$CURR_BEST" ];
  then
  echo $DIFF_DAYS > curr_record
  echo "New PB! Was $CURR_BEST, now $DIFF_DAYS!"
  CURR_BEST=DIFF_DAYS
else
  echo "No PB, sorry... PB is $CURR_BEST, this time was $DIFF_DAYS"
fi

echo $(date +%y%m%d) > last_date

cat header > index.html
echo "var faildate = new Date('$(TZ=":Europe/London" date -f last_date +%Y-%m-%d)');" >> index.html
echo "var streak = $CURR_BEST;" >> index.html
cat footer >> index.html

git add curr_record last_date index.html
git commit -m "Oh no..."
git push origin master
