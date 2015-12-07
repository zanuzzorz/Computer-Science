
_teste: formato do arquivo elf32-i386


Desmontagem da seção .text:

00000000 <loop>:
#define MAX 99999999
#define MED 999999
#define MIN 100
#define N  20

void loop(int n){
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 ec 10             	sub    $0x10,%esp
	int x,y;
	
	if(n == 2 ) y=MAX;  
   6:	83 7d 08 02          	cmpl   $0x2,0x8(%ebp)
   a:	75 09                	jne    15 <loop+0x15>
   c:	c7 45 f8 ff e0 f5 05 	movl   $0x5f5e0ff,-0x8(%ebp)
  13:	eb 16                	jmp    2b <loop+0x2b>
	else if(n) y=MED;  
  15:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  19:	74 09                	je     24 <loop+0x24>
  1b:	c7 45 f8 3f 42 0f 00 	movl   $0xf423f,-0x8(%ebp)
  22:	eb 07                	jmp    2b <loop+0x2b>
	else  y=MIN;
  24:	c7 45 f8 64 00 00 00 	movl   $0x64,-0x8(%ebp)
	
	for(x=0; x<y; x++)
  2b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  32:	eb 2e                	jmp    62 <loop+0x62>
		for(x=0; x<y; x++)
  34:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  3b:	eb 19                	jmp    56 <loop+0x56>
			for(x=0; x<y; x++){}
  3d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  44:	eb 04                	jmp    4a <loop+0x4a>
  46:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  4a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  4d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  50:	7c f4                	jl     46 <loop+0x46>
	if(n == 2 ) y=MAX;  
	else if(n) y=MED;  
	else  y=MIN;
	
	for(x=0; x<y; x++)
		for(x=0; x<y; x++)
  52:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  56:	8b 45 fc             	mov    -0x4(%ebp),%eax
  59:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  5c:	7c df                	jl     3d <loop+0x3d>
	
	if(n == 2 ) y=MAX;  
	else if(n) y=MED;  
	else  y=MIN;
	
	for(x=0; x<y; x++)
  5e:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  62:	8b 45 fc             	mov    -0x4(%ebp),%eax
  65:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  68:	7c ca                	jl     34 <loop+0x34>
		for(x=0; x<y; x++)
			for(x=0; x<y; x++){}
}
  6a:	90                   	nop
  6b:	c9                   	leave  
  6c:	c3                   	ret    

0000006d <main>:

int main(){
  6d:	8d 4c 24 04          	lea    0x4(%esp),%ecx
  71:	83 e4 f0             	and    $0xfffffff0,%esp
  74:	ff 71 fc             	pushl  -0x4(%ecx)
  77:	55                   	push   %ebp
  78:	89 e5                	mov    %esp,%ebp
  7a:	51                   	push   %ecx
  7b:	83 ec 64             	sub    $0x64,%esp
	int n,pid[N],op;

	for(n=0;n<N;n++){
  7e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  85:	eb 50                	jmp    d7 <main+0x6a>
		pid[n] = fork();
  87:	e8 bb 02 00 00       	call   347 <fork>
  8c:	89 c2                	mov    %eax,%edx
  8e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  91:	89 54 85 a0          	mov    %edx,-0x60(%ebp,%eax,4)
		if (pid[n] == 0){
  95:	8b 45 f4             	mov    -0xc(%ebp),%eax
  98:	8b 44 85 a0          	mov    -0x60(%ebp,%eax,4),%eax
  9c:	85 c0                	test   %eax,%eax
  9e:	75 33                	jne    d3 <main+0x66>
			op = (n%3);  // operação 0, 1 ou 2
  a0:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  a3:	ba 56 55 55 55       	mov    $0x55555556,%edx
  a8:	89 c8                	mov    %ecx,%eax
  aa:	f7 ea                	imul   %edx
  ac:	89 c8                	mov    %ecx,%eax
  ae:	c1 f8 1f             	sar    $0x1f,%eax
  b1:	29 c2                	sub    %eax,%edx
  b3:	89 d0                	mov    %edx,%eax
  b5:	01 c0                	add    %eax,%eax
  b7:	01 d0                	add    %edx,%eax
  b9:	29 c1                	sub    %eax,%ecx
  bb:	89 c8                	mov    %ecx,%eax
  bd:	89 45 f0             	mov    %eax,-0x10(%ebp)
			loop(op);
  c0:	83 ec 0c             	sub    $0xc,%esp
  c3:	ff 75 f0             	pushl  -0x10(%ebp)
  c6:	e8 35 ff ff ff       	call   0 <loop>
  cb:	83 c4 10             	add    $0x10,%esp
			exit();
  ce:	e8 7c 02 00 00       	call   34f <exit>
}

int main(){
	int n,pid[N],op;

	for(n=0;n<N;n++){
  d3:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  d7:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
  db:	7e aa                	jle    87 <main+0x1a>
			op = (n%3);  // operação 0, 1 ou 2
			loop(op);
			exit();
		}
	}
	for(n=0;n<N;n++)
  dd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  e4:	eb 09                	jmp    ef <main+0x82>
		wait();
  e6:	e8 6c 02 00 00       	call   357 <wait>
			op = (n%3);  // operação 0, 1 ou 2
			loop(op);
			exit();
		}
	}
	for(n=0;n<N;n++)
  eb:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  ef:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
  f3:	7e f1                	jle    e6 <main+0x79>
		wait();
	exit();
  f5:	e8 55 02 00 00       	call   34f <exit>

