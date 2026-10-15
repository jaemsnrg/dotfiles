# --- perfcheck: where is my Mac's performance going? ---
# Usage: perfcheck [-n TOP_N] [-w]   (-w: watch, refresh every 5s)
_pc_bold=$'\e[1m'; _pc_dim=$'\e[2m'; _pc_red=$'\e[31m'; _pc_yel=$'\e[33m'; _pc_rst=$'\e[0m'

_pc_hdr() { print -- "\n${_pc_bold}== $1 ==${_pc_rst}"; }

_perfcheck_run() {
  local red=$_pc_red yel=$_pc_yel rst=$_pc_rst
  local ncpu=$(sysctl -n hw.logicalcpu)

  _pc_hdr "LOAD  ($ncpu logical cores)"
  uptime | sed 's/^.*up/up/'
  local l1=$(sysctl -n vm.loadavg | awk '{print $2}')
  awk -v l=$l1 -v n=$ncpu -v r=$red -v y=$yel -v z=$rst 'BEGIN{
    p=l/n*100; c=(p>100?r:(p>70?y:""));
    printf "%s1-min load is %.0f%% of core capacity%s\n", c, p, z }'

  _pc_hdr "THERMAL / POWER"
  pmset -g therm 2>/dev/null | grep -Ei 'warning|limit' | sed 's/^/  /'
  pmset -g batt 2>/dev/null | head -2 | sed 's/^/  /'

  _pc_hdr "CPU USAGE (instantaneous, 2s sample)"
  top -l 2 -n 0 -s 1 | awk '/^CPU usage/{l=$0} END{print "  " l}'

  _pc_hdr "TOP $TOP PROCESSES BY CPU (instantaneous)"
  top -l 2 -s 1 -n $TOP -o cpu -stats pid,cpu,mem,command \
    | awk '/^PID/{n++; next} n==2 && NF' | head -$TOP \
    | awk '{printf "  %-7s %6s%%  %8s  ", $1, $2, $3; for(i=4;i<=NF;i++) printf "%s ", $i; print ""}'

  _pc_hdr "CPU + MEMORY GROUPED BY APP"
  ps -axo pid=,pcpu=,rss=,command= | awk '
    { cpu=$2; rss=$3; $1=$2=$3="";
      sub(/^ +/,"");
      if (match($0, /[^\/]+\.app/)) { name=substr($0,RSTART,RLENGTH); sub(/\.app$/,"",name) }
      else { n=split($0,a," "); m=split(a[1],b,"/"); name=b[m] }
      c[name]+=cpu; r[name]+=rss; k[name]++ }
    END { for (n in c) printf "%7.1f %8.0f %4d  %s\n", c[n], r[n]/1024, k[n], n }' \
    | sort -rn | head -$TOP \
    | awk 'BEGIN{printf "  %7s %8s %5s  %s\n","CPU%","MEM(MB)","PROCS","APP"} {printf "  %7s %8s %5s  ", $1,$2,$3; for(i=4;i<=NF;i++) printf "%s ",$i; print ""}'

  _pc_hdr "MEMORY"
  local page=$(sysctl -n hw.pagesize) total=$(sysctl -n hw.memsize)
  vm_stat | awk -v p=$page -v t=$total '
    /Pages free/{f=$3} /Pages active/{a=$3} /Pages inactive/{i=$3}
    /Pages wired/{w=$4} /occupied by compressor/{c=$5}
    END{ g=1073741824;
      printf "  total %.1fG | active %.1fG | wired %.1fG | compressed %.1fG | free %.1fG\n",
        t/g, a*p/g, w*p/g, c*p/g, f*p/g }'
  sysctl -n vm.swapusage | sed 's/^/  swap: /'
  memory_pressure 2>/dev/null | awk '/free percentage/{print "  " $0}'

  _pc_hdr "TOP $TOP BY MEMORY"
  ps -axmo pid=,rss=,command= | head -$TOP | awk '{
    r=$2/1024; $1=$2=""; sub(/^ +/,"");
    if (match($0, /[^\/]+\.app/)) name=substr($0,RSTART,RLENGTH); else {n=split($0,a," "); m=split(a[1],b,"/"); name=b[m]}
    printf "  %8.0f MB  %s\n", r, name }'

  _pc_hdr "DISK I/O (1s sample)"
  iostat -d -c 2 -w 1 | tail -1 | awk '{printf "  %s KB/t  %s xfrs  %s MB/s\n",$1,$2,$3}'

  _pc_hdr "LONG-RUNNING CPU HOGS (>50% CPU, runtime > 30min)"
  ps -axo pid=,pcpu=,etime=,comm= | awk '$2>50 && ($3 ~ /-/ || $3 ~ /^[0-9]+:[0-9]+:[0-9]+$/) {print "  " $0}'

  _pc_hdr "NOTES"
  print -- "  ${_pc_dim}Arc/Chrome 'Browser Helper (Renderer)' = one per tab. Map to tabs: Arc → Window → Task Manager (Cmd+Opt+Esc).${_pc_rst}"
  print -- "  ${_pc_dim}High WindowServer CPU usually means heavy animation/video/WebGL somewhere.${_pc_rst}"
}


perfcheck() {
  local TOP=10 WATCH=0 opt OPTIND=1
  while getopts "n:w" opt; do
    case $opt in
      n) TOP=$OPTARG ;;
      w) WATCH=1 ;;
      *) echo "usage: perfcheck [-n TOP_N] [-w]"; return 1 ;;
    esac
  done

  if (( WATCH )); then
    while true; do clear; _perfcheck_run; sleep 5; done
  else
    _perfcheck_run
  fi
}
