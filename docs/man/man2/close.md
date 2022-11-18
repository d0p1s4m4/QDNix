% close(2)
% d0p1
% 28 Brumaire CCXXXI

# NAME

close - close a file descriptor

# SYNOPSIS

```c
int close(int fildes);
```

# DESCRIPTION

close() closes a file descriptor so it can be reused.

# RETURN VALUES

close() return 0 on success and -1 on error.

# SEE ALSO

creat(2), open(2), pipe(2)