000000fa <stosb>:
  fa:	55                   	push   %ebp
  fb:	89 e5                	mov    %esp,%ebp
  fd:	57                   	push   %edi
  fe:	53                   	push   %ebx
  ff:	8b 4d 08             	mov    0x8(%ebp),%ecx
 102:	8b 55 10             	mov    0x10(%ebp),%edx
 105:	8b 45 0c             	mov    0xc(%ebp),%eax
 108:	89 cb                	mov    %ecx,%ebx
 10a:	89 df                	mov    %ebx,%edi
 10c:	89 d1                	mov    %edx,%ecx
 10e:	fc                   	cld    
 10f:	f3 aa                	rep stos %al,%es:(%edi)
 111:	89 ca                	mov    %ecx,%edx
 113:	89 fb                	mov    %edi,%ebx
 115:	89 5d 08             	mov    %ebx,0x8(%ebp)
 118:	89 55 10             	mov    %edx,0x10(%ebp)
 11b:	5b                   	pop    %ebx
 11c:	5f                   	pop    %edi
 11d:	5d                   	pop    %ebp
 11e:	c3                   	ret    

0000011f <strcpy>:
 11f:	55                   	push   %ebp
 120:	89 e5                	mov    %esp,%ebp
 122:	83 ec 10             	sub    $0x10,%esp
 125:	8b 45 08             	mov    0x8(%ebp),%eax
 128:	89 45 fc             	mov    %eax,-0x4(%ebp)
 12b:	90                   	nop
 12c:	8b 45 08             	mov    0x8(%ebp),%eax
 12f:	8d 50 01             	lea    0x1(%eax),%edx
 132:	89 55 08             	mov    %edx,0x8(%ebp)
 135:	8b 55 0c             	mov    0xc(%ebp),%edx
 138:	8d 4a 01             	lea    0x1(%edx),%ecx
 13b:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 13e:	0f b6 12             	movzbl (%edx),%edx
 141:	88 10                	mov    %dl,(%eax)
 143:	0f b6 00             	movzbl (%eax),%eax
 146:	84 c0                	test   %al,%al
 148:	75 e2                	jne    12c <strcpy+0xd>
 14a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 14d:	c9                   	leave  
 14e:	c3                   	ret    

0000014f <strcmp>:
 14f:	55                   	push   %ebp
 150:	89 e5                	mov    %esp,%ebp
 152:	eb 08                	jmp    15c <strcmp+0xd>
 154:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 158:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
 15c:	8b 45 08             	mov    0x8(%ebp),%eax
 15f:	0f b6 00             	movzbl (%eax),%eax
 162:	84 c0                	test   %al,%al
 164:	74 10                	je     176 <strcmp+0x27>
 166:	8b 45 08             	mov    0x8(%ebp),%eax
 169:	0f b6 10             	movzbl (%eax),%edx
 16c:	8b 45 0c             	mov    0xc(%ebp),%eax
 16f:	0f b6 00             	movzbl (%eax),%eax
 172:	38 c2                	cmp    %al,%dl
 174:	74 de                	je     154 <strcmp+0x5>
 176:	8b 45 08             	mov    0x8(%ebp),%eax
 179:	0f b6 00             	movzbl (%eax),%eax
 17c:	0f b6 d0             	movzbl %al,%edx
 17f:	8b 45 0c             	mov    0xc(%ebp),%eax
 182:	0f b6 00             	movzbl (%eax),%eax
 185:	0f b6 c0             	movzbl %al,%eax
 188:	29 c2                	sub    %eax,%edx
 18a:	89 d0                	mov    %edx,%eax
 18c:	5d                   	pop    %ebp
 18d:	c3                   	ret    

0000018e <strlen>:
 18e:	55                   	push   %ebp
 18f:	89 e5                	mov    %esp,%ebp
 191:	83 ec 10             	sub    $0x10,%esp
 194:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 19b:	eb 04                	jmp    1a1 <strlen+0x13>
 19d:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 1a1:	8b 55 fc             	mov    -0x4(%ebp),%edx
 1a4:	8b 45 08             	mov    0x8(%ebp),%eax
 1a7:	01 d0                	add    %edx,%eax
 1a9:	0f b6 00             	movzbl (%eax),%eax
 1ac:	84 c0                	test   %al,%al
 1ae:	75 ed                	jne    19d <strlen+0xf>
 1b0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 1b3:	c9                   	leave  
 1b4:	c3                   	ret    

000001b5 <memset>:
 1b5:	55                   	push   %ebp
 1b6:	89 e5                	mov    %esp,%ebp
 1b8:	8b 45 10             	mov    0x10(%ebp),%eax
 1bb:	50                   	push   %eax
 1bc:	ff 75 0c             	pushl  0xc(%ebp)
 1bf:	ff 75 08             	pushl  0x8(%ebp)
 1c2:	e8 33 ff ff ff       	call   fa <stosb>
 1c7:	83 c4 0c             	add    $0xc,%esp
 1ca:	8b 45 08             	mov    0x8(%ebp),%eax
 1cd:	c9                   	leave  
 1ce:	c3                   	ret    

