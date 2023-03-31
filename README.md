# node-app
Crash instruction
```
docker build -t nodealpine -f Dockerfile .
docker run -it --rm --name nodetest nodealpine ash
cd /usr/src/app
LD_PRELOAD=/usr/lib/appscope/1.3.1/libscope.so node server.js 
Segmentation fault (core dumped)
```

stacktrace

```
reader () from /usr/lib/appscope/1.3.1/libscope.so
decodeInstruction () from /usr/lib/appscope/1.3.1/libscope.so
X86_getInstruction () from /usr/lib/appscope/1.3.1/libscope.so
cs_disasm () from /usr/lib/appscope/1.3.1/libscope.so
funchook_disasm_init () from /usr/lib/appscope/1.3.1/libscope.so
funchook_make_trampoline () from /usr/lib/appscope/1.3.1/libscope.so
funchook_prepare () from /usr/lib/appscope/1.3.1/libscope.so
initHook (attachedFlag=0, scopedFlag=1, ebuf=0x7ff0cfdc5040, 
full_path=0x7ff0d0b2bf90 "/usr/lib/appscope/1.3.1/libscope.so")
```

Appscope crash source code location:

src/wrap.c
```
        if (g_fn.uv__read) rc = funchook_prepare(funchook, (void**)&g_fn.uv__read, uv__read_hook);
```
