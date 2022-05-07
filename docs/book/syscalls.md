# Syscalls

## chdir

```c
int chdir(const char *);
```

## close

```c
int close(int);
```

## dup

```c
int dup(int);
```

## exec

```c
int exec(const char *, const char *const []);
```

## exit

```c
int exit(int);
```

## fork

```c
int fork(void);
```

## fstat

```c
fstat(int, struct stat *);
```

## getpid

```c
int getpid(void);
```

## kill

```c
int kill(int);
```

## link

```c
int link(const char *, struct stat *);
```

## mkdir

```c
int mkdir(const char *);
```

## mknod

```c
int mknod(cont char *);
```

## open

```c
int open(const char *, int);
```

## pipe

```c
int pipe(const int[]);
```

## read

```c
int read(int, char *, int);
```
## sbrk

```c
void *sbrk(int);
```
## sleep

```c
int sleep(int);
```

## stat

```c
int stat(const char *, struct stat);
```

## unlink

```c
int unlink(const char *);
```

## wait

```c
int wait(int *);
```

## write

```c
int write(int, const char *, int);
```
