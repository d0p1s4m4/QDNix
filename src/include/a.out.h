#ifndef _AOUT_H
# define _AOUT_H 1

# define OMAGIC 0407
# define NMAGIC 0410
# define ZMAGIC 0413

# define N_BAGMAG(x) \
	(x.a_magic != OMAGIC && x.a_magic != NMAGIC && x.a_magic != ZMAGIC)

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

struct relocation_info {
	int r_address;
	unsigned r_symbolnum:24,
			r_pcrel:1,
			r_length:2,
			r_extern:1,
			pad:4;
};

#endif /* !_AOUT_H */
