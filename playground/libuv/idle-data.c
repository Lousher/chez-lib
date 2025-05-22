#include <stdio.h>
#include <stdlib.h>
#include <uv.h>

int64_t num = 0;

void my_idle_cb(uv_idle_t* handle)
{
  num++;
  if (num >= 10e3)
    {
      printf("data: %s\n", (char*)handle->data);
      printf("idle stop, num = %ld\n", num);
      uv_idle_stop(handle);
    }
}

int main()
{
  uv_idle_t idler;
  uv_idle_init(uv_default_loop(), &idler);
  idler.data = (void*)"this is a public data";

  printf("idle start,num = %ld\n", num);

  uv_idle_start(&idler, my_idle_cb);

  uv_run(uv_default_loop(), UV_RUN_DEFAULT);
  return 0;
}