000001cf <strchr>:
 1cf:	55                   	push   %ebp
 1d0:	89 e5                	mov    %esp,%ebp
 1d2:	83 ec 04             	sub    $0x4,%esp
 1d5:	8b 45 0c             	mov    0xc(%ebp),%eax
 1d8:	88 45 fc             	mov    %al,-0x4(%ebp)
 1db:	eb 14                	jmp    1f1 <strchr+0x22>
 1dd:	8b 45 08             	mov    0x8(%ebp),%eax
 1e0:	0f b6 00             	movzbl (%eax),%eax
 1e3:	3a 45 fc             	cmp    -0x4(%ebp),%al
 1e6:	75 05                	jne    1ed <strchr+0x1e>
 1e8:	8b 45 08             	mov    0x8(%ebp),%eax
 1eb:	eb 13                	jmp    200 <strchr+0x31>
 1ed:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 1f1:	8b 45 08             	mov    0x8(%ebp),%eax
 1f4:	0f b6 00             	movzbl (%eax),%eax
 1f7:	84 c0                	test   %al,%al
 1f9:	75 e2                	jne    1dd <strchr+0xe>
 1fb:	b8 00 00 00 00       	mov    $0x0,%eax
 200:	c9                   	leave  
 201:	c3                   	ret    

00000202 <gets>:
 202:	55                   	push   %ebp
 203:	89 e5                	mov    %esp,%ebp
 205:	83 ec 18             	sub    $0x18,%esp
 208:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 20f:	eb 44                	jmp    255 <gets+0x53>
 211:	83 ec 04             	sub    $0x4,%esp
 214:	6a 01                	push   $0x1
 216:	8d 45 ef             	lea    -0x11(%ebp),%eax
 219:	50                   	push   %eax
 21a:	6a 00                	push   $0x0
 21c:	e8 46 01 00 00       	call   367 <read>
 221:	83 c4 10             	add    $0x10,%esp
 224:	89 45 f0             	mov    %eax,-0x10(%ebp)
 227:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 22b:	7f 02                	jg     22f <gets+0x2d>
 22d:	eb 31                	jmp    260 <gets+0x5e>
 22f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 232:	8d 50 01             	lea    0x1(%eax),%edx
 235:	89 55 f4             	mov    %edx,-0xc(%ebp)
 238:	89 c2                	mov    %eax,%edx
 23a:	8b 45 08             	mov    0x8(%ebp),%eax
 23d:	01 c2                	add    %eax,%edx
 23f:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 243:	88 02                	mov    %al,(%edx)
 245:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 249:	3c 0a                	cmp    $0xa,%al
 24b:	74 13                	je     260 <gets+0x5e>
 24d:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 251:	3c 0d                	cmp    $0xd,%al
 253:	74 0b                	je     260 <gets+0x5e>
 255:	8b 45 f4             	mov    -0xc(%ebp),%eax
 258:	83 c0 01             	add    $0x1,%eax
 25b:	3b 45 0c             	cmp    0xc(%ebp),%eax
 25e:	7c b1                	jl     211 <gets+0xf>
 260:	8b 55 f4             	mov    -0xc(%ebp),%edx
 263:	8b 45 08             	mov    0x8(%ebp),%eax
 266:	01 d0                	add    %edx,%eax
 268:	c6 00 00             	movb   $0x0,(%eax)
 26b:	8b 45 08             	mov    0x8(%ebp),%eax
 26e:	c9                   	leave  
 26f:	c3                   	ret    

00000270 <stat>:
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
 273:	83 ec 18             	sub    $0x18,%esp
 276:	83 ec 08             	sub    $0x8,%esp
 279:	6a 00                	push   $0x0
 27b:	ff 75 08             	pushl  0x8(%ebp)
 27e:	e8 0c 01 00 00       	call   38f <open>
 283:	83 c4 10             	add    $0x10,%esp
 286:	89 45 f4             	mov    %eax,-0xc(%ebp)
 289:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 28d:	79 07                	jns    296 <stat+0x26>
 28f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 294:	eb 25                	jmp    2bb <stat+0x4b>
 296:	83 ec 08             	sub    $0x8,%esp
 299:	ff 75 0c             	pushl  0xc(%ebp)
 29c:	ff 75 f4             	pushl  -0xc(%ebp)
 29f:	e8 03 01 00 00       	call   3a7 <fstat>
 2a4:	83 c4 10             	add    $0x10,%esp
 2a7:	89 45 f0             	mov    %eax,-0x10(%ebp)
 2aa:	83 ec 0c             	sub    $0xc,%esp
 2ad:	ff 75 f4             	pushl  -0xc(%ebp)
 2b0:	e8 c2 00 00 00       	call   377 <close>
 2b5:	83 c4 10             	add    $0x10,%esp
 2b8:	8b 45 f0             	mov    -0x10(%ebp),%eax
 2bb:	c9                   	leave  
 2bc:	c3                   	ret    

