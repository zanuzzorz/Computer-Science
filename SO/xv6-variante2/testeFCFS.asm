
_testeFCFS: formato do arquivo elf32-i386


Desmontagem da seção .text:

00000000 <loop>:

#define MAX 9999999
#define MIN 100
#define N  20

void loop(int n){
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 ec 10             	sub    $0x10,%esp
	int x,y;
	
	if(n) y=MAX;  
   6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
   a:	74 09                	je     15 <loop+0x15>
   c:	c7 45 f8 7f 96 98 00 	movl   $0x98967f,-0x8(%ebp)
  13:	eb 07                	jmp    1c <loop+0x1c>
	else  y=MIN;
  15:	c7 45 f8 64 00 00 00 	movl   $0x64,-0x8(%ebp)
	
	for(x=0; x<y; x++)
  1c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  23:	eb 2e                	jmp    53 <loop+0x53>
		for(x=0; x<y; x++)
  25:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  2c:	eb 19                	jmp    47 <loop+0x47>
			for(x=0; x<y; x++){}
  2e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  35:	eb 04                	jmp    3b <loop+0x3b>
  37:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  3b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  3e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  41:	7c f4                	jl     37 <loop+0x37>
	
	if(n) y=MAX;  
	else  y=MIN;
	
	for(x=0; x<y; x++)
		for(x=0; x<y; x++)
  43:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  47:	8b 45 fc             	mov    -0x4(%ebp),%eax
  4a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  4d:	7c df                	jl     2e <loop+0x2e>
	int x,y;
	
	if(n) y=MAX;  
	else  y=MIN;
	
	for(x=0; x<y; x++)
  4f:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  53:	8b 45 fc             	mov    -0x4(%ebp),%eax
  56:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  59:	7c ca                	jl     25 <loop+0x25>
		for(x=0; x<y; x++)
			for(x=0; x<y; x++){}
}
  5b:	c9                   	leave  
  5c:	c3                   	ret    

0000005d <main>:

int main(){
  5d:	8d 4c 24 04          	lea    0x4(%esp),%ecx
  61:	83 e4 f0             	and    $0xfffffff0,%esp
  64:	ff 71 fc             	pushl  -0x4(%ecx)
  67:	55                   	push   %ebp
  68:	89 e5                	mov    %esp,%ebp
  6a:	51                   	push   %ecx
  6b:	83 ec 64             	sub    $0x64,%esp
	int n,pid[N],op;

	for(n=0;n<N;n++){
  6e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  75:	eb 41                	jmp    b8 <main+0x5b>
		pid[n] = fork();
  77:	e8 ac 02 00 00       	call   328 <fork>
  7c:	89 c2                	mov    %eax,%edx
  7e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  81:	89 54 85 a0          	mov    %edx,-0x60(%ebp,%eax,4)
		if (pid[n] == 0){
  85:	8b 45 f4             	mov    -0xc(%ebp),%eax
  88:	8b 44 85 a0          	mov    -0x60(%ebp,%eax,4),%eax
  8c:	85 c0                	test   %eax,%eax
  8e:	75 24                	jne    b4 <main+0x57>
			op = (n%2);  // operação 0 ou 1
  90:	8b 45 f4             	mov    -0xc(%ebp),%eax
  93:	99                   	cltd   
  94:	c1 ea 1f             	shr    $0x1f,%edx
  97:	01 d0                	add    %edx,%eax
  99:	83 e0 01             	and    $0x1,%eax
  9c:	29 d0                	sub    %edx,%eax
  9e:	89 45 f0             	mov    %eax,-0x10(%ebp)
			loop(op);
  a1:	83 ec 0c             	sub    $0xc,%esp
  a4:	ff 75 f0             	pushl  -0x10(%ebp)
  a7:	e8 54 ff ff ff       	call   0 <loop>
  ac:	83 c4 10             	add    $0x10,%esp
			exit();
  af:	e8 7c 02 00 00       	call   330 <exit>
}

int main(){
	int n,pid[N],op;

	for(n=0;n<N;n++){
  b4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  b8:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
  bc:	7e b9                	jle    77 <main+0x1a>
			op = (n%2);  // operação 0 ou 1
			loop(op);
			exit();
		}
	}
	for(n=0;n<N;n++)
  be:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  c5:	eb 09                	jmp    d0 <main+0x73>
		wait();
  c7:	e8 6c 02 00 00       	call   338 <wait>
			op = (n%2);  // operação 0 ou 1
			loop(op);
			exit();
		}
	}
	for(n=0;n<N;n++)
  cc:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  d0:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
  d4:	7e f1                	jle    c7 <main+0x6a>
		wait();
	exit();
  d6:	e8 55 02 00 00       	call   330 <exit>

