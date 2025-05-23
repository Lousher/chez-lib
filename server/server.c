#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <uv.h>

void on_connection(uv_stream_t *, int);
void on_write(uv_write_t *, int);

int server_init(const char* ip, uint16_t port) {
  uv_loop_t *loop = uv_default_loop();
  uv_tcp_t server;
  uv_tcp_init(loop, &server);

  struct sockaddr_in addr;

  uv_ip4_addr(ip, port, &addr);
  uv_tcp_bind(&server, (const struct sockaddr*)&addr, 0);

  uv_listen((uv_stream_t*)&server, 128, on_connection);

  printf("Server Running at Port: %d", port);
  return uv_run(loop, UV_RUN_DEFAULT);
}

void alloc_cb(uv_handle_t* handle, size_t size, uv_buf_t* buf) {
  buf->base = malloc(size);
  buf->len = size;
}

void on_read(uv_stream_t* client,ssize_t nread, const uv_buf_t* buf) {
  if (nread > 0) {
    
  }
}

void on_connection(uv_stream_t* server, int status) {
  if (status < 0) {
    perror("Connection failed");
    return;
  }

  uv_tcp_t *client = malloc(sizeof(uv_tcp_t));
  uv_tcp_init(uv_default_loop(), client);
  uv_accept(server, (uv_stream_t*)client);

  uv_read_start((uv_stream_t*)client, alloc_cb, on_read);
  
}
