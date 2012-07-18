#ifndef TEST_PROVIDER_IMPL_H
#define TEST_PROVIDER_IMPL_H


#include <stdlib.h>
#include <stdint.h>


typedef struct ngx_http_dtrace_request_s {
    uint64_t         id;
    const char      *uri;
    const char      *args;
    const char      *laddr;
    const char      *raddr;
} ngx_http_dtrace_request_t;


#endif

