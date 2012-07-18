#!/usr/sbin/dtrace -s

#pragma D option quiet

BEGIN {
    printf("Tracing.  Hit CTRL-C to stop.\n");
}

ngx_http*:::request-start
{
    printf("start: %s -> %s (id %d, %s?%s)\n", args[0]->ci_remote, args[0]->ci_local, args[1]->ri_id, args[1]->ri_uri, args[1]->ri_args)
}

ngx_http*:::request-done
{
    printf("done: %s -> %s (id %d, %s?%s)\n", args[0]->ci_remote, args[0]->ci_local, args[1]->ri_id, args[1]->ri_uri, args[1]->ri_args)
}