000002bd <atoi>:
 2bd:	55                   	push   %ebp
 2be:	89 e5                	mov    %esp,%ebp
 2c0:	83 ec 10             	sub    $0x10,%esp
 2c3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 2ca:	eb 25                	jmp    2f1 <atoi+0x34>
 2cc:	8b 55 fc             	mov    -0x4(%ebp),%edx
 2cf:	89 d0                	mov    %edx,%eax
 2d1:	c1 e0 02             	shl    $0x2,%eax
 2d4:	01 d0                	add    %edx,%eax
 2d6:	01 c0                	add    %eax,%eax
 2d8:	89 c1                	mov    %eax,%ecx
 2da:	8b 45 08             	mov    0x8(%ebp),%eax
 2dd:	8d 50 01             	lea    0x1(%eax),%edx
 2e0:	89 55 08             	mov    %edx,0x8(%ebp)
 2e3:	0f b6 00             	movzbl (%eax),%eax
 2e6:	0f be c0             	movsbl %al,%eax
 2e9:	01 c8                	add    %ecx,%eax
 2eb:	83 e8 30             	sub    $0x30,%eax
 2ee:	89 45 fc             	mov    %eax,-0x4(%ebp)
 2f1:	8b 45 08             	mov    0x8(%ebp),%eax
 2f4:	0f b6 00             	movzbl (%eax),%eax
 2f7:	3c 2f                	cmp    $0x2f,%al
 2f9:	7e 0a                	jle    305 <atoi+0x48>
 2fb:	8b 45 08             	mov    0x8(%ebp),%eax
 2fe:	0f b6 00             	movzbl (%eax),%eax
 301:	3c 39                	cmp    $0x39,%al
 303:	7e c7                	jle    2cc <atoi+0xf>
 305:	8b 45 fc             	mov    -0x4(%ebp),%eax
 308:	c9                   	leave  
 309:	c3                   	ret    

0000030a <memmove>:
 30a:	55                   	push   %ebp
 30b:	89 e5                	mov    %esp,%ebp
 30d:	83 ec 10             	sub    $0x10,%esp
 310:	8b 45 08             	mov    0x8(%ebp),%eax
 313:	89 45 fc             	mov    %eax,-0x4(%ebp)
 316:	8b 45 0c             	mov    0xc(%ebp),%eax
 319:	89 45 f8             	mov    %eax,-0x8(%ebp)
 31c:	eb 17                	jmp    335 <memmove+0x2b>
 31e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 321:	8d 50 01             	lea    0x1(%eax),%edx
 324:	89 55 fc             	mov    %edx,-0x4(%ebp)
 327:	8b 55 f8             	mov    -0x8(%ebp),%edx
 32a:	8d 4a 01             	lea    0x1(%edx),%ecx
 32d:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 330:	0f b6 12             	movzbl (%edx),%edx
 333:	88 10                	mov    %dl,(%eax)
 335:	8b 45 10             	mov    0x10(%ebp),%eax
 338:	8d 50 ff             	lea    -0x1(%eax),%edx
 33b:	89 55 10             	mov    %edx,0x10(%ebp)
 33e:	85 c0                	test   %eax,%eax
 340:	7f dc                	jg     31e <memmove+0x14>
 342:	8b 45 08             	mov    0x8(%ebp),%eax
 345:	c9                   	leave  
 346:	c3                   	ret    

00000347 <fork>:
 347:	b8 01 00 00 00       	mov    $0x1,%eax
 34c:	cd 40                	int    $0x40
 34e:	c3                   	ret    

0000034f <exit>:
 34f:	b8 02 00 00 00       	mov    $0x2,%eax
 354:	cd 40                	int    $0x40
 356:	c3                   	ret    

00000357 <wait>:
 357:	b8 03 00 00 00       	mov    $0x3,%eax
 35c:	cd 40                	int    $0x40
 35e:	c3                   	ret    

0000035f <pipe>:
 35f:	b8 04 00 00 00       	mov    $0x4,%eax
 364:	cd 40                	int    $0x40
 366:	c3                   	ret    

00000367 <read>:
 367:	b8 05 00 00 00       	mov    $0x5,%eax
 36c:	cd 40                	int    $0x40
 36e:	c3                   	ret    

0000036f <write>:
 36f:	b8 10 00 00 00       	mov    $0x10,%eax
 374:	cd 40                	int    $0x40
 376:	c3                   	ret    

00000377 <close>:
 377:	b8 15 00 00 00       	mov    $0x15,%eax
 37c:	cd 40                	int    $0x40
 37e:	c3                   	ret    

0000037f <kill>:
 37f:	b8 06 00 00 00       	mov    $0x6,%eax
 384:	cd 40                	int    $0x40
 386:	c3                   	ret    

00000387 <exec>:
 387:	b8 07 00 00 00       	mov    $0x7,%eax
 38c:	cd 40                	int    $0x40
 38e:	c3                   	ret    

0000038f <open>:
 38f:	b8 0f 00 00 00       	mov    $0xf,%eax
 394:	cd 40                	int    $0x40
 396:	c3                   	ret    

00000397 <mknod>:
 397:	b8 11 00 00 00       	mov    $0x11,%eax
 39c:	cd 40                	int    $0x40
 39e:	c3                   	ret    

0000039f <unlink>:
 39f:	b8 12 00 00 00       	mov    $0x12,%eax
 3a4:	cd 40                	int    $0x40
 3a6:	c3                   	ret    

000003a7 <fstat>:
 3a7:	b8 08 00 00 00       	mov    $0x8,%eax
 3ac:	cd 40                	int    $0x40
 3ae:	c3                   	ret    

000003af <link>:
 3af:	b8 13 00 00 00       	mov    $0x13,%eax
 3b4:	cd 40                	int    $0x40
 3b6:	c3                   	ret    

000003b7 <mkdir>:
 3b7:	b8 14 00 00 00       	mov    $0x14,%eax
 3bc:	cd 40                	int    $0x40
 3be:	c3                   	ret    

