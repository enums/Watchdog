cd ../
while true
do
  ./.build/release/Watchdog
  DATE=`date +%Y-%m-%d_%H:%M:%S`
  echo '['$DATE']Crash detected!' >> Workspace/runtime/crash.log
done
