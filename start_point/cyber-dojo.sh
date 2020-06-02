
# --------------------------------------------------------------
# Text files under /sandbox are automatically returned...
source ~/cyber_dojo_fs_cleaners.sh
export REPORT_DIR=${CYBER_DOJO_SANDBOX}/report
function cyber_dojo_enter()
{
  # 1. Only return _newly_ generated reports.
  cyber_dojo_reset_dirs ${REPORT_DIR}
}
function cyber_dojo_exit()
{
  # 2. Remove text dirs/files we don't want returned.
  cyber_dojo_delete_dirs objs/ # ...
  #cyber_dojo_delete_files ...
}
cyber_dojo_enter
trap cyber_dojo_exit EXIT SIGTERM
# --------------------------------------------------------------

export CPPUTEST_HOME=/cpputest
make