000000db <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  db:	55                   	push   %ebp
  dc:	89 e5                	mov    %esp,%ebp
  de:	57                   	push   %edi
  df:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  e0:	8b 4d 08             	mov    0x8(%ebp),%ecx
  e3:	8b 55 10             	mov    0x10(%ebp),%edx
  e6:	8b 45 0c             	mov    0xc(%ebp),%eax
  e9:	89 cb                	mov    %ecx,%ebx
  eb:	89 df                	mov    %ebx,%edi
  ed:	89 d1                	mov    %edx,%ecx
  ef:	fc                   	cld    
  f0:	f3 aa                	rep stos %al,%es:(%edi)
  f2:	89 ca                	mov    %ecx,%edx
  f4:	89 fb                	mov    %edi,%ebx
  f6:	89 5d 08             	mov    %ebx,0x8(%ebp)
  f9:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  fc:	5b                   	pop    %ebx
  fd:	5f                   	pop    %edi
  fe:	5d                   	pop    %ebp
  ff:	c3                   	ret    

00000100 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 106:	8b 45 08             	mov    0x8(%ebp),%eax
 109:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 10c:	90                   	nop
 10d:	8b 45 08             	mov    0x8(%ebp),%eax
 110:	8d 50 01             	lea    0x1(%eax),%edx
 113:	89 55 08             	mov    %edx,0x8(%ebp)
 116:	8b 55 0c             	mov    0xc(%ebp),%edx
 119:	8d 4a 01             	lea    0x1(%edx),%ecx
 11c:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 11f:	0f b6 12             	movzbl (%edx),%edx
 122:	88 10                	mov    %dl,(%eax)
 124:	0f b6 00             	movzbl (%eax),%eax
 127:	84 c0                	test   %al,%al
 129:	75 e2                	jne    10d <strcpy+0xd>
    ;
  return os;
 12b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 12e:	c9                   	leave  
 12f:	c3                   	ret    

00000130 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 130:	55                   	push   %ebp
 131:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 133:	eb 08                	jmp    13d <strcmp+0xd>
    p++, q++;
 135:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 139:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 13d:	8b 45 08             	mov    0x8(%ebp),%eax
 140:	0f b6 00             	movzbl (%eax),%eax
 143:	84 c0                	test   %al,%al
 145:	74 10                	je     157 <strcmp+0x27>
 147:	8b 45 08             	mov    0x8(%ebp),%eax
 14a:	0f b6 10             	movzbl (%eax),%edx
 14d:	8b 45 0c             	mov    0xc(%ebp),%eax
 150:	0f b6 00             	movzbl (%eax),%eax
 153:	38 c2                	cmp    %al,%dl
 155:	74 de                	je     135 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 157:	8b 45 08             	mov    0x8(%ebp),%eax
 15a:	0f b6 00             	movzbl (%eax),%eax
 15d:	0f b6 d0             	movzbl %al,%edx
 160:	8b 45 0c             	mov    0xc(%ebp),%eax
 163:	0f b6 00             	movzbl (%eax),%eax
 166:	0f b6 c0             	movzbl %al,%eax
 169:	29 c2                	sub    %eax,%edx
 16b:	89 d0                	mov    %edx,%eax
}
 16d:	5d                   	pop    %ebp
 16e:	c3                   	ret    

0000016f <strlen>:

