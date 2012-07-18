/* for abstracting out ngx_http_request_t */
typedef struct ngx_http_dtrace_request_32_s {
    uint64_t         id;
    uint32_t         uri;
    uint32_t         args;
    uint32_t         laddr;
    uint32_t         raddr;
} ngx_http_dtrace_request_32_t;


typedef struct ngx_http_dtrace_request_s {
    uint64_t         id;
    uint64_t         uri;
    uint64_t         args;
    uint64_t         laddr;
    uint64_t         raddr;
} ngx_http_dtrace_request_t;


typedef struct ngx_conn_info_s {
    string ci_local;	/* local host address */
    string ci_remote;	/* remote host address */
    string ci_protocol;	/* protocol (ipv4, ipv6, etc) */
} ngx_conn_info_t;


typedef struct ngx_http_req_info_s {
    uint64_t    ri_id;
    string      ri_uri;
    string      ri_args;
} ngx_http_req_info_t;


#pragma D binding "1.6.1" translator
translator ngx_conn_info_t < ngx_http_dtrace_request_t *r > {
    ci_local = 
        curpsinfo->pr_dmodel == PR_MODEL_ILP32 ?
            copyinstr((uintptr_t)(uint64_t)(*(uint32_t *)copyin(
                (uintptr_t)&((ngx_http_dtrace_request_32_t *)r)->laddr,     
                sizeof(((ngx_http_dtrace_request_32_t *)r)->laddr)))) :
            copyinstr(*(uintptr_t *)copyin(   
                (uintptr_t)&r->laddr, sizeof(uint64_t)));

    ci_remote =
        curpsinfo->pr_dmodel == PR_MODEL_ILP32 ?
            copyinstr((uintptr_t)(uint64_t)(*(uint32_t *)copyin(
                (uintptr_t)&((ngx_http_dtrace_request_32_t *)r)->raddr,     
                sizeof(uint32_t)))) :
            copyinstr(*(uintptr_t *)copyin(   
                (uintptr_t)&r->raddr, sizeof(uint64_t)));

    ci_protocol = "ipv4";
};

#pragma D binding "1.6.1" translator
translator ngx_http_req_info_t < ngx_http_dtrace_request_t *r > {
    ri_id = 
        curpsinfo->pr_dmodel == PR_MODEL_ILP32 ?
            *(uint64_t *)copyin(
                (uintptr_t) &((ngx_http_dtrace_request_32_t *)r)->id,
                sizeof(uint32_t)) :
            *(uint64_t *)copyin((uintptr_t) &r->id, sizeof(uint64_t));

    ri_uri = 
        curpsinfo->pr_dmodel == PR_MODEL_ILP32 ?
            copyinstr((uintptr_t)(uint64_t)(*(uint32_t *)copyin(
                (uintptr_t)&((ngx_http_dtrace_request_32_t *)r)->uri,     
                sizeof(uint32_t)))) :
            copyinstr(*(uintptr_t *)copyin(   
                (uintptr_t)&r->uri, sizeof(uint64_t)));

    ri_args = 
        curpsinfo->pr_dmodel == PR_MODEL_ILP32 ?
            copyinstr((uintptr_t)(uint64_t)(*(uint32_t *)copyin(
                (uintptr_t)&((ngx_http_dtrace_request_32_t *)r)->args,     
                sizeof(uint32_t)))) :
            copyinstr(*(uintptr_t *)copyin(   
                (uintptr_t)&r->args, sizeof(uint64_t)));
};

