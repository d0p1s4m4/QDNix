% a.out(5)
% d0p1
% 28 Brumaire CCXXXI

# NAME

a.out - assembler and lik editor output

# SYNOPSIS

```c
#include <a.out.h>
```

# DESCRIPTION

```c
struct exec {
	int a_magic;
	unsigned a_text;
	unsigned a_data;
	unsigned a_bss;
	unsigned a_syms;
	unsigned a_entry;
	unsigned a_trsize;
	unsigned a_drsize;
};
```
- `a_magic`
   - OMAGIC
   - NMAGIC
   - ZMAGIC
- `a_text`
- `a_data`
- `a_bss`
- `a_syms`
- `a_entry`
- `a_trsize`
- `a_drsize`

```c
struct nlist {
	union {
		char const *n_name;
		long n_strx;
	} n_un;
	unsigned char n_type;
	char n_other;
	short n_desc;
	unsigned n_value;
};
```

- `n_un`
    - `n_name`
	- `n_strx`
- `n_type`
- `n_other`
- `n_desc`
- `n_value`

```c
struct relocation_info {
	int r_address;
	unsigned r_symbolnum:24,
			r_pcrel:1,
			r_length:2,
			r_extern:1,
			pad:4;
};
```

- `r_address`
- `r_symbolnum`
- `r_pcrel`
- `r_length`
- `r_extern`

# SEE ALSO

nm(1)
