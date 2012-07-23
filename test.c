#include <stdio.h>
#include "test_provider_impl.h"
#include "test_provider.h"
#include <unistd.h>

int main(void)
{
    ngx_http_dtrace_request_t   dt_r;

    dt_r.id = 256;
    dt_r.uri = "/foo/bar";
    dt_r.args = "foo=3&bar=4";
    dt_r.laddr = "local";
    dt_r.raddr = "remote";

    for (;;) {
        NGX_CORE_BLAH(789);

        if (NGX_HTTP_REQUEST_START_ENABLED()) {
            NGX_HTTP_REQUEST_START(&dt_r);
        }

        sleep(1);

        if (NGX_HTTP_REQUEST_DONE_ENABLED()) {
            NGX_HTTP_REQUEST_DONE(&dt_r);
        }

        printf("next\n");
    }

    printf("done\n");

    return 0;
}