000003bf <chdir>:
 3bf:	b8 09 00 00 00       	mov    $0x9,%eax
 3c4:	cd 40                	int    $0x40
 3c6:	c3                   	ret    

000003c7 <dup>:
 3c7:	b8 0a 00 00 00       	mov    $0xa,%eax
 3cc:	cd 40                	int    $0x40
 3ce:	c3                   	ret    

000003cf <getpid>:
 3cf:	b8 0b 00 00 00       	mov    $0xb,%eax
 3d4:	cd 40                	int    $0x40
 3d6:	c3                   	ret    

000003d7 <sbrk>:
 3d7:	b8 0c 00 00 00       	mov    $0xc,%eax
 3dc:	cd 40                	int    $0x40
 3de:	c3                   	ret    

000003df <sleep>:
 3df:	b8 0d 00 00 00       	mov    $0xd,%eax
 3e4:	cd 40                	int    $0x40
 3e6:	c3                   	ret    

000003e7 <uptime>:
 3e7:	b8 0e 00 00 00       	mov    $0xe,%eax
 3ec:	cd 40                	int    $0x40
 3ee:	c3                   	ret    

000003ef <putc>:
 3ef:	55                   	push   %ebp
 3f0:	89 e5                	mov    %esp,%ebp
 3f2:	83 ec 18             	sub    $0x18,%esp
 3f5:	8b 45 0c             	mov    0xc(%ebp),%eax
 3f8:	88 45 f4             	mov    %al,-0xc(%ebp)
 3fb:	83 ec 04             	sub    $0x4,%esp
 3fe:	6a 01                	push   $0x1
 400:	8d 45 f4             	lea    -0xc(%ebp),%eax
 403:	50                   	push   %eax
 404:	ff 75 08             	pushl  0x8(%ebp)
 407:	e8 63 ff ff ff       	call   36f <write>
 40c:	83 c4 10             	add    $0x10,%esp
 40f:	c9                   	leave  
 410:	c3                   	ret    

00000411 <printint>:
 411:	55                   	push   %ebp
 412:	89 e5                	mov    %esp,%ebp
 414:	53                   	push   %ebx
 415:	83 ec 24             	sub    $0x24,%esp
 418:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 41f:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 423:	74 17                	je     43c <printint+0x2b>
 425:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 429:	79 11                	jns    43c <printint+0x2b>
 42b:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
 432:	8b 45 0c             	mov    0xc(%ebp),%eax
 435:	f7 d8                	neg    %eax
 437:	89 45 ec             	mov    %eax,-0x14(%ebp)
 43a:	eb 06                	jmp    442 <printint+0x31>
 43c:	8b 45 0c             	mov    0xc(%ebp),%eax
 43f:	89 45 ec             	mov    %eax,-0x14(%ebp)
 442:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 449:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 44c:	8d 41 01             	lea    0x1(%ecx),%eax
 44f:	89 45 f4             	mov    %eax,-0xc(%ebp)
 452:	8b 5d 10             	mov    0x10(%ebp),%ebx
 455:	8b 45 ec             	mov    -0x14(%ebp),%eax
 458:	ba 00 00 00 00       	mov    $0x0,%edx
 45d:	f7 f3                	div    %ebx
 45f:	89 d0                	mov    %edx,%eax
 461:	0f b6 80 e8 0a 00 00 	movzbl 0xae8(%eax),%eax
 468:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
 46c:	8b 5d 10             	mov    0x10(%ebp),%ebx
 46f:	8b 45 ec             	mov    -0x14(%ebp),%eax
 472:	ba 00 00 00 00       	mov    $0x0,%edx
 477:	f7 f3                	div    %ebx
 479:	89 45 ec             	mov    %eax,-0x14(%ebp)
 47c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 480:	75 c7                	jne    449 <printint+0x38>
 482:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 486:	74 0e                	je     496 <printint+0x85>
 488:	8b 45 f4             	mov    -0xc(%ebp),%eax
 48b:	8d 50 01             	lea    0x1(%eax),%edx
 48e:	89 55 f4             	mov    %edx,-0xc(%ebp)
 491:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)
 496:	eb 1d                	jmp    4b5 <printint+0xa4>
 498:	8d 55 dc             	lea    -0x24(%ebp),%edx
 49b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 49e:	01 d0                	add    %edx,%eax
 4a0:	0f b6 00             	movzbl (%eax),%eax
 4a3:	0f be c0             	movsbl %al,%eax
 4a6:	83 ec 08             	sub    $0x8,%esp
 4a9:	50                   	push   %eax
 4aa:	ff 75 08             	pushl  0x8(%ebp)
 4ad:	e8 3d ff ff ff       	call   3ef <putc>
 4b2:	83 c4 10             	add    $0x10,%esp
 4b5:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 4b9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4bd:	79 d9                	jns    498 <printint+0x87>
 4bf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 4c2:	c9                   	leave  
 4c3:	c3                   	ret    

