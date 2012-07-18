typedef struct { int dummy; } ngx_http_dtrace_request_t;
typedef struct { int dummy; } ngx_http_req_info_t;
typedef struct { int dummy; } ngx_conn_info_t;


provider ngx_http {
    probe request__start(ngx_http_dtrace_request_t *p) : (ngx_conn_info_t *p, ngx_http_req_info_t *p);
    probe request__done(ngx_http_dtrace_request_t *p) : (ngx_conn_info_t *p, ngx_http_req_info_t *p);
};

