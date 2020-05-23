
trap tidy_up EXIT
function tidy_up()
{
  [ ! -d objs/ ] || rm -rf objs/
}

export CPPUTEST_HOME=/cpputest
make