uint
strlen(char *s)
{
 16f:	55                   	push   %ebp
 170:	89 e5                	mov    %esp,%ebp
 172:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 175:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 17c:	eb 04                	jmp    182 <strlen+0x13>
 17e:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 182:	8b 55 fc             	mov    -0x4(%ebp),%edx
 185:	8b 45 08             	mov    0x8(%ebp),%eax
 188:	01 d0                	add    %edx,%eax
 18a:	0f b6 00             	movzbl (%eax),%eax
 18d:	84 c0                	test   %al,%al
 18f:	75 ed                	jne    17e <strlen+0xf>
    ;
  return n;
 191:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 194:	c9                   	leave  
 195:	c3                   	ret    

00000196 <memset>:

void*
memset(void *dst, int c, uint n)
{
 196:	55                   	push   %ebp
 197:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 199:	8b 45 10             	mov    0x10(%ebp),%eax
 19c:	50                   	push   %eax
 19d:	ff 75 0c             	pushl  0xc(%ebp)
 1a0:	ff 75 08             	pushl  0x8(%ebp)
 1a3:	e8 33 ff ff ff       	call   db <stosb>
 1a8:	83 c4 0c             	add    $0xc,%esp
  return dst;
 1ab:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1ae:	c9                   	leave  
 1af:	c3                   	ret    

000001b0 <strchr>:

char*
strchr(const char *s, char c)
{
 1b0:	55                   	push   %ebp
 1b1:	89 e5                	mov    %esp,%ebp
 1b3:	83 ec 04             	sub    $0x4,%esp
 1b6:	8b 45 0c             	mov    0xc(%ebp),%eax
 1b9:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 1bc:	eb 14                	jmp    1d2 <strchr+0x22>
    if(*s == c)
 1be:	8b 45 08             	mov    0x8(%ebp),%eax
 1c1:	0f b6 00             	movzbl (%eax),%eax
 1c4:	3a 45 fc             	cmp    -0x4(%ebp),%al
 1c7:	75 05                	jne    1ce <strchr+0x1e>
      return (char*)s;
 1c9:	8b 45 08             	mov    0x8(%ebp),%eax
 1cc:	eb 13                	jmp    1e1 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 1ce:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 1d2:	8b 45 08             	mov    0x8(%ebp),%eax
 1d5:	0f b6 00             	movzbl (%eax),%eax
 1d8:	84 c0                	test   %al,%al
 1da:	75 e2                	jne    1be <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 1dc:	b8 00 00 00 00       	mov    $0x0,%eax
}
 1e1:	c9                   	leave  
 1e2:	c3                   	ret    

000001e3 <gets>:

char*
gets(char *buf, int max)
{
 1e3:	55                   	push   %ebp
 1e4:	89 e5                	mov    %esp,%ebp
 1e6:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1e9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 1f0:	eb 44                	jmp    236 <gets+0x53>
    cc = read(0, &c, 1);
 1f2:	83 ec 04             	sub    $0x4,%esp
 1f5:	6a 01                	push   $0x1
 1f7:	8d 45 ef             	lea    -0x11(%ebp),%eax
 1fa:	50                   	push   %eax
 1fb:	6a 00                	push   $0x0
 1fd:	e8 46 01 00 00       	call   348 <read>
 202:	83 c4 10             	add    $0x10,%esp
 205:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 208:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 20c:	7f 02                	jg     210 <gets+0x2d>
      break;
 20e:	eb 31                	jmp    241 <gets+0x5e>
    buf[i++] = c;
 210:	8b 45 f4             	mov    -0xc(%ebp),%eax
 213:	8d 50 01             	lea    0x1(%eax),%edx
 216:	89 55 f4             	mov    %edx,-0xc(%ebp)
 219:	89 c2                	mov    %eax,%edx
 21b:	8b 45 08             	mov    0x8(%ebp),%eax
 21e:	01 c2                	add    %eax,%edx
 220:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 224:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 226:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 22a:	3c 0a                	cmp    $0xa,%al
 22c:	74 13                	je     241 <gets+0x5e>
 22e:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 232:	3c 0d                	cmp    $0xd,%al
 234:	74 0b                	je     241 <gets+0x5e>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 236:	8b 45 f4             	mov    -0xc(%ebp),%eax
 239:	83 c0 01             	add    $0x1,%eax
 23c:	3b 45 0c             	cmp    0xc(%ebp),%eax
 23f:	7c b1                	jl     1f2 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 241:	8b 55 f4             	mov    -0xc(%ebp),%edx
 244:	8b 45 08             	mov    0x8(%ebp),%eax
 247:	01 d0                	add    %edx,%eax
 249:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 24c:	8b 45 08             	mov    0x8(%ebp),%eax
}
 24f:	c9                   	leave  
 250:	c3                   	ret    

00000251 <stat>:

int
stat(char *n, struct stat *st)
{
 251:	55                   	push   %ebp
 252:	89 e5                	mov    %esp,%ebp
 254:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 257:	83 ec 08             	sub    $0x8,%esp
 25a:	6a 00                	push   $0x0
 25c:	ff 75 08             	pushl  0x8(%ebp)
 25f:	e8 0c 01 00 00       	call   370 <open>
 264:	83 c4 10             	add    $0x10,%esp
 267:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 26a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 26e:	79 07                	jns    277 <stat+0x26>
    return -1;
 270:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 275:	eb 25                	jmp    29c <stat+0x4b>
  r = fstat(fd, st);
 277:	83 ec 08             	sub    $0x8,%esp
 27a:	ff 75 0c             	pushl  0xc(%ebp)
 27d:	ff 75 f4             	pushl  -0xc(%ebp)
 280:	e8 03 01 00 00       	call   388 <fstat>
 285:	83 c4 10             	add    $0x10,%esp
 288:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 28b:	83 ec 0c             	sub    $0xc,%esp
 28e:	ff 75 f4             	pushl  -0xc(%ebp)
 291:	e8 c2 00 00 00       	call   358 <close>
 296:	83 c4 10             	add    $0x10,%esp
  return r;
 299:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 29c:	c9                   	leave  
 29d:	c3                   	ret    

0000029e <atoi>:

int
atoi(const char *s)
{
 29e:	55                   	push   %ebp
 29f:	89 e5                	mov    %esp,%ebp
 2a1:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 2a4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 2ab:	eb 25                	jmp    2d2 <atoi+0x34>
    n = n*10 + *s++ - '0';
 2ad:	8b 55 fc             	mov    -0x4(%ebp),%edx
 2b0:	89 d0                	mov    %edx,%eax
 2b2:	c1 e0 02             	shl    $0x2,%eax
 2b5:	01 d0                	add    %edx,%eax
 2b7:	01 c0                	add    %eax,%eax
 2b9:	89 c1                	mov    %eax,%ecx
 2bb:	8b 45 08             	mov    0x8(%ebp),%eax
 2be:	8d 50 01             	lea    0x1(%eax),%edx
 2c1:	89 55 08             	mov    %edx,0x8(%ebp)
 2c4:	0f b6 00             	movzbl (%eax),%eax
 2c7:	0f be c0             	movsbl %al,%eax
 2ca:	01 c8                	add    %ecx,%eax
 2cc:	83 e8 30             	sub    $0x30,%eax
 2cf:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2d2:	8b 45 08             	mov    0x8(%ebp),%eax
 2d5:	0f b6 00             	movzbl (%eax),%eax
 2d8:	3c 2f                	cmp    $0x2f,%al
 2da:	7e 0a                	jle    2e6 <atoi+0x48>
 2dc:	8b 45 08             	mov    0x8(%ebp),%eax
 2df:	0f b6 00             	movzbl (%eax),%eax
 2e2:	3c 39                	cmp    $0x39,%al
 2e4:	7e c7                	jle    2ad <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 2e6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 2e9:	c9                   	leave  
 2ea:	c3                   	ret    

000002eb <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 2eb:	55                   	push   %ebp
 2ec:	89 e5                	mov    %esp,%ebp
 2ee:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 2f1:	8b 45 08             	mov    0x8(%ebp),%eax
 2f4:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 2f7:	8b 45 0c             	mov    0xc(%ebp),%eax
 2fa:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 2fd:	eb 17                	jmp    316 <memmove+0x2b>
    *dst++ = *src++;
 2ff:	8b 45 fc             	mov    -0x4(%ebp),%eax
 302:	8d 50 01             	lea    0x1(%eax),%edx
 305:	89 55 fc             	mov    %edx,-0x4(%ebp)
 308:	8b 55 f8             	mov    -0x8(%ebp),%edx
 30b:	8d 4a 01             	lea    0x1(%edx),%ecx
 30e:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 311:	0f b6 12             	movzbl (%edx),%edx
 314:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 316:	8b 45 10             	mov    0x10(%ebp),%eax
 319:	8d 50 ff             	lea    -0x1(%eax),%edx
 31c:	89 55 10             	mov    %edx,0x10(%ebp)
 31f:	85 c0                	test   %eax,%eax
 321:	7f dc                	jg     2ff <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 323:	8b 45 08             	mov    0x8(%ebp),%eax
}
 326:	c9                   	leave  
 327:	c3                   	ret    

00000328 <fork>:
 328:	b8 01 00 00 00       	mov    $0x1,%eax
 32d:	cd 40                	int    $0x40
 32f:	c3                   	ret    

00000330 <exit>:
 330:	b8 02 00 00 00       	mov    $0x2,%eax
 335:	cd 40                	int    $0x40
 337:	c3                   	ret    

00000338 <wait>:
 338:	b8 03 00 00 00       	mov    $0x3,%eax
 33d:	cd 40                	int    $0x40
 33f:	c3                   	ret    

00000340 <pipe>:
 340:	b8 04 00 00 00       	mov    $0x4,%eax
 345:	cd 40                	int    $0x40
 347:	c3                   	ret    

00000348 <read>:
 348:	b8 05 00 00 00       	mov    $0x5,%eax
 34d:	cd 40                	int    $0x40
 34f:	c3                   	ret    

00000350 <write>:
 350:	b8 10 00 00 00       	mov    $0x10,%eax
 355:	cd 40                	int    $0x40
 357:	c3                   	ret    

00000358 <close>:
 358:	b8 15 00 00 00       	mov    $0x15,%eax
 35d:	cd 40                	int    $0x40
 35f:	c3                   	ret    

00000360 <kill>:
 360:	b8 06 00 00 00       	mov    $0x6,%eax
 365:	cd 40                	int    $0x40
 367:	c3                   	ret    

00000368 <exec>:
 368:	b8 07 00 00 00       	mov    $0x7,%eax
 36d:	cd 40                	int    $0x40
 36f:	c3                   	ret    

00000370 <open>:
 370:	b8 0f 00 00 00       	mov    $0xf,%eax
 375:	cd 40                	int    $0x40
 377:	c3                   	ret    

00000378 <mknod>:
 378:	b8 11 00 00 00       	mov    $0x11,%eax
 37d:	cd 40                	int    $0x40
 37f:	c3                   	ret    

00000380 <unlink>:
 380:	b8 12 00 00 00       	mov    $0x12,%eax
 385:	cd 40                	int    $0x40
 387:	c3                   	ret    

00000388 <fstat>:
 388:	b8 08 00 00 00       	mov    $0x8,%eax
 38d:	cd 40                	int    $0x40
 38f:	c3                   	ret    

00000390 <link>:
 390:	b8 13 00 00 00       	mov    $0x13,%eax
 395:	cd 40                	int    $0x40
 397:	c3                   	ret    

00000398 <mkdir>:
 398:	b8 14 00 00 00       	mov    $0x14,%eax
 39d:	cd 40                	int    $0x40
 39f:	c3                   	ret    

000003a0 <chdir>:
 3a0:	b8 09 00 00 00       	mov    $0x9,%eax
 3a5:	cd 40                	int    $0x40
 3a7:	c3                   	ret    

000003a8 <dup>:
 3a8:	b8 0a 00 00 00       	mov    $0xa,%eax
 3ad:	cd 40                	int    $0x40
 3af:	c3                   	ret    

000003b0 <getpid>:
 3b0:	b8 0b 00 00 00       	mov    $0xb,%eax
 3b5:	cd 40                	int    $0x40
 3b7:	c3                   	ret    

000003b8 <sbrk>:
 3b8:	b8 0c 00 00 00       	mov    $0xc,%eax
 3bd:	cd 40                	int    $0x40
 3bf:	c3                   	ret    

000003c0 <sleep>:
 3c0:	b8 0d 00 00 00       	mov    $0xd,%eax
 3c5:	cd 40                	int    $0x40
 3c7:	c3                   	ret    

000003c8 <uptime>:
 3c8:	b8 0e 00 00 00       	mov    $0xe,%eax
 3cd:	cd 40                	int    $0x40
 3cf:	c3                   	ret    

000003d0 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 3d0:	55                   	push   %ebp
 3d1:	89 e5                	mov    %esp,%ebp
 3d3:	83 ec 18             	sub    $0x18,%esp
 3d6:	8b 45 0c             	mov    0xc(%ebp),%eax
 3d9:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 3dc:	83 ec 04             	sub    $0x4,%esp
 3df:	6a 01                	push   $0x1
 3e1:	8d 45 f4             	lea    -0xc(%ebp),%eax
 3e4:	50                   	push   %eax
 3e5:	ff 75 08             	pushl  0x8(%ebp)
 3e8:	e8 63 ff ff ff       	call   350 <write>
 3ed:	83 c4 10             	add    $0x10,%esp
}
 3f0:	c9                   	leave  
 3f1:	c3                   	ret    

000003f2 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3f2:	55                   	push   %ebp
 3f3:	89 e5                	mov    %esp,%ebp
 3f5:	53                   	push   %ebx
 3f6:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 3f9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 400:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 404:	74 17                	je     41d <printint+0x2b>
 406:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 40a:	79 11                	jns    41d <printint+0x2b>
    neg = 1;
 40c:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 413:	8b 45 0c             	mov    0xc(%ebp),%eax
 416:	f7 d8                	neg    %eax
 418:	89 45 ec             	mov    %eax,-0x14(%ebp)
 41b:	eb 06                	jmp    423 <printint+0x31>
  } else {
    x = xx;
 41d:	8b 45 0c             	mov    0xc(%ebp),%eax
 420:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 423:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 42a:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 42d:	8d 41 01             	lea    0x1(%ecx),%eax
 430:	89 45 f4             	mov    %eax,-0xc(%ebp)
 433:	8b 5d 10             	mov    0x10(%ebp),%ebx
 436:	8b 45 ec             	mov    -0x14(%ebp),%eax
 439:	ba 00 00 00 00       	mov    $0x0,%edx
 43e:	f7 f3                	div    %ebx
 440:	89 d0                	mov    %edx,%eax
 442:	0f b6 80 c8 0a 00 00 	movzbl 0xac8(%eax),%eax
 449:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 44d:	8b 5d 10             	mov    0x10(%ebp),%ebx
 450:	8b 45 ec             	mov    -0x14(%ebp),%eax
 453:	ba 00 00 00 00       	mov    $0x0,%edx
 458:	f7 f3                	div    %ebx
 45a:	89 45 ec             	mov    %eax,-0x14(%ebp)
 45d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 461:	75 c7                	jne    42a <printint+0x38>
  if(neg)
 463:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 467:	74 0e                	je     477 <printint+0x85>
    buf[i++] = '-';
 469:	8b 45 f4             	mov    -0xc(%ebp),%eax
 46c:	8d 50 01             	lea    0x1(%eax),%edx
 46f:	89 55 f4             	mov    %edx,-0xc(%ebp)
 472:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 477:	eb 1d                	jmp    496 <printint+0xa4>
    putc(fd, buf[i]);
 479:	8d 55 dc             	lea    -0x24(%ebp),%edx
 47c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 47f:	01 d0                	add    %edx,%eax
 481:	0f b6 00             	movzbl (%eax),%eax
 484:	0f be c0             	movsbl %al,%eax
 487:	83 ec 08             	sub    $0x8,%esp
 48a:	50                   	push   %eax
 48b:	ff 75 08             	pushl  0x8(%ebp)
 48e:	e8 3d ff ff ff       	call   3d0 <putc>
 493:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 496:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 49a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 49e:	79 d9                	jns    479 <printint+0x87>
    putc(fd, buf[i]);
}
 4a0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 4a3:	c9                   	leave  
 4a4:	c3                   	ret    

000004a5 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4a5:	55                   	push   %ebp
 4a6:	89 e5                	mov    %esp,%ebp
 4a8:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 4ab:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 4b2:	8d 45 0c             	lea    0xc(%ebp),%eax
 4b5:	83 c0 04             	add    $0x4,%eax
 4b8:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 4bb:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 4c2:	e9 59 01 00 00       	jmp    620 <printf+0x17b>
    c = fmt[i] & 0xff;
 4c7:	8b 55 0c             	mov    0xc(%ebp),%edx
 4ca:	8b 45 f0             	mov    -0x10(%ebp),%eax
 4cd:	01 d0                	add    %edx,%eax
 4cf:	0f b6 00             	movzbl (%eax),%eax
 4d2:	0f be c0             	movsbl %al,%eax
 4d5:	25 ff 00 00 00       	and    $0xff,%eax
 4da:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 4dd:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4e1:	75 2c                	jne    50f <printf+0x6a>
      if(c == '%'){
 4e3:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 4e7:	75 0c                	jne    4f5 <printf+0x50>
        state = '%';
 4e9:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 4f0:	e9 27 01 00 00       	jmp    61c <printf+0x177>
      } else {
        putc(fd, c);
 4f5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 4f8:	0f be c0             	movsbl %al,%eax
 4fb:	83 ec 08             	sub    $0x8,%esp
 4fe:	50                   	push   %eax
 4ff:	ff 75 08             	pushl  0x8(%ebp)
 502:	e8 c9 fe ff ff       	call   3d0 <putc>
 507:	83 c4 10             	add    $0x10,%esp
 50a:	e9 0d 01 00 00       	jmp    61c <printf+0x177>
      }
    } else if(state == '%'){
 50f:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 513:	0f 85 03 01 00 00    	jne    61c <printf+0x177>
      if(c == 'd'){
 519:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 51d:	75 1e                	jne    53d <printf+0x98>
        printint(fd, *ap, 10, 1);
 51f:	8b 45 e8             	mov    -0x18(%ebp),%eax
 522:	8b 00                	mov    (%eax),%eax
 524:	6a 01                	push   $0x1
 526:	6a 0a                	push   $0xa
 528:	50                   	push   %eax
 529:	ff 75 08             	pushl  0x8(%ebp)
 52c:	e8 c1 fe ff ff       	call   3f2 <printint>
 531:	83 c4 10             	add    $0x10,%esp
        ap++;
 534:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 538:	e9 d8 00 00 00       	jmp    615 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 53d:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 541:	74 06                	je     549 <printf+0xa4>
 543:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 547:	75 1e                	jne    567 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 549:	8b 45 e8             	mov    -0x18(%ebp),%eax
 54c:	8b 00                	mov    (%eax),%eax
 54e:	6a 00                	push   $0x0
 550:	6a 10                	push   $0x10
 552:	50                   	push   %eax
 553:	ff 75 08             	pushl  0x8(%ebp)
 556:	e8 97 fe ff ff       	call   3f2 <printint>
 55b:	83 c4 10             	add    $0x10,%esp
        ap++;
 55e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 562:	e9 ae 00 00 00       	jmp    615 <printf+0x170>
      } else if(c == 's'){
 567:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 56b:	75 43                	jne    5b0 <printf+0x10b>
        s = (char*)*ap;
 56d:	8b 45 e8             	mov    -0x18(%ebp),%eax
 570:	8b 00                	mov    (%eax),%eax
 572:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 575:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 579:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 57d:	75 07                	jne    586 <printf+0xe1>
          s = "(null)";
 57f:	c7 45 f4 59 08 00 00 	movl   $0x859,-0xc(%ebp)
        while(*s != 0){
 586:	eb 1c                	jmp    5a4 <printf+0xff>
          putc(fd, *s);
 588:	8b 45 f4             	mov    -0xc(%ebp),%eax
 58b:	0f b6 00             	movzbl (%eax),%eax
 58e:	0f be c0             	movsbl %al,%eax
 591:	83 ec 08             	sub    $0x8,%esp
 594:	50                   	push   %eax
 595:	ff 75 08             	pushl  0x8(%ebp)
 598:	e8 33 fe ff ff       	call   3d0 <putc>
 59d:	83 c4 10             	add    $0x10,%esp
          s++;
 5a0:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 5a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5a7:	0f b6 00             	movzbl (%eax),%eax
 5aa:	84 c0                	test   %al,%al
 5ac:	75 da                	jne    588 <printf+0xe3>
 5ae:	eb 65                	jmp    615 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5b0:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 5b4:	75 1d                	jne    5d3 <printf+0x12e>
        putc(fd, *ap);
 5b6:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5b9:	8b 00                	mov    (%eax),%eax
 5bb:	0f be c0             	movsbl %al,%eax
 5be:	83 ec 08             	sub    $0x8,%esp
 5c1:	50                   	push   %eax
 5c2:	ff 75 08             	pushl  0x8(%ebp)
 5c5:	e8 06 fe ff ff       	call   3d0 <putc>
 5ca:	83 c4 10             	add    $0x10,%esp
        ap++;
 5cd:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5d1:	eb 42                	jmp    615 <printf+0x170>
      } else if(c == '%'){
 5d3:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5d7:	75 17                	jne    5f0 <printf+0x14b>
        putc(fd, c);
 5d9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5dc:	0f be c0             	movsbl %al,%eax
 5df:	83 ec 08             	sub    $0x8,%esp
 5e2:	50                   	push   %eax
 5e3:	ff 75 08             	pushl  0x8(%ebp)
 5e6:	e8 e5 fd ff ff       	call   3d0 <putc>
 5eb:	83 c4 10             	add    $0x10,%esp
 5ee:	eb 25                	jmp    615 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5f0:	83 ec 08             	sub    $0x8,%esp
 5f3:	6a 25                	push   $0x25
 5f5:	ff 75 08             	pushl  0x8(%ebp)
 5f8:	e8 d3 fd ff ff       	call   3d0 <putc>
 5fd:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 600:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 603:	0f be c0             	movsbl %al,%eax
 606:	83 ec 08             	sub    $0x8,%esp
 609:	50                   	push   %eax
 60a:	ff 75 08             	pushl  0x8(%ebp)
 60d:	e8 be fd ff ff       	call   3d0 <putc>
 612:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 615:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 61c:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 620:	8b 55 0c             	mov    0xc(%ebp),%edx
 623:	8b 45 f0             	mov    -0x10(%ebp),%eax
 626:	01 d0                	add    %edx,%eax
 628:	0f b6 00             	movzbl (%eax),%eax
 62b:	84 c0                	test   %al,%al
 62d:	0f 85 94 fe ff ff    	jne    4c7 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 633:	c9                   	leave  
 634:	c3                   	ret    

00000635 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 635:	55                   	push   %ebp
 636:	89 e5                	mov    %esp,%ebp
 638:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 63b:	8b 45 08             	mov    0x8(%ebp),%eax
 63e:	83 e8 08             	sub    $0x8,%eax
 641:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 644:	a1 e4 0a 00 00       	mov    0xae4,%eax
 649:	89 45 fc             	mov    %eax,-0x4(%ebp)
 64c:	eb 24                	jmp    672 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 64e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 651:	8b 00                	mov    (%eax),%eax
 653:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 656:	77 12                	ja     66a <free+0x35>
 658:	8b 45 f8             	mov    -0x8(%ebp),%eax
 65b:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 65e:	77 24                	ja     684 <free+0x4f>
 660:	8b 45 fc             	mov    -0x4(%ebp),%eax
 663:	8b 00                	mov    (%eax),%eax
 665:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 668:	77 1a                	ja     684 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 66a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 66d:	8b 00                	mov    (%eax),%eax
 66f:	89 45 fc             	mov    %eax,-0x4(%ebp)
 672:	8b 45 f8             	mov    -0x8(%ebp),%eax
 675:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 678:	76 d4                	jbe    64e <free+0x19>
 67a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 67d:	8b 00                	mov    (%eax),%eax
 67f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 682:	76 ca                	jbe    64e <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 684:	8b 45 f8             	mov    -0x8(%ebp),%eax
 687:	8b 40 04             	mov    0x4(%eax),%eax
 68a:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 691:	8b 45 f8             	mov    -0x8(%ebp),%eax
 694:	01 c2                	add    %eax,%edx
 696:	8b 45 fc             	mov    -0x4(%ebp),%eax
 699:	8b 00                	mov    (%eax),%eax
 69b:	39 c2                	cmp    %eax,%edx
 69d:	75 24                	jne    6c3 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 69f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6a2:	8b 50 04             	mov    0x4(%eax),%edx
 6a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a8:	8b 00                	mov    (%eax),%eax
 6aa:	8b 40 04             	mov    0x4(%eax),%eax
 6ad:	01 c2                	add    %eax,%edx
 6af:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6b2:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 6b5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6b8:	8b 00                	mov    (%eax),%eax
 6ba:	8b 10                	mov    (%eax),%edx
 6bc:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6bf:	89 10                	mov    %edx,(%eax)
 6c1:	eb 0a                	jmp    6cd <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 6c3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6c6:	8b 10                	mov    (%eax),%edx
 6c8:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6cb:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 6cd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6d0:	8b 40 04             	mov    0x4(%eax),%eax
 6d3:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6da:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6dd:	01 d0                	add    %edx,%eax
 6df:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6e2:	75 20                	jne    704 <free+0xcf>
    p->s.size += bp->s.size;
 6e4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6e7:	8b 50 04             	mov    0x4(%eax),%edx
 6ea:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6ed:	8b 40 04             	mov    0x4(%eax),%eax
 6f0:	01 c2                	add    %eax,%edx
 6f2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6f5:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 6f8:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6fb:	8b 10                	mov    (%eax),%edx
 6fd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 700:	89 10                	mov    %edx,(%eax)
 702:	eb 08                	jmp    70c <free+0xd7>
  } else
    p->s.ptr = bp;
 704:	8b 45 fc             	mov    -0x4(%ebp),%eax
 707:	8b 55 f8             	mov    -0x8(%ebp),%edx
 70a:	89 10                	mov    %edx,(%eax)
  freep = p;
 70c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 70f:	a3 e4 0a 00 00       	mov    %eax,0xae4
}
 714:	c9                   	leave  
 715:	c3                   	ret    

00000716 <morecore>:

static Header*
morecore(uint nu)
{
 716:	55                   	push   %ebp
 717:	89 e5                	mov    %esp,%ebp
 719:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 71c:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 723:	77 07                	ja     72c <morecore+0x16>
    nu = 4096;
 725:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 72c:	8b 45 08             	mov    0x8(%ebp),%eax
 72f:	c1 e0 03             	shl    $0x3,%eax
 732:	83 ec 0c             	sub    $0xc,%esp
 735:	50                   	push   %eax
 736:	e8 7d fc ff ff       	call   3b8 <sbrk>
 73b:	83 c4 10             	add    $0x10,%esp
 73e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 741:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 745:	75 07                	jne    74e <morecore+0x38>
    return 0;
 747:	b8 00 00 00 00       	mov    $0x0,%eax
 74c:	eb 26                	jmp    774 <morecore+0x5e>
  hp = (Header*)p;
 74e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 751:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 754:	8b 45 f0             	mov    -0x10(%ebp),%eax
 757:	8b 55 08             	mov    0x8(%ebp),%edx
 75a:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 75d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 760:	83 c0 08             	add    $0x8,%eax
 763:	83 ec 0c             	sub    $0xc,%esp
 766:	50                   	push   %eax
 767:	e8 c9 fe ff ff       	call   635 <free>
 76c:	83 c4 10             	add    $0x10,%esp
  return freep;
 76f:	a1 e4 0a 00 00       	mov    0xae4,%eax
}
 774:	c9                   	leave  
 775:	c3                   	ret    

00000776 <malloc>:

void*
malloc(uint nbytes)
{
 776:	55                   	push   %ebp
 777:	89 e5                	mov    %esp,%ebp
 779:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 77c:	8b 45 08             	mov    0x8(%ebp),%eax
 77f:	83 c0 07             	add    $0x7,%eax
 782:	c1 e8 03             	shr    $0x3,%eax
 785:	83 c0 01             	add    $0x1,%eax
 788:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 78b:	a1 e4 0a 00 00       	mov    0xae4,%eax
 790:	89 45 f0             	mov    %eax,-0x10(%ebp)
 793:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 797:	75 23                	jne    7bc <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 799:	c7 45 f0 dc 0a 00 00 	movl   $0xadc,-0x10(%ebp)
 7a0:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7a3:	a3 e4 0a 00 00       	mov    %eax,0xae4
 7a8:	a1 e4 0a 00 00       	mov    0xae4,%eax
 7ad:	a3 dc 0a 00 00       	mov    %eax,0xadc
    base.s.size = 0;
 7b2:	c7 05 e0 0a 00 00 00 	movl   $0x0,0xae0
 7b9:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7bc:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7bf:	8b 00                	mov    (%eax),%eax
 7c1:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 7c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7c7:	8b 40 04             	mov    0x4(%eax),%eax
 7ca:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7cd:	72 4d                	jb     81c <malloc+0xa6>
      if(p->s.size == nunits)
 7cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7d2:	8b 40 04             	mov    0x4(%eax),%eax
 7d5:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7d8:	75 0c                	jne    7e6 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 7da:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7dd:	8b 10                	mov    (%eax),%edx
 7df:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7e2:	89 10                	mov    %edx,(%eax)
 7e4:	eb 26                	jmp    80c <malloc+0x96>
      else {
        p->s.size -= nunits;
 7e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7e9:	8b 40 04             	mov    0x4(%eax),%eax
 7ec:	2b 45 ec             	sub    -0x14(%ebp),%eax
 7ef:	89 c2                	mov    %eax,%edx
 7f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7f4:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 7f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7fa:	8b 40 04             	mov    0x4(%eax),%eax
 7fd:	c1 e0 03             	shl    $0x3,%eax
 800:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 803:	8b 45 f4             	mov    -0xc(%ebp),%eax
 806:	8b 55 ec             	mov    -0x14(%ebp),%edx
 809:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 80c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 80f:	a3 e4 0a 00 00       	mov    %eax,0xae4
      return (void*)(p + 1);
 814:	8b 45 f4             	mov    -0xc(%ebp),%eax
 817:	83 c0 08             	add    $0x8,%eax
 81a:	eb 3b                	jmp    857 <malloc+0xe1>
    }
    if(p == freep)
 81c:	a1 e4 0a 00 00       	mov    0xae4,%eax
 821:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 824:	75 1e                	jne    844 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 826:	83 ec 0c             	sub    $0xc,%esp
 829:	ff 75 ec             	pushl  -0x14(%ebp)
 82c:	e8 e5 fe ff ff       	call   716 <morecore>
 831:	83 c4 10             	add    $0x10,%esp
 834:	89 45 f4             	mov    %eax,-0xc(%ebp)
 837:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 83b:	75 07                	jne    844 <malloc+0xce>
        return 0;
 83d:	b8 00 00 00 00       	mov    $0x0,%eax
 842:	eb 13                	jmp    857 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 844:	8b 45 f4             	mov    -0xc(%ebp),%eax
 847:	89 45 f0             	mov    %eax,-0x10(%ebp)
 84a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 84d:	8b 00                	mov    (%eax),%eax
 84f:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 852:	e9 6d ff ff ff       	jmp    7c4 <malloc+0x4e>
}
 857:	c9                   	leave  
 858:	c3                   	ret    
