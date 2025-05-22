#include <stdio.h>
#include <stdlib.h>
#include <uv.h>

typedef struct my_time {
  int64_t now;
} my_time_t;

void my_timer_cb(uv_timer_t* handle) {
  my_time_t *update_time;
  update_time = (my_time_t*)handle->data;
  printf("timer callback running, time =%ld\n", update_time->now);
  update_time->now = uv_now(uv_default_loop());
}

int main() {
  my_time_t time;
  uv_timer_t timer;
  timer.data = (void*)&time;

  uv_timer_init(uv_default_loop(), &timer);
  uv_timer_start(&timer,my_timer_cb, 0, 1000);
  uv_run(uv_default_loop(), UV_RUN_DEFAULT);
  return 0;
}