000004c4 <printf>:
 4c4:	55                   	push   %ebp
 4c5:	89 e5                	mov    %esp,%ebp
 4c7:	83 ec 28             	sub    $0x28,%esp
 4ca:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
 4d1:	8d 45 0c             	lea    0xc(%ebp),%eax
 4d4:	83 c0 04             	add    $0x4,%eax
 4d7:	89 45 e8             	mov    %eax,-0x18(%ebp)
 4da:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 4e1:	e9 59 01 00 00       	jmp    63f <printf+0x17b>
 4e6:	8b 55 0c             	mov    0xc(%ebp),%edx
 4e9:	8b 45 f0             	mov    -0x10(%ebp),%eax
 4ec:	01 d0                	add    %edx,%eax
 4ee:	0f b6 00             	movzbl (%eax),%eax
 4f1:	0f be c0             	movsbl %al,%eax
 4f4:	25 ff 00 00 00       	and    $0xff,%eax
 4f9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 4fc:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 500:	75 2c                	jne    52e <printf+0x6a>
 502:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 506:	75 0c                	jne    514 <printf+0x50>
 508:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 50f:	e9 27 01 00 00       	jmp    63b <printf+0x177>
 514:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 517:	0f be c0             	movsbl %al,%eax
 51a:	83 ec 08             	sub    $0x8,%esp
 51d:	50                   	push   %eax
 51e:	ff 75 08             	pushl  0x8(%ebp)
 521:	e8 c9 fe ff ff       	call   3ef <putc>
 526:	83 c4 10             	add    $0x10,%esp
 529:	e9 0d 01 00 00       	jmp    63b <printf+0x177>
 52e:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 532:	0f 85 03 01 00 00    	jne    63b <printf+0x177>
 538:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 53c:	75 1e                	jne    55c <printf+0x98>
 53e:	8b 45 e8             	mov    -0x18(%ebp),%eax
 541:	8b 00                	mov    (%eax),%eax
 543:	6a 01                	push   $0x1
 545:	6a 0a                	push   $0xa
 547:	50                   	push   %eax
 548:	ff 75 08             	pushl  0x8(%ebp)
 54b:	e8 c1 fe ff ff       	call   411 <printint>
 550:	83 c4 10             	add    $0x10,%esp
 553:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 557:	e9 d8 00 00 00       	jmp    634 <printf+0x170>
 55c:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 560:	74 06                	je     568 <printf+0xa4>
 562:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 566:	75 1e                	jne    586 <printf+0xc2>
 568:	8b 45 e8             	mov    -0x18(%ebp),%eax
 56b:	8b 00                	mov    (%eax),%eax
 56d:	6a 00                	push   $0x0
 56f:	6a 10                	push   $0x10
 571:	50                   	push   %eax
 572:	ff 75 08             	pushl  0x8(%ebp)
 575:	e8 97 fe ff ff       	call   411 <printint>
 57a:	83 c4 10             	add    $0x10,%esp
 57d:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 581:	e9 ae 00 00 00       	jmp    634 <printf+0x170>
 586:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 58a:	75 43                	jne    5cf <printf+0x10b>
 58c:	8b 45 e8             	mov    -0x18(%ebp),%eax
 58f:	8b 00                	mov    (%eax),%eax
 591:	89 45 f4             	mov    %eax,-0xc(%ebp)
 594:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 598:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 59c:	75 07                	jne    5a5 <printf+0xe1>
 59e:	c7 45 f4 78 08 00 00 	movl   $0x878,-0xc(%ebp)
 5a5:	eb 1c                	jmp    5c3 <printf+0xff>
 5a7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5aa:	0f b6 00             	movzbl (%eax),%eax
 5ad:	0f be c0             	movsbl %al,%eax
 5b0:	83 ec 08             	sub    $0x8,%esp
 5b3:	50                   	push   %eax
 5b4:	ff 75 08             	pushl  0x8(%ebp)
 5b7:	e8 33 fe ff ff       	call   3ef <putc>
 5bc:	83 c4 10             	add    $0x10,%esp
 5bf:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 5c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5c6:	0f b6 00             	movzbl (%eax),%eax
 5c9:	84 c0                	test   %al,%al
 5cb:	75 da                	jne    5a7 <printf+0xe3>
 5cd:	eb 65                	jmp    634 <printf+0x170>
 5cf:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 5d3:	75 1d                	jne    5f2 <printf+0x12e>
 5d5:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5d8:	8b 00                	mov    (%eax),%eax
 5da:	0f be c0             	movsbl %al,%eax
 5dd:	83 ec 08             	sub    $0x8,%esp
 5e0:	50                   	push   %eax
 5e1:	ff 75 08             	pushl  0x8(%ebp)
 5e4:	e8 06 fe ff ff       	call   3ef <putc>
 5e9:	83 c4 10             	add    $0x10,%esp
 5ec:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5f0:	eb 42                	jmp    634 <printf+0x170>
 5f2:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5f6:	75 17                	jne    60f <printf+0x14b>
 5f8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5fb:	0f be c0             	movsbl %al,%eax
 5fe:	83 ec 08             	sub    $0x8,%esp
 601:	50                   	push   %eax
 602:	ff 75 08             	pushl  0x8(%ebp)
 605:	e8 e5 fd ff ff       	call   3ef <putc>
 60a:	83 c4 10             	add    $0x10,%esp
 60d:	eb 25                	jmp    634 <printf+0x170>
 60f:	83 ec 08             	sub    $0x8,%esp
 612:	6a 25                	push   $0x25
 614:	ff 75 08             	pushl  0x8(%ebp)
 617:	e8 d3 fd ff ff       	call   3ef <putc>
 61c:	83 c4 10             	add    $0x10,%esp
 61f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 622:	0f be c0             	movsbl %al,%eax
 625:	83 ec 08             	sub    $0x8,%esp
 628:	50                   	push   %eax
 629:	ff 75 08             	pushl  0x8(%ebp)
 62c:	e8 be fd ff ff       	call   3ef <putc>
 631:	83 c4 10             	add    $0x10,%esp
 634:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
 63b:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 63f:	8b 55 0c             	mov    0xc(%ebp),%edx
 642:	8b 45 f0             	mov    -0x10(%ebp),%eax
 645:	01 d0                	add    %edx,%eax
 647:	0f b6 00             	movzbl (%eax),%eax
 64a:	84 c0                	test   %al,%al
 64c:	0f 85 94 fe ff ff    	jne    4e6 <printf+0x22>
 652:	c9                   	leave  
 653:	c3                   	ret    

