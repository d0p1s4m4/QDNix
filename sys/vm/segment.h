#ifndef SYS_VMM_SEGMENT_H
# define SYS_VMM_SEGMENT_H 1

typedef enum {
	SEG_VNODE, /* regular file */
	SEG_MAP,
	SEG_DEV,
	SEG_KMEM
} SegmentDriverType;

#endif /* !SYS_VMM_SEGMENT_H */
