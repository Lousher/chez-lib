#include <stdio.h>
#include <stdlib.h>
#include <uv.h>

int main()
{
  char *version;
  version = (char*) uv_version_string();

  printf("libuv version is %s\n", version);
  return 0;
}