00000654 <free>:
 654:	55                   	push   %ebp
 655:	89 e5                	mov    %esp,%ebp
 657:	83 ec 10             	sub    $0x10,%esp
 65a:	8b 45 08             	mov    0x8(%ebp),%eax
 65d:	83 e8 08             	sub    $0x8,%eax
 660:	89 45 f8             	mov    %eax,-0x8(%ebp)
 663:	a1 04 0b 00 00       	mov    0xb04,%eax
 668:	89 45 fc             	mov    %eax,-0x4(%ebp)
 66b:	eb 24                	jmp    691 <free+0x3d>
 66d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 670:	8b 00                	mov    (%eax),%eax
 672:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 675:	77 12                	ja     689 <free+0x35>
 677:	8b 45 f8             	mov    -0x8(%ebp),%eax
 67a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 67d:	77 24                	ja     6a3 <free+0x4f>
 67f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 682:	8b 00                	mov    (%eax),%eax
 684:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 687:	77 1a                	ja     6a3 <free+0x4f>
 689:	8b 45 fc             	mov    -0x4(%ebp),%eax
 68c:	8b 00                	mov    (%eax),%eax
 68e:	89 45 fc             	mov    %eax,-0x4(%ebp)
 691:	8b 45 f8             	mov    -0x8(%ebp),%eax
 694:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 697:	76 d4                	jbe    66d <free+0x19>
 699:	8b 45 fc             	mov    -0x4(%ebp),%eax
 69c:	8b 00                	mov    (%eax),%eax
 69e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6a1:	76 ca                	jbe    66d <free+0x19>
 6a3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6a6:	8b 40 04             	mov    0x4(%eax),%eax
 6a9:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6b0:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6b3:	01 c2                	add    %eax,%edx
 6b5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6b8:	8b 00                	mov    (%eax),%eax
 6ba:	39 c2                	cmp    %eax,%edx
 6bc:	75 24                	jne    6e2 <free+0x8e>
 6be:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6c1:	8b 50 04             	mov    0x4(%eax),%edx
 6c4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6c7:	8b 00                	mov    (%eax),%eax
 6c9:	8b 40 04             	mov    0x4(%eax),%eax
 6cc:	01 c2                	add    %eax,%edx
 6ce:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6d1:	89 50 04             	mov    %edx,0x4(%eax)
 6d4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6d7:	8b 00                	mov    (%eax),%eax
 6d9:	8b 10                	mov    (%eax),%edx
 6db:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6de:	89 10                	mov    %edx,(%eax)
 6e0:	eb 0a                	jmp    6ec <free+0x98>
 6e2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6e5:	8b 10                	mov    (%eax),%edx
 6e7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6ea:	89 10                	mov    %edx,(%eax)
 6ec:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ef:	8b 40 04             	mov    0x4(%eax),%eax
 6f2:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6f9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6fc:	01 d0                	add    %edx,%eax
 6fe:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 701:	75 20                	jne    723 <free+0xcf>
 703:	8b 45 fc             	mov    -0x4(%ebp),%eax
 706:	8b 50 04             	mov    0x4(%eax),%edx
 709:	8b 45 f8             	mov    -0x8(%ebp),%eax
 70c:	8b 40 04             	mov    0x4(%eax),%eax
 70f:	01 c2                	add    %eax,%edx
 711:	8b 45 fc             	mov    -0x4(%ebp),%eax
 714:	89 50 04             	mov    %edx,0x4(%eax)
 717:	8b 45 f8             	mov    -0x8(%ebp),%eax
 71a:	8b 10                	mov    (%eax),%edx
 71c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 71f:	89 10                	mov    %edx,(%eax)
 721:	eb 08                	jmp    72b <free+0xd7>
 723:	8b 45 fc             	mov    -0x4(%ebp),%eax
 726:	8b 55 f8             	mov    -0x8(%ebp),%edx
 729:	89 10                	mov    %edx,(%eax)
 72b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 72e:	a3 04 0b 00 00       	mov    %eax,0xb04
 733:	c9                   	leave  
 734:	c3                   	ret    

00000735 <morecore>:
 735:	55                   	push   %ebp
 736:	89 e5                	mov    %esp,%ebp
 738:	83 ec 18             	sub    $0x18,%esp
 73b:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 742:	77 07                	ja     74b <morecore+0x16>
 744:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
 74b:	8b 45 08             	mov    0x8(%ebp),%eax
 74e:	c1 e0 03             	shl    $0x3,%eax
 751:	83 ec 0c             	sub    $0xc,%esp
 754:	50                   	push   %eax
 755:	e8 7d fc ff ff       	call   3d7 <sbrk>
 75a:	83 c4 10             	add    $0x10,%esp
 75d:	89 45 f4             	mov    %eax,-0xc(%ebp)
 760:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 764:	75 07                	jne    76d <morecore+0x38>
 766:	b8 00 00 00 00       	mov    $0x0,%eax
 76b:	eb 26                	jmp    793 <morecore+0x5e>
 76d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 770:	89 45 f0             	mov    %eax,-0x10(%ebp)
 773:	8b 45 f0             	mov    -0x10(%ebp),%eax
 776:	8b 55 08             	mov    0x8(%ebp),%edx
 779:	89 50 04             	mov    %edx,0x4(%eax)
 77c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 77f:	83 c0 08             	add    $0x8,%eax
 782:	83 ec 0c             	sub    $0xc,%esp
 785:	50                   	push   %eax
 786:	e8 c9 fe ff ff       	call   654 <free>
 78b:	83 c4 10             	add    $0x10,%esp
 78e:	a1 04 0b 00 00       	mov    0xb04,%eax
 793:	c9                   	leave  
 794:	c3                   	ret    

00000795 <malloc>:
 795:	55                   	push   %ebp
 796:	89 e5                	mov    %esp,%ebp
 798:	83 ec 18             	sub    $0x18,%esp
 79b:	8b 45 08             	mov    0x8(%ebp),%eax
 79e:	83 c0 07             	add    $0x7,%eax
 7a1:	c1 e8 03             	shr    $0x3,%eax
 7a4:	83 c0 01             	add    $0x1,%eax
 7a7:	89 45 ec             	mov    %eax,-0x14(%ebp)
 7aa:	a1 04 0b 00 00       	mov    0xb04,%eax
 7af:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7b2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 7b6:	75 23                	jne    7db <malloc+0x46>
 7b8:	c7 45 f0 fc 0a 00 00 	movl   $0xafc,-0x10(%ebp)
 7bf:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7c2:	a3 04 0b 00 00       	mov    %eax,0xb04
 7c7:	a1 04 0b 00 00       	mov    0xb04,%eax
 7cc:	a3 fc 0a 00 00       	mov    %eax,0xafc
 7d1:	c7 05 00 0b 00 00 00 	movl   $0x0,0xb00
 7d8:	00 00 00 
 7db:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7de:	8b 00                	mov    (%eax),%eax
 7e0:	89 45 f4             	mov    %eax,-0xc(%ebp)
 7e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7e6:	8b 40 04             	mov    0x4(%eax),%eax
 7e9:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7ec:	72 4d                	jb     83b <malloc+0xa6>
 7ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7f1:	8b 40 04             	mov    0x4(%eax),%eax
 7f4:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7f7:	75 0c                	jne    805 <malloc+0x70>
 7f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7fc:	8b 10                	mov    (%eax),%edx
 7fe:	8b 45 f0             	mov    -0x10(%ebp),%eax
 801:	89 10                	mov    %edx,(%eax)
 803:	eb 26                	jmp    82b <malloc+0x96>
 805:	8b 45 f4             	mov    -0xc(%ebp),%eax
 808:	8b 40 04             	mov    0x4(%eax),%eax
 80b:	2b 45 ec             	sub    -0x14(%ebp),%eax
 80e:	89 c2                	mov    %eax,%edx
 810:	8b 45 f4             	mov    -0xc(%ebp),%eax
 813:	89 50 04             	mov    %edx,0x4(%eax)
 816:	8b 45 f4             	mov    -0xc(%ebp),%eax
 819:	8b 40 04             	mov    0x4(%eax),%eax
 81c:	c1 e0 03             	shl    $0x3,%eax
 81f:	01 45 f4             	add    %eax,-0xc(%ebp)
 822:	8b 45 f4             	mov    -0xc(%ebp),%eax
 825:	8b 55 ec             	mov    -0x14(%ebp),%edx
 828:	89 50 04             	mov    %edx,0x4(%eax)
 82b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 82e:	a3 04 0b 00 00       	mov    %eax,0xb04
 833:	8b 45 f4             	mov    -0xc(%ebp),%eax
 836:	83 c0 08             	add    $0x8,%eax
 839:	eb 3b                	jmp    876 <malloc+0xe1>
 83b:	a1 04 0b 00 00       	mov    0xb04,%eax
 840:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 843:	75 1e                	jne    863 <malloc+0xce>
 845:	83 ec 0c             	sub    $0xc,%esp
 848:	ff 75 ec             	pushl  -0x14(%ebp)
 84b:	e8 e5 fe ff ff       	call   735 <morecore>
 850:	83 c4 10             	add    $0x10,%esp
 853:	89 45 f4             	mov    %eax,-0xc(%ebp)
 856:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 85a:	75 07                	jne    863 <malloc+0xce>
 85c:	b8 00 00 00 00       	mov    $0x0,%eax
 861:	eb 13                	jmp    876 <malloc+0xe1>
 863:	8b 45 f4             	mov    -0xc(%ebp),%eax
 866:	89 45 f0             	mov    %eax,-0x10(%ebp)
 869:	8b 45 f4             	mov    -0xc(%ebp),%eax
 86c:	8b 00                	mov    (%eax),%eax
 86e:	89 45 f4             	mov    %eax,-0xc(%ebp)
 871:	e9 6d ff ff ff       	jmp    7e3 <malloc+0x4e>
 876:	c9                   	leave  
 877:	c3                   	ret    
