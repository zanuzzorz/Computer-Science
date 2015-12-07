
kernel: formato do arquivo elf32-i386


Desmontagem da seção .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4 0f                	in     $0xf,%al

8010000c <entry>:
8010000c:	0f 20 e0             	mov    %cr4,%eax
8010000f:	83 c8 10             	or     $0x10,%eax
80100012:	0f 22 e0             	mov    %eax,%cr4
80100015:	b8 00 b0 10 00       	mov    $0x10b000,%eax
8010001a:	0f 22 d8             	mov    %eax,%cr3
8010001d:	0f 20 c0             	mov    %cr0,%eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
80100025:	0f 22 c0             	mov    %eax,%cr0
80100028:	bc 70 da 10 80       	mov    $0x8010da70,%esp
8010002d:	b8 54 38 10 80       	mov    $0x80103854,%eax
80100032:	ff e0                	jmp    *%eax

80100034 <binit>:
80100034:	55                   	push   %ebp
80100035:	89 e5                	mov    %esp,%ebp
80100037:	83 ec 18             	sub    $0x18,%esp
8010003a:	83 ec 08             	sub    $0x8,%esp
8010003d:	68 90 88 10 80       	push   $0x80108890
80100042:	68 80 da 10 80       	push   $0x8010da80
80100047:	e8 ee 52 00 00       	call   8010533a <initlock>
8010004c:	83 c4 10             	add    $0x10,%esp
8010004f:	c7 05 90 19 11 80 84 	movl   $0x80111984,0x80111990
80100056:	19 11 80 
80100059:	c7 05 94 19 11 80 84 	movl   $0x80111984,0x80111994
80100060:	19 11 80 
80100063:	c7 45 f4 b4 da 10 80 	movl   $0x8010dab4,-0xc(%ebp)
8010006a:	eb 3a                	jmp    801000a6 <binit+0x72>
8010006c:	8b 15 94 19 11 80    	mov    0x80111994,%edx
80100072:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100075:	89 50 10             	mov    %edx,0x10(%eax)
80100078:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010007b:	c7 40 0c 84 19 11 80 	movl   $0x80111984,0xc(%eax)
80100082:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100085:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
8010008c:	a1 94 19 11 80       	mov    0x80111994,%eax
80100091:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100094:	89 50 0c             	mov    %edx,0xc(%eax)
80100097:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010009a:	a3 94 19 11 80       	mov    %eax,0x80111994
8010009f:	81 45 f4 18 02 00 00 	addl   $0x218,-0xc(%ebp)
801000a6:	81 7d f4 84 19 11 80 	cmpl   $0x80111984,-0xc(%ebp)
801000ad:	72 bd                	jb     8010006c <binit+0x38>
801000af:	c9                   	leave  
801000b0:	c3                   	ret    

801000b1 <bget>:
801000b1:	55                   	push   %ebp
801000b2:	89 e5                	mov    %esp,%ebp
801000b4:	83 ec 18             	sub    $0x18,%esp
801000b7:	83 ec 0c             	sub    $0xc,%esp
801000ba:	68 80 da 10 80       	push   $0x8010da80
801000bf:	e8 98 52 00 00       	call   8010535c <acquire>
801000c4:	83 c4 10             	add    $0x10,%esp
801000c7:	a1 94 19 11 80       	mov    0x80111994,%eax
801000cc:	89 45 f4             	mov    %eax,-0xc(%ebp)
801000cf:	eb 67                	jmp    80100138 <bget+0x87>
801000d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000d4:	8b 40 04             	mov    0x4(%eax),%eax
801000d7:	3b 45 08             	cmp    0x8(%ebp),%eax
801000da:	75 53                	jne    8010012f <bget+0x7e>
801000dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000df:	8b 40 08             	mov    0x8(%eax),%eax
801000e2:	3b 45 0c             	cmp    0xc(%ebp),%eax
801000e5:	75 48                	jne    8010012f <bget+0x7e>
801000e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000ea:	8b 00                	mov    (%eax),%eax
801000ec:	83 e0 01             	and    $0x1,%eax
801000ef:	85 c0                	test   %eax,%eax
801000f1:	75 27                	jne    8010011a <bget+0x69>
801000f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000f6:	8b 00                	mov    (%eax),%eax
801000f8:	83 c8 01             	or     $0x1,%eax
801000fb:	89 c2                	mov    %eax,%edx
801000fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100100:	89 10                	mov    %edx,(%eax)
80100102:	83 ec 0c             	sub    $0xc,%esp
80100105:	68 80 da 10 80       	push   $0x8010da80
8010010a:	e8 b4 52 00 00       	call   801053c3 <release>
8010010f:	83 c4 10             	add    $0x10,%esp
80100112:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100115:	e9 98 00 00 00       	jmp    801001b2 <bget+0x101>
8010011a:	83 ec 08             	sub    $0x8,%esp
8010011d:	68 80 da 10 80       	push   $0x8010da80
80100122:	ff 75 f4             	pushl  -0xc(%ebp)
80100125:	e8 f3 4e 00 00       	call   8010501d <sleep>
8010012a:	83 c4 10             	add    $0x10,%esp
8010012d:	eb 98                	jmp    801000c7 <bget+0x16>
8010012f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100132:	8b 40 10             	mov    0x10(%eax),%eax
80100135:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100138:	81 7d f4 84 19 11 80 	cmpl   $0x80111984,-0xc(%ebp)
8010013f:	75 90                	jne    801000d1 <bget+0x20>
80100141:	a1 90 19 11 80       	mov    0x80111990,%eax
80100146:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100149:	eb 51                	jmp    8010019c <bget+0xeb>
8010014b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010014e:	8b 00                	mov    (%eax),%eax
80100150:	83 e0 01             	and    $0x1,%eax
80100153:	85 c0                	test   %eax,%eax
80100155:	75 3c                	jne    80100193 <bget+0xe2>
80100157:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010015a:	8b 00                	mov    (%eax),%eax
8010015c:	83 e0 04             	and    $0x4,%eax
8010015f:	85 c0                	test   %eax,%eax
80100161:	75 30                	jne    80100193 <bget+0xe2>
80100163:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100166:	8b 55 08             	mov    0x8(%ebp),%edx
80100169:	89 50 04             	mov    %edx,0x4(%eax)
8010016c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010016f:	8b 55 0c             	mov    0xc(%ebp),%edx
80100172:	89 50 08             	mov    %edx,0x8(%eax)
80100175:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100178:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
8010017e:	83 ec 0c             	sub    $0xc,%esp
80100181:	68 80 da 10 80       	push   $0x8010da80
80100186:	e8 38 52 00 00       	call   801053c3 <release>
8010018b:	83 c4 10             	add    $0x10,%esp
8010018e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100191:	eb 1f                	jmp    801001b2 <bget+0x101>
80100193:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100196:	8b 40 0c             	mov    0xc(%eax),%eax
80100199:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010019c:	81 7d f4 84 19 11 80 	cmpl   $0x80111984,-0xc(%ebp)
801001a3:	75 a6                	jne    8010014b <bget+0x9a>
801001a5:	83 ec 0c             	sub    $0xc,%esp
801001a8:	68 97 88 10 80       	push   $0x80108897
801001ad:	e8 b0 03 00 00       	call   80100562 <panic>
801001b2:	c9                   	leave  
801001b3:	c3                   	ret    

801001b4 <bread>:
801001b4:	55                   	push   %ebp
801001b5:	89 e5                	mov    %esp,%ebp
801001b7:	83 ec 18             	sub    $0x18,%esp
801001ba:	83 ec 08             	sub    $0x8,%esp
801001bd:	ff 75 0c             	pushl  0xc(%ebp)
801001c0:	ff 75 08             	pushl  0x8(%ebp)
801001c3:	e8 e9 fe ff ff       	call   801000b1 <bget>
801001c8:	83 c4 10             	add    $0x10,%esp
801001cb:	89 45 f4             	mov    %eax,-0xc(%ebp)
801001ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
801001d1:	8b 00                	mov    (%eax),%eax
801001d3:	83 e0 02             	and    $0x2,%eax
801001d6:	85 c0                	test   %eax,%eax
801001d8:	75 0e                	jne    801001e8 <bread+0x34>
801001da:	83 ec 0c             	sub    $0xc,%esp
801001dd:	ff 75 f4             	pushl  -0xc(%ebp)
801001e0:	e8 06 27 00 00       	call   801028eb <iderw>
801001e5:	83 c4 10             	add    $0x10,%esp
801001e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801001eb:	c9                   	leave  
801001ec:	c3                   	ret    

801001ed <bwrite>:
801001ed:	55                   	push   %ebp
801001ee:	89 e5                	mov    %esp,%ebp
801001f0:	83 ec 08             	sub    $0x8,%esp
801001f3:	8b 45 08             	mov    0x8(%ebp),%eax
801001f6:	8b 00                	mov    (%eax),%eax
801001f8:	83 e0 01             	and    $0x1,%eax
801001fb:	85 c0                	test   %eax,%eax
801001fd:	75 0d                	jne    8010020c <bwrite+0x1f>
801001ff:	83 ec 0c             	sub    $0xc,%esp
80100202:	68 a8 88 10 80       	push   $0x801088a8
80100207:	e8 56 03 00 00       	call   80100562 <panic>
8010020c:	8b 45 08             	mov    0x8(%ebp),%eax
8010020f:	8b 00                	mov    (%eax),%eax
80100211:	83 c8 04             	or     $0x4,%eax
80100214:	89 c2                	mov    %eax,%edx
80100216:	8b 45 08             	mov    0x8(%ebp),%eax
80100219:	89 10                	mov    %edx,(%eax)
8010021b:	83 ec 0c             	sub    $0xc,%esp
8010021e:	ff 75 08             	pushl  0x8(%ebp)
80100221:	e8 c5 26 00 00       	call   801028eb <iderw>
80100226:	83 c4 10             	add    $0x10,%esp
80100229:	c9                   	leave  
8010022a:	c3                   	ret    

8010022b <brelse>:
8010022b:	55                   	push   %ebp
8010022c:	89 e5                	mov    %esp,%ebp
8010022e:	83 ec 08             	sub    $0x8,%esp
80100231:	8b 45 08             	mov    0x8(%ebp),%eax
80100234:	8b 00                	mov    (%eax),%eax
80100236:	83 e0 01             	and    $0x1,%eax
80100239:	85 c0                	test   %eax,%eax
8010023b:	75 0d                	jne    8010024a <brelse+0x1f>
8010023d:	83 ec 0c             	sub    $0xc,%esp
80100240:	68 af 88 10 80       	push   $0x801088af
80100245:	e8 18 03 00 00       	call   80100562 <panic>
8010024a:	83 ec 0c             	sub    $0xc,%esp
8010024d:	68 80 da 10 80       	push   $0x8010da80
80100252:	e8 05 51 00 00       	call   8010535c <acquire>
80100257:	83 c4 10             	add    $0x10,%esp
8010025a:	8b 45 08             	mov    0x8(%ebp),%eax
8010025d:	8b 40 10             	mov    0x10(%eax),%eax
80100260:	8b 55 08             	mov    0x8(%ebp),%edx
80100263:	8b 52 0c             	mov    0xc(%edx),%edx
80100266:	89 50 0c             	mov    %edx,0xc(%eax)
80100269:	8b 45 08             	mov    0x8(%ebp),%eax
8010026c:	8b 40 0c             	mov    0xc(%eax),%eax
8010026f:	8b 55 08             	mov    0x8(%ebp),%edx
80100272:	8b 52 10             	mov    0x10(%edx),%edx
80100275:	89 50 10             	mov    %edx,0x10(%eax)
80100278:	8b 15 94 19 11 80    	mov    0x80111994,%edx
8010027e:	8b 45 08             	mov    0x8(%ebp),%eax
80100281:	89 50 10             	mov    %edx,0x10(%eax)
80100284:	8b 45 08             	mov    0x8(%ebp),%eax
80100287:	c7 40 0c 84 19 11 80 	movl   $0x80111984,0xc(%eax)
8010028e:	a1 94 19 11 80       	mov    0x80111994,%eax
80100293:	8b 55 08             	mov    0x8(%ebp),%edx
80100296:	89 50 0c             	mov    %edx,0xc(%eax)
80100299:	8b 45 08             	mov    0x8(%ebp),%eax
8010029c:	a3 94 19 11 80       	mov    %eax,0x80111994
801002a1:	8b 45 08             	mov    0x8(%ebp),%eax
801002a4:	8b 00                	mov    (%eax),%eax
801002a6:	83 e0 fe             	and    $0xfffffffe,%eax
801002a9:	89 c2                	mov    %eax,%edx
801002ab:	8b 45 08             	mov    0x8(%ebp),%eax
801002ae:	89 10                	mov    %edx,(%eax)
801002b0:	83 ec 0c             	sub    $0xc,%esp
801002b3:	ff 75 08             	pushl  0x8(%ebp)
801002b6:	e8 5e 4e 00 00       	call   80105119 <wakeup>
801002bb:	83 c4 10             	add    $0x10,%esp
801002be:	83 ec 0c             	sub    $0xc,%esp
801002c1:	68 80 da 10 80       	push   $0x8010da80
801002c6:	e8 f8 50 00 00       	call   801053c3 <release>
801002cb:	83 c4 10             	add    $0x10,%esp
801002ce:	c9                   	leave  
801002cf:	c3                   	ret    

801002d0 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
801002d0:	55                   	push   %ebp
801002d1:	89 e5                	mov    %esp,%ebp
801002d3:	83 ec 14             	sub    $0x14,%esp
801002d6:	8b 45 08             	mov    0x8(%ebp),%eax
801002d9:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801002dd:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
801002e1:	89 c2                	mov    %eax,%edx
801002e3:	ec                   	in     (%dx),%al
801002e4:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
801002e7:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
801002eb:	c9                   	leave  
801002ec:	c3                   	ret    

801002ed <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
801002ed:	55                   	push   %ebp
801002ee:	89 e5                	mov    %esp,%ebp
801002f0:	83 ec 08             	sub    $0x8,%esp
801002f3:	8b 55 08             	mov    0x8(%ebp),%edx
801002f6:	8b 45 0c             	mov    0xc(%ebp),%eax
801002f9:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
801002fd:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100300:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80100304:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80100308:	ee                   	out    %al,(%dx)
}
80100309:	90                   	nop
8010030a:	c9                   	leave  
8010030b:	c3                   	ret    

8010030c <cli>:
  asm volatile("movw %0, %%gs" : : "r" (v));
}

static inline void
cli(void)
{
8010030c:	55                   	push   %ebp
8010030d:	89 e5                	mov    %esp,%ebp
  asm volatile("cli");
8010030f:	fa                   	cli    
}
80100310:	90                   	nop
80100311:	5d                   	pop    %ebp
80100312:	c3                   	ret    

80100313 <printint>:
  int locking;
} cons;

static void
printint(int xx, int base, int sign)
{
80100313:	55                   	push   %ebp
80100314:	89 e5                	mov    %esp,%ebp
80100316:	53                   	push   %ebx
80100317:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
8010031a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010031e:	74 1c                	je     8010033c <printint+0x29>
80100320:	8b 45 08             	mov    0x8(%ebp),%eax
80100323:	c1 e8 1f             	shr    $0x1f,%eax
80100326:	0f b6 c0             	movzbl %al,%eax
80100329:	89 45 10             	mov    %eax,0x10(%ebp)
8010032c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80100330:	74 0a                	je     8010033c <printint+0x29>
    x = -xx;
80100332:	8b 45 08             	mov    0x8(%ebp),%eax
80100335:	f7 d8                	neg    %eax
80100337:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010033a:	eb 06                	jmp    80100342 <printint+0x2f>
  else
    x = xx;
8010033c:	8b 45 08             	mov    0x8(%ebp),%eax
8010033f:	89 45 f0             	mov    %eax,-0x10(%ebp)

  i = 0;
80100342:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
80100349:	8b 4d f4             	mov    -0xc(%ebp),%ecx
8010034c:	8d 41 01             	lea    0x1(%ecx),%eax
8010034f:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100352:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80100355:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100358:	ba 00 00 00 00       	mov    $0x0,%edx
8010035d:	f7 f3                	div    %ebx
8010035f:	89 d0                	mov    %edx,%eax
80100361:	0f b6 80 04 a0 10 80 	movzbl -0x7fef5ffc(%eax),%eax
80100368:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
  }while((x /= base) != 0);
8010036c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010036f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100372:	ba 00 00 00 00       	mov    $0x0,%edx
80100377:	f7 f3                	div    %ebx
80100379:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010037c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80100380:	75 c7                	jne    80100349 <printint+0x36>

  if(sign)
80100382:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80100386:	74 2a                	je     801003b2 <printint+0x9f>
    buf[i++] = '-';
80100388:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010038b:	8d 50 01             	lea    0x1(%eax),%edx
8010038e:	89 55 f4             	mov    %edx,-0xc(%ebp)
80100391:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)

  while(--i >= 0)
80100396:	eb 1a                	jmp    801003b2 <printint+0x9f>
    consputc(buf[i]);
80100398:	8d 55 e0             	lea    -0x20(%ebp),%edx
8010039b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010039e:	01 d0                	add    %edx,%eax
801003a0:	0f b6 00             	movzbl (%eax),%eax
801003a3:	0f be c0             	movsbl %al,%eax
801003a6:	83 ec 0c             	sub    $0xc,%esp
801003a9:	50                   	push   %eax
801003aa:	e8 c3 03 00 00       	call   80100772 <consputc>
801003af:	83 c4 10             	add    $0x10,%esp
  }while((x /= base) != 0);

  if(sign)
    buf[i++] = '-';

  while(--i >= 0)
801003b2:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
801003b6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801003ba:	79 dc                	jns    80100398 <printint+0x85>
    consputc(buf[i]);
}
801003bc:	90                   	nop
801003bd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801003c0:	c9                   	leave  
801003c1:	c3                   	ret    

801003c2 <cprintf>:
//PAGEBREAK: 50

// Print to the console. only understands %d, %x, %p, %s.
void
cprintf(char *fmt, ...)
{
801003c2:	55                   	push   %ebp
801003c3:	89 e5                	mov    %esp,%ebp
801003c5:	83 ec 28             	sub    $0x28,%esp
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
801003c8:	a1 14 c6 10 80       	mov    0x8010c614,%eax
801003cd:	89 45 e8             	mov    %eax,-0x18(%ebp)
  if(locking)
801003d0:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
801003d4:	74 10                	je     801003e6 <cprintf+0x24>
    acquire(&cons.lock);
801003d6:	83 ec 0c             	sub    $0xc,%esp
801003d9:	68 e0 c5 10 80       	push   $0x8010c5e0
801003de:	e8 79 4f 00 00       	call   8010535c <acquire>
801003e3:	83 c4 10             	add    $0x10,%esp

  if (fmt == 0)
801003e6:	8b 45 08             	mov    0x8(%ebp),%eax
801003e9:	85 c0                	test   %eax,%eax
801003eb:	75 0d                	jne    801003fa <cprintf+0x38>
    panic("null fmt");
801003ed:	83 ec 0c             	sub    $0xc,%esp
801003f0:	68 b6 88 10 80       	push   $0x801088b6
801003f5:	e8 68 01 00 00       	call   80100562 <panic>

  argp = (uint*)(void*)(&fmt + 1);
801003fa:	8d 45 0c             	lea    0xc(%ebp),%eax
801003fd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100400:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80100407:	e9 1a 01 00 00       	jmp    80100526 <cprintf+0x164>
    if(c != '%'){
8010040c:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
80100410:	74 13                	je     80100425 <cprintf+0x63>
      consputc(c);
80100412:	83 ec 0c             	sub    $0xc,%esp
80100415:	ff 75 e4             	pushl  -0x1c(%ebp)
80100418:	e8 55 03 00 00       	call   80100772 <consputc>
8010041d:	83 c4 10             	add    $0x10,%esp
      continue;
80100420:	e9 fd 00 00 00       	jmp    80100522 <cprintf+0x160>
    }
    c = fmt[++i] & 0xff;
80100425:	8b 55 08             	mov    0x8(%ebp),%edx
80100428:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010042c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010042f:	01 d0                	add    %edx,%eax
80100431:	0f b6 00             	movzbl (%eax),%eax
80100434:	0f be c0             	movsbl %al,%eax
80100437:	25 ff 00 00 00       	and    $0xff,%eax
8010043c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(c == 0)
8010043f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
80100443:	0f 84 ff 00 00 00    	je     80100548 <cprintf+0x186>
      break;
    switch(c){
80100449:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010044c:	83 f8 70             	cmp    $0x70,%eax
8010044f:	74 47                	je     80100498 <cprintf+0xd6>
80100451:	83 f8 70             	cmp    $0x70,%eax
80100454:	7f 13                	jg     80100469 <cprintf+0xa7>
80100456:	83 f8 25             	cmp    $0x25,%eax
80100459:	0f 84 98 00 00 00    	je     801004f7 <cprintf+0x135>
8010045f:	83 f8 64             	cmp    $0x64,%eax
80100462:	74 14                	je     80100478 <cprintf+0xb6>
80100464:	e9 9d 00 00 00       	jmp    80100506 <cprintf+0x144>
80100469:	83 f8 73             	cmp    $0x73,%eax
8010046c:	74 47                	je     801004b5 <cprintf+0xf3>
8010046e:	83 f8 78             	cmp    $0x78,%eax
80100471:	74 25                	je     80100498 <cprintf+0xd6>
80100473:	e9 8e 00 00 00       	jmp    80100506 <cprintf+0x144>
    case 'd':
      printint(*argp++, 10, 1);
80100478:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010047b:	8d 50 04             	lea    0x4(%eax),%edx
8010047e:	89 55 f0             	mov    %edx,-0x10(%ebp)
80100481:	8b 00                	mov    (%eax),%eax
80100483:	83 ec 04             	sub    $0x4,%esp
80100486:	6a 01                	push   $0x1
80100488:	6a 0a                	push   $0xa
8010048a:	50                   	push   %eax
8010048b:	e8 83 fe ff ff       	call   80100313 <printint>
80100490:	83 c4 10             	add    $0x10,%esp
      break;
80100493:	e9 8a 00 00 00       	jmp    80100522 <cprintf+0x160>
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
80100498:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010049b:	8d 50 04             	lea    0x4(%eax),%edx
8010049e:	89 55 f0             	mov    %edx,-0x10(%ebp)
801004a1:	8b 00                	mov    (%eax),%eax
801004a3:	83 ec 04             	sub    $0x4,%esp
801004a6:	6a 00                	push   $0x0
801004a8:	6a 10                	push   $0x10
801004aa:	50                   	push   %eax
801004ab:	e8 63 fe ff ff       	call   80100313 <printint>
801004b0:	83 c4 10             	add    $0x10,%esp
      break;
801004b3:	eb 6d                	jmp    80100522 <cprintf+0x160>
    case 's':
      if((s = (char*)*argp++) == 0)
801004b5:	8b 45 f0             	mov    -0x10(%ebp),%eax
801004b8:	8d 50 04             	lea    0x4(%eax),%edx
801004bb:	89 55 f0             	mov    %edx,-0x10(%ebp)
801004be:	8b 00                	mov    (%eax),%eax
801004c0:	89 45 ec             	mov    %eax,-0x14(%ebp)
801004c3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
801004c7:	75 22                	jne    801004eb <cprintf+0x129>
        s = "(null)";
801004c9:	c7 45 ec bf 88 10 80 	movl   $0x801088bf,-0x14(%ebp)
      for(; *s; s++)
801004d0:	eb 19                	jmp    801004eb <cprintf+0x129>
        consputc(*s);
801004d2:	8b 45 ec             	mov    -0x14(%ebp),%eax
801004d5:	0f b6 00             	movzbl (%eax),%eax
801004d8:	0f be c0             	movsbl %al,%eax
801004db:	83 ec 0c             	sub    $0xc,%esp
801004de:	50                   	push   %eax
801004df:	e8 8e 02 00 00       	call   80100772 <consputc>
801004e4:	83 c4 10             	add    $0x10,%esp
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
        s = "(null)";
      for(; *s; s++)
801004e7:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
801004eb:	8b 45 ec             	mov    -0x14(%ebp),%eax
801004ee:	0f b6 00             	movzbl (%eax),%eax
801004f1:	84 c0                	test   %al,%al
801004f3:	75 dd                	jne    801004d2 <cprintf+0x110>
        consputc(*s);
      break;
801004f5:	eb 2b                	jmp    80100522 <cprintf+0x160>
    case '%':
      consputc('%');
801004f7:	83 ec 0c             	sub    $0xc,%esp
801004fa:	6a 25                	push   $0x25
801004fc:	e8 71 02 00 00       	call   80100772 <consputc>
80100501:	83 c4 10             	add    $0x10,%esp
      break;
80100504:	eb 1c                	jmp    80100522 <cprintf+0x160>
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
80100506:	83 ec 0c             	sub    $0xc,%esp
80100509:	6a 25                	push   $0x25
8010050b:	e8 62 02 00 00       	call   80100772 <consputc>
80100510:	83 c4 10             	add    $0x10,%esp
      consputc(c);
80100513:	83 ec 0c             	sub    $0xc,%esp
80100516:	ff 75 e4             	pushl  -0x1c(%ebp)
80100519:	e8 54 02 00 00       	call   80100772 <consputc>
8010051e:	83 c4 10             	add    $0x10,%esp
      break;
80100521:	90                   	nop

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100522:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100526:	8b 55 08             	mov    0x8(%ebp),%edx
80100529:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010052c:	01 d0                	add    %edx,%eax
8010052e:	0f b6 00             	movzbl (%eax),%eax
80100531:	0f be c0             	movsbl %al,%eax
80100534:	25 ff 00 00 00       	and    $0xff,%eax
80100539:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010053c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
80100540:	0f 85 c6 fe ff ff    	jne    8010040c <cprintf+0x4a>
80100546:	eb 01                	jmp    80100549 <cprintf+0x187>
      consputc(c);
      continue;
    }
    c = fmt[++i] & 0xff;
    if(c == 0)
      break;
80100548:	90                   	nop
      consputc(c);
      break;
    }
  }

  if(locking)
80100549:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
8010054d:	74 10                	je     8010055f <cprintf+0x19d>
    release(&cons.lock);
8010054f:	83 ec 0c             	sub    $0xc,%esp
80100552:	68 e0 c5 10 80       	push   $0x8010c5e0
80100557:	e8 67 4e 00 00       	call   801053c3 <release>
8010055c:	83 c4 10             	add    $0x10,%esp
}
8010055f:	90                   	nop
80100560:	c9                   	leave  
80100561:	c3                   	ret    

80100562 <panic>:

void
panic(char *s)
{
80100562:	55                   	push   %ebp
80100563:	89 e5                	mov    %esp,%ebp
80100565:	83 ec 38             	sub    $0x38,%esp
  int i;
  uint pcs[10];
  
  cli();
80100568:	e8 9f fd ff ff       	call   8010030c <cli>
  cons.locking = 0;
8010056d:	c7 05 14 c6 10 80 00 	movl   $0x0,0x8010c614
80100574:	00 00 00 
  cprintf("cpu%d: panic: ", cpu->id);
80100577:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010057d:	0f b6 00             	movzbl (%eax),%eax
80100580:	0f b6 c0             	movzbl %al,%eax
80100583:	83 ec 08             	sub    $0x8,%esp
80100586:	50                   	push   %eax
80100587:	68 c6 88 10 80       	push   $0x801088c6
8010058c:	e8 31 fe ff ff       	call   801003c2 <cprintf>
80100591:	83 c4 10             	add    $0x10,%esp
  cprintf(s);
80100594:	8b 45 08             	mov    0x8(%ebp),%eax
80100597:	83 ec 0c             	sub    $0xc,%esp
8010059a:	50                   	push   %eax
8010059b:	e8 22 fe ff ff       	call   801003c2 <cprintf>
801005a0:	83 c4 10             	add    $0x10,%esp
  cprintf("\n");
801005a3:	83 ec 0c             	sub    $0xc,%esp
801005a6:	68 d5 88 10 80       	push   $0x801088d5
801005ab:	e8 12 fe ff ff       	call   801003c2 <cprintf>
801005b0:	83 c4 10             	add    $0x10,%esp
  getcallerpcs(&s, pcs);
801005b3:	83 ec 08             	sub    $0x8,%esp
801005b6:	8d 45 cc             	lea    -0x34(%ebp),%eax
801005b9:	50                   	push   %eax
801005ba:	8d 45 08             	lea    0x8(%ebp),%eax
801005bd:	50                   	push   %eax
801005be:	e8 52 4e 00 00       	call   80105415 <getcallerpcs>
801005c3:	83 c4 10             	add    $0x10,%esp
  for(i=0; i<10; i++)
801005c6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801005cd:	eb 1c                	jmp    801005eb <panic+0x89>
    cprintf(" %p", pcs[i]);
801005cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
801005d2:	8b 44 85 cc          	mov    -0x34(%ebp,%eax,4),%eax
801005d6:	83 ec 08             	sub    $0x8,%esp
801005d9:	50                   	push   %eax
801005da:	68 d7 88 10 80       	push   $0x801088d7
801005df:	e8 de fd ff ff       	call   801003c2 <cprintf>
801005e4:	83 c4 10             	add    $0x10,%esp
  cons.locking = 0;
  cprintf("cpu%d: panic: ", cpu->id);
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
  for(i=0; i<10; i++)
801005e7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801005eb:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
801005ef:	7e de                	jle    801005cf <panic+0x6d>
    cprintf(" %p", pcs[i]);
  panicked = 1; // freeze other CPU
801005f1:	c7 05 c0 c5 10 80 01 	movl   $0x1,0x8010c5c0
801005f8:	00 00 00 
  for(;;)
    ;
801005fb:	eb fe                	jmp    801005fb <panic+0x99>

801005fd <cgaputc>:
#define CRTPORT 0x3d4
static ushort *crt = (ushort*)P2V(0xb8000);  // CGA memory

static void
cgaputc(int c)
{
801005fd:	55                   	push   %ebp
801005fe:	89 e5                	mov    %esp,%ebp
80100600:	83 ec 18             	sub    $0x18,%esp
  int pos;
  
  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
80100603:	6a 0e                	push   $0xe
80100605:	68 d4 03 00 00       	push   $0x3d4
8010060a:	e8 de fc ff ff       	call   801002ed <outb>
8010060f:	83 c4 08             	add    $0x8,%esp
  pos = inb(CRTPORT+1) << 8;
80100612:	68 d5 03 00 00       	push   $0x3d5
80100617:	e8 b4 fc ff ff       	call   801002d0 <inb>
8010061c:	83 c4 04             	add    $0x4,%esp
8010061f:	0f b6 c0             	movzbl %al,%eax
80100622:	c1 e0 08             	shl    $0x8,%eax
80100625:	89 45 f4             	mov    %eax,-0xc(%ebp)
  outb(CRTPORT, 15);
80100628:	6a 0f                	push   $0xf
8010062a:	68 d4 03 00 00       	push   $0x3d4
8010062f:	e8 b9 fc ff ff       	call   801002ed <outb>
80100634:	83 c4 08             	add    $0x8,%esp
  pos |= inb(CRTPORT+1);
80100637:	68 d5 03 00 00       	push   $0x3d5
8010063c:	e8 8f fc ff ff       	call   801002d0 <inb>
80100641:	83 c4 04             	add    $0x4,%esp
80100644:	0f b6 c0             	movzbl %al,%eax
80100647:	09 45 f4             	or     %eax,-0xc(%ebp)

  if(c == '\n')
8010064a:	83 7d 08 0a          	cmpl   $0xa,0x8(%ebp)
8010064e:	75 30                	jne    80100680 <cgaputc+0x83>
    pos += 80 - pos%80;
80100650:	8b 4d f4             	mov    -0xc(%ebp),%ecx
80100653:	ba 67 66 66 66       	mov    $0x66666667,%edx
80100658:	89 c8                	mov    %ecx,%eax
8010065a:	f7 ea                	imul   %edx
8010065c:	c1 fa 05             	sar    $0x5,%edx
8010065f:	89 c8                	mov    %ecx,%eax
80100661:	c1 f8 1f             	sar    $0x1f,%eax
80100664:	29 c2                	sub    %eax,%edx
80100666:	89 d0                	mov    %edx,%eax
80100668:	c1 e0 02             	shl    $0x2,%eax
8010066b:	01 d0                	add    %edx,%eax
8010066d:	c1 e0 04             	shl    $0x4,%eax
80100670:	29 c1                	sub    %eax,%ecx
80100672:	89 ca                	mov    %ecx,%edx
80100674:	b8 50 00 00 00       	mov    $0x50,%eax
80100679:	29 d0                	sub    %edx,%eax
8010067b:	01 45 f4             	add    %eax,-0xc(%ebp)
8010067e:	eb 34                	jmp    801006b4 <cgaputc+0xb7>
  else if(c == BACKSPACE){
80100680:	81 7d 08 00 01 00 00 	cmpl   $0x100,0x8(%ebp)
80100687:	75 0c                	jne    80100695 <cgaputc+0x98>
    if(pos > 0) --pos;
80100689:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010068d:	7e 25                	jle    801006b4 <cgaputc+0xb7>
8010068f:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
80100693:	eb 1f                	jmp    801006b4 <cgaputc+0xb7>
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
80100695:	8b 0d 00 a0 10 80    	mov    0x8010a000,%ecx
8010069b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010069e:	8d 50 01             	lea    0x1(%eax),%edx
801006a1:	89 55 f4             	mov    %edx,-0xc(%ebp)
801006a4:	01 c0                	add    %eax,%eax
801006a6:	01 c8                	add    %ecx,%eax
801006a8:	8b 55 08             	mov    0x8(%ebp),%edx
801006ab:	0f b6 d2             	movzbl %dl,%edx
801006ae:	80 ce 07             	or     $0x7,%dh
801006b1:	66 89 10             	mov    %dx,(%eax)
  
  if((pos/80) >= 24){  // Scroll up.
801006b4:	81 7d f4 7f 07 00 00 	cmpl   $0x77f,-0xc(%ebp)
801006bb:	7e 4c                	jle    80100709 <cgaputc+0x10c>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801006bd:	a1 00 a0 10 80       	mov    0x8010a000,%eax
801006c2:	8d 90 a0 00 00 00    	lea    0xa0(%eax),%edx
801006c8:	a1 00 a0 10 80       	mov    0x8010a000,%eax
801006cd:	83 ec 04             	sub    $0x4,%esp
801006d0:	68 60 0e 00 00       	push   $0xe60
801006d5:	52                   	push   %edx
801006d6:	50                   	push   %eax
801006d7:	e8 a0 4f 00 00       	call   8010567c <memmove>
801006dc:	83 c4 10             	add    $0x10,%esp
    pos -= 80;
801006df:	83 6d f4 50          	subl   $0x50,-0xc(%ebp)
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
801006e3:	b8 80 07 00 00       	mov    $0x780,%eax
801006e8:	2b 45 f4             	sub    -0xc(%ebp),%eax
801006eb:	8d 14 00             	lea    (%eax,%eax,1),%edx
801006ee:	a1 00 a0 10 80       	mov    0x8010a000,%eax
801006f3:	8b 4d f4             	mov    -0xc(%ebp),%ecx
801006f6:	01 c9                	add    %ecx,%ecx
801006f8:	01 c8                	add    %ecx,%eax
801006fa:	83 ec 04             	sub    $0x4,%esp
801006fd:	52                   	push   %edx
801006fe:	6a 00                	push   $0x0
80100700:	50                   	push   %eax
80100701:	e8 b7 4e 00 00       	call   801055bd <memset>
80100706:	83 c4 10             	add    $0x10,%esp
  }
  
  outb(CRTPORT, 14);
80100709:	83 ec 08             	sub    $0x8,%esp
8010070c:	6a 0e                	push   $0xe
8010070e:	68 d4 03 00 00       	push   $0x3d4
80100713:	e8 d5 fb ff ff       	call   801002ed <outb>
80100718:	83 c4 10             	add    $0x10,%esp
  outb(CRTPORT+1, pos>>8);
8010071b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010071e:	c1 f8 08             	sar    $0x8,%eax
80100721:	0f b6 c0             	movzbl %al,%eax
80100724:	83 ec 08             	sub    $0x8,%esp
80100727:	50                   	push   %eax
80100728:	68 d5 03 00 00       	push   $0x3d5
8010072d:	e8 bb fb ff ff       	call   801002ed <outb>
80100732:	83 c4 10             	add    $0x10,%esp
  outb(CRTPORT, 15);
80100735:	83 ec 08             	sub    $0x8,%esp
80100738:	6a 0f                	push   $0xf
8010073a:	68 d4 03 00 00       	push   $0x3d4
8010073f:	e8 a9 fb ff ff       	call   801002ed <outb>
80100744:	83 c4 10             	add    $0x10,%esp
  outb(CRTPORT+1, pos);
80100747:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010074a:	0f b6 c0             	movzbl %al,%eax
8010074d:	83 ec 08             	sub    $0x8,%esp
80100750:	50                   	push   %eax
80100751:	68 d5 03 00 00       	push   $0x3d5
80100756:	e8 92 fb ff ff       	call   801002ed <outb>
8010075b:	83 c4 10             	add    $0x10,%esp
  crt[pos] = ' ' | 0x0700;
8010075e:	a1 00 a0 10 80       	mov    0x8010a000,%eax
80100763:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100766:	01 d2                	add    %edx,%edx
80100768:	01 d0                	add    %edx,%eax
8010076a:	66 c7 00 20 07       	movw   $0x720,(%eax)
}
8010076f:	90                   	nop
80100770:	c9                   	leave  
80100771:	c3                   	ret    

80100772 <consputc>:

void
consputc(int c)
{
80100772:	55                   	push   %ebp
80100773:	89 e5                	mov    %esp,%ebp
80100775:	83 ec 08             	sub    $0x8,%esp
  if(panicked){
80100778:	a1 c0 c5 10 80       	mov    0x8010c5c0,%eax
8010077d:	85 c0                	test   %eax,%eax
8010077f:	74 07                	je     80100788 <consputc+0x16>
    cli();
80100781:	e8 86 fb ff ff       	call   8010030c <cli>
    for(;;)
      ;
80100786:	eb fe                	jmp    80100786 <consputc+0x14>
  }

  if(c == BACKSPACE){
80100788:	81 7d 08 00 01 00 00 	cmpl   $0x100,0x8(%ebp)
8010078f:	75 29                	jne    801007ba <consputc+0x48>
    uartputc('\b'); uartputc(' '); uartputc('\b');
80100791:	83 ec 0c             	sub    $0xc,%esp
80100794:	6a 08                	push   $0x8
80100796:	e8 7d 67 00 00       	call   80106f18 <uartputc>
8010079b:	83 c4 10             	add    $0x10,%esp
8010079e:	83 ec 0c             	sub    $0xc,%esp
801007a1:	6a 20                	push   $0x20
801007a3:	e8 70 67 00 00       	call   80106f18 <uartputc>
801007a8:	83 c4 10             	add    $0x10,%esp
801007ab:	83 ec 0c             	sub    $0xc,%esp
801007ae:	6a 08                	push   $0x8
801007b0:	e8 63 67 00 00       	call   80106f18 <uartputc>
801007b5:	83 c4 10             	add    $0x10,%esp
801007b8:	eb 0e                	jmp    801007c8 <consputc+0x56>
  } else
    uartputc(c);
801007ba:	83 ec 0c             	sub    $0xc,%esp
801007bd:	ff 75 08             	pushl  0x8(%ebp)
801007c0:	e8 53 67 00 00       	call   80106f18 <uartputc>
801007c5:	83 c4 10             	add    $0x10,%esp
  cgaputc(c);
801007c8:	83 ec 0c             	sub    $0xc,%esp
801007cb:	ff 75 08             	pushl  0x8(%ebp)
801007ce:	e8 2a fe ff ff       	call   801005fd <cgaputc>
801007d3:	83 c4 10             	add    $0x10,%esp
}
801007d6:	90                   	nop
801007d7:	c9                   	leave  
801007d8:	c3                   	ret    

801007d9 <consoleintr>:

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
801007d9:	55                   	push   %ebp
801007da:	89 e5                	mov    %esp,%ebp
801007dc:	83 ec 18             	sub    $0x18,%esp
  int c;

  acquire(&input.lock);
801007df:	83 ec 0c             	sub    $0xc,%esp
801007e2:	68 a0 1b 11 80       	push   $0x80111ba0
801007e7:	e8 70 4b 00 00       	call   8010535c <acquire>
801007ec:	83 c4 10             	add    $0x10,%esp
  while((c = getc()) >= 0){
801007ef:	e9 42 01 00 00       	jmp    80100936 <consoleintr+0x15d>
    switch(c){
801007f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801007f7:	83 f8 10             	cmp    $0x10,%eax
801007fa:	74 1e                	je     8010081a <consoleintr+0x41>
801007fc:	83 f8 10             	cmp    $0x10,%eax
801007ff:	7f 0a                	jg     8010080b <consoleintr+0x32>
80100801:	83 f8 08             	cmp    $0x8,%eax
80100804:	74 69                	je     8010086f <consoleintr+0x96>
80100806:	e9 99 00 00 00       	jmp    801008a4 <consoleintr+0xcb>
8010080b:	83 f8 15             	cmp    $0x15,%eax
8010080e:	74 31                	je     80100841 <consoleintr+0x68>
80100810:	83 f8 7f             	cmp    $0x7f,%eax
80100813:	74 5a                	je     8010086f <consoleintr+0x96>
80100815:	e9 8a 00 00 00       	jmp    801008a4 <consoleintr+0xcb>
    case C('P'):  // Process listing.
      procdump();
8010081a:	e8 c6 49 00 00       	call   801051e5 <procdump>
      break;
8010081f:	e9 12 01 00 00       	jmp    80100936 <consoleintr+0x15d>
    case C('U'):  // Kill line.
      while(input.e != input.w &&
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
80100824:	a1 5c 1c 11 80       	mov    0x80111c5c,%eax
80100829:	83 e8 01             	sub    $0x1,%eax
8010082c:	a3 5c 1c 11 80       	mov    %eax,0x80111c5c
        consputc(BACKSPACE);
80100831:	83 ec 0c             	sub    $0xc,%esp
80100834:	68 00 01 00 00       	push   $0x100
80100839:	e8 34 ff ff ff       	call   80100772 <consputc>
8010083e:	83 c4 10             	add    $0x10,%esp
    switch(c){
    case C('P'):  // Process listing.
      procdump();
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
80100841:	8b 15 5c 1c 11 80    	mov    0x80111c5c,%edx
80100847:	a1 58 1c 11 80       	mov    0x80111c58,%eax
8010084c:	39 c2                	cmp    %eax,%edx
8010084e:	0f 84 e2 00 00 00    	je     80100936 <consoleintr+0x15d>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100854:	a1 5c 1c 11 80       	mov    0x80111c5c,%eax
80100859:	83 e8 01             	sub    $0x1,%eax
8010085c:	83 e0 7f             	and    $0x7f,%eax
8010085f:	0f b6 80 d4 1b 11 80 	movzbl -0x7feee42c(%eax),%eax
    switch(c){
    case C('P'):  // Process listing.
      procdump();
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
80100866:	3c 0a                	cmp    $0xa,%al
80100868:	75 ba                	jne    80100824 <consoleintr+0x4b>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
        consputc(BACKSPACE);
      }
      break;
8010086a:	e9 c7 00 00 00       	jmp    80100936 <consoleintr+0x15d>
    case C('H'): case '\x7f':  // Backspace
      if(input.e != input.w){
8010086f:	8b 15 5c 1c 11 80    	mov    0x80111c5c,%edx
80100875:	a1 58 1c 11 80       	mov    0x80111c58,%eax
8010087a:	39 c2                	cmp    %eax,%edx
8010087c:	0f 84 b4 00 00 00    	je     80100936 <consoleintr+0x15d>
        input.e--;
80100882:	a1 5c 1c 11 80       	mov    0x80111c5c,%eax
80100887:	83 e8 01             	sub    $0x1,%eax
8010088a:	a3 5c 1c 11 80       	mov    %eax,0x80111c5c
        consputc(BACKSPACE);
8010088f:	83 ec 0c             	sub    $0xc,%esp
80100892:	68 00 01 00 00       	push   $0x100
80100897:	e8 d6 fe ff ff       	call   80100772 <consputc>
8010089c:	83 c4 10             	add    $0x10,%esp
      }
      break;
8010089f:	e9 92 00 00 00       	jmp    80100936 <consoleintr+0x15d>
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
801008a4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801008a8:	0f 84 87 00 00 00    	je     80100935 <consoleintr+0x15c>
801008ae:	8b 15 5c 1c 11 80    	mov    0x80111c5c,%edx
801008b4:	a1 54 1c 11 80       	mov    0x80111c54,%eax
801008b9:	29 c2                	sub    %eax,%edx
801008bb:	89 d0                	mov    %edx,%eax
801008bd:	83 f8 7f             	cmp    $0x7f,%eax
801008c0:	77 73                	ja     80100935 <consoleintr+0x15c>
        c = (c == '\r') ? '\n' : c;
801008c2:	83 7d f4 0d          	cmpl   $0xd,-0xc(%ebp)
801008c6:	74 05                	je     801008cd <consoleintr+0xf4>
801008c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801008cb:	eb 05                	jmp    801008d2 <consoleintr+0xf9>
801008cd:	b8 0a 00 00 00       	mov    $0xa,%eax
801008d2:	89 45 f4             	mov    %eax,-0xc(%ebp)
        input.buf[input.e++ % INPUT_BUF] = c;
801008d5:	a1 5c 1c 11 80       	mov    0x80111c5c,%eax
801008da:	8d 50 01             	lea    0x1(%eax),%edx
801008dd:	89 15 5c 1c 11 80    	mov    %edx,0x80111c5c
801008e3:	83 e0 7f             	and    $0x7f,%eax
801008e6:	8b 55 f4             	mov    -0xc(%ebp),%edx
801008e9:	88 90 d4 1b 11 80    	mov    %dl,-0x7feee42c(%eax)
        consputc(c);
801008ef:	83 ec 0c             	sub    $0xc,%esp
801008f2:	ff 75 f4             	pushl  -0xc(%ebp)
801008f5:	e8 78 fe ff ff       	call   80100772 <consputc>
801008fa:	83 c4 10             	add    $0x10,%esp
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801008fd:	83 7d f4 0a          	cmpl   $0xa,-0xc(%ebp)
80100901:	74 18                	je     8010091b <consoleintr+0x142>
80100903:	83 7d f4 04          	cmpl   $0x4,-0xc(%ebp)
80100907:	74 12                	je     8010091b <consoleintr+0x142>
80100909:	a1 5c 1c 11 80       	mov    0x80111c5c,%eax
8010090e:	8b 15 54 1c 11 80    	mov    0x80111c54,%edx
80100914:	83 ea 80             	sub    $0xffffff80,%edx
80100917:	39 d0                	cmp    %edx,%eax
80100919:	75 1a                	jne    80100935 <consoleintr+0x15c>
          input.w = input.e;
8010091b:	a1 5c 1c 11 80       	mov    0x80111c5c,%eax
80100920:	a3 58 1c 11 80       	mov    %eax,0x80111c58
          wakeup(&input.r);
80100925:	83 ec 0c             	sub    $0xc,%esp
80100928:	68 54 1c 11 80       	push   $0x80111c54
8010092d:	e8 e7 47 00 00       	call   80105119 <wakeup>
80100932:	83 c4 10             	add    $0x10,%esp
        }
      }
      break;
80100935:	90                   	nop
consoleintr(int (*getc)(void))
{
  int c;

  acquire(&input.lock);
  while((c = getc()) >= 0){
80100936:	8b 45 08             	mov    0x8(%ebp),%eax
80100939:	ff d0                	call   *%eax
8010093b:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010093e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80100942:	0f 89 ac fe ff ff    	jns    801007f4 <consoleintr+0x1b>
        }
      }
      break;
    }
  }
  release(&input.lock);
80100948:	83 ec 0c             	sub    $0xc,%esp
8010094b:	68 a0 1b 11 80       	push   $0x80111ba0
80100950:	e8 6e 4a 00 00       	call   801053c3 <release>
80100955:	83 c4 10             	add    $0x10,%esp
}
80100958:	90                   	nop
80100959:	c9                   	leave  
8010095a:	c3                   	ret    

8010095b <consoleread>:

int
consoleread(struct inode *ip, char *dst, int n)
{
8010095b:	55                   	push   %ebp
8010095c:	89 e5                	mov    %esp,%ebp
8010095e:	83 ec 18             	sub    $0x18,%esp
  uint target;
  int c;

  iunlock(ip);
80100961:	83 ec 0c             	sub    $0xc,%esp
80100964:	ff 75 08             	pushl  0x8(%ebp)
80100967:	e8 3a 11 00 00       	call   80101aa6 <iunlock>
8010096c:	83 c4 10             	add    $0x10,%esp
  target = n;
8010096f:	8b 45 10             	mov    0x10(%ebp),%eax
80100972:	89 45 f4             	mov    %eax,-0xc(%ebp)
  acquire(&input.lock);
80100975:	83 ec 0c             	sub    $0xc,%esp
80100978:	68 a0 1b 11 80       	push   $0x80111ba0
8010097d:	e8 da 49 00 00       	call   8010535c <acquire>
80100982:	83 c4 10             	add    $0x10,%esp
  while(n > 0){
80100985:	e9 ac 00 00 00       	jmp    80100a36 <consoleread+0xdb>
    while(input.r == input.w){
      if(proc->killed){
8010098a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100990:	8b 40 24             	mov    0x24(%eax),%eax
80100993:	85 c0                	test   %eax,%eax
80100995:	74 28                	je     801009bf <consoleread+0x64>
        release(&input.lock);
80100997:	83 ec 0c             	sub    $0xc,%esp
8010099a:	68 a0 1b 11 80       	push   $0x80111ba0
8010099f:	e8 1f 4a 00 00       	call   801053c3 <release>
801009a4:	83 c4 10             	add    $0x10,%esp
        ilock(ip);
801009a7:	83 ec 0c             	sub    $0xc,%esp
801009aa:	ff 75 08             	pushl  0x8(%ebp)
801009ad:	e8 96 0f 00 00       	call   80101948 <ilock>
801009b2:	83 c4 10             	add    $0x10,%esp
        return -1;
801009b5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801009ba:	e9 ab 00 00 00       	jmp    80100a6a <consoleread+0x10f>
      }
      sleep(&input.r, &input.lock);
801009bf:	83 ec 08             	sub    $0x8,%esp
801009c2:	68 a0 1b 11 80       	push   $0x80111ba0
801009c7:	68 54 1c 11 80       	push   $0x80111c54
801009cc:	e8 4c 46 00 00       	call   8010501d <sleep>
801009d1:	83 c4 10             	add    $0x10,%esp

  iunlock(ip);
  target = n;
  acquire(&input.lock);
  while(n > 0){
    while(input.r == input.w){
801009d4:	8b 15 54 1c 11 80    	mov    0x80111c54,%edx
801009da:	a1 58 1c 11 80       	mov    0x80111c58,%eax
801009df:	39 c2                	cmp    %eax,%edx
801009e1:	74 a7                	je     8010098a <consoleread+0x2f>
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &input.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
801009e3:	a1 54 1c 11 80       	mov    0x80111c54,%eax
801009e8:	8d 50 01             	lea    0x1(%eax),%edx
801009eb:	89 15 54 1c 11 80    	mov    %edx,0x80111c54
801009f1:	83 e0 7f             	and    $0x7f,%eax
801009f4:	0f b6 80 d4 1b 11 80 	movzbl -0x7feee42c(%eax),%eax
801009fb:	0f be c0             	movsbl %al,%eax
801009fe:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(c == C('D')){  // EOF
80100a01:	83 7d f0 04          	cmpl   $0x4,-0x10(%ebp)
80100a05:	75 17                	jne    80100a1e <consoleread+0xc3>
      if(n < target){
80100a07:	8b 45 10             	mov    0x10(%ebp),%eax
80100a0a:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80100a0d:	73 2f                	jae    80100a3e <consoleread+0xe3>
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
80100a0f:	a1 54 1c 11 80       	mov    0x80111c54,%eax
80100a14:	83 e8 01             	sub    $0x1,%eax
80100a17:	a3 54 1c 11 80       	mov    %eax,0x80111c54
      }
      break;
80100a1c:	eb 20                	jmp    80100a3e <consoleread+0xe3>
    }
    *dst++ = c;
80100a1e:	8b 45 0c             	mov    0xc(%ebp),%eax
80100a21:	8d 50 01             	lea    0x1(%eax),%edx
80100a24:	89 55 0c             	mov    %edx,0xc(%ebp)
80100a27:	8b 55 f0             	mov    -0x10(%ebp),%edx
80100a2a:	88 10                	mov    %dl,(%eax)
    --n;
80100a2c:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    if(c == '\n')
80100a30:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
80100a34:	74 0b                	je     80100a41 <consoleread+0xe6>
  int c;

  iunlock(ip);
  target = n;
  acquire(&input.lock);
  while(n > 0){
80100a36:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80100a3a:	7f 98                	jg     801009d4 <consoleread+0x79>
80100a3c:	eb 04                	jmp    80100a42 <consoleread+0xe7>
      if(n < target){
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
80100a3e:	90                   	nop
80100a3f:	eb 01                	jmp    80100a42 <consoleread+0xe7>
    }
    *dst++ = c;
    --n;
    if(c == '\n')
      break;
80100a41:	90                   	nop
  }
  release(&input.lock);
80100a42:	83 ec 0c             	sub    $0xc,%esp
80100a45:	68 a0 1b 11 80       	push   $0x80111ba0
80100a4a:	e8 74 49 00 00       	call   801053c3 <release>
80100a4f:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80100a52:	83 ec 0c             	sub    $0xc,%esp
80100a55:	ff 75 08             	pushl  0x8(%ebp)
80100a58:	e8 eb 0e 00 00       	call   80101948 <ilock>
80100a5d:	83 c4 10             	add    $0x10,%esp

  return target - n;
80100a60:	8b 45 10             	mov    0x10(%ebp),%eax
80100a63:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100a66:	29 c2                	sub    %eax,%edx
80100a68:	89 d0                	mov    %edx,%eax
}
80100a6a:	c9                   	leave  
80100a6b:	c3                   	ret    

80100a6c <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100a6c:	55                   	push   %ebp
80100a6d:	89 e5                	mov    %esp,%ebp
80100a6f:	83 ec 18             	sub    $0x18,%esp
  int i;

  iunlock(ip);
80100a72:	83 ec 0c             	sub    $0xc,%esp
80100a75:	ff 75 08             	pushl  0x8(%ebp)
80100a78:	e8 29 10 00 00       	call   80101aa6 <iunlock>
80100a7d:	83 c4 10             	add    $0x10,%esp
  acquire(&cons.lock);
80100a80:	83 ec 0c             	sub    $0xc,%esp
80100a83:	68 e0 c5 10 80       	push   $0x8010c5e0
80100a88:	e8 cf 48 00 00       	call   8010535c <acquire>
80100a8d:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < n; i++)
80100a90:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80100a97:	eb 21                	jmp    80100aba <consolewrite+0x4e>
    consputc(buf[i] & 0xff);
80100a99:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100a9c:	8b 45 0c             	mov    0xc(%ebp),%eax
80100a9f:	01 d0                	add    %edx,%eax
80100aa1:	0f b6 00             	movzbl (%eax),%eax
80100aa4:	0f be c0             	movsbl %al,%eax
80100aa7:	0f b6 c0             	movzbl %al,%eax
80100aaa:	83 ec 0c             	sub    $0xc,%esp
80100aad:	50                   	push   %eax
80100aae:	e8 bf fc ff ff       	call   80100772 <consputc>
80100ab3:	83 c4 10             	add    $0x10,%esp
{
  int i;

  iunlock(ip);
  acquire(&cons.lock);
  for(i = 0; i < n; i++)
80100ab6:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100aba:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100abd:	3b 45 10             	cmp    0x10(%ebp),%eax
80100ac0:	7c d7                	jl     80100a99 <consolewrite+0x2d>
    consputc(buf[i] & 0xff);
  release(&cons.lock);
80100ac2:	83 ec 0c             	sub    $0xc,%esp
80100ac5:	68 e0 c5 10 80       	push   $0x8010c5e0
80100aca:	e8 f4 48 00 00       	call   801053c3 <release>
80100acf:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80100ad2:	83 ec 0c             	sub    $0xc,%esp
80100ad5:	ff 75 08             	pushl  0x8(%ebp)
80100ad8:	e8 6b 0e 00 00       	call   80101948 <ilock>
80100add:	83 c4 10             	add    $0x10,%esp

  return n;
80100ae0:	8b 45 10             	mov    0x10(%ebp),%eax
}
80100ae3:	c9                   	leave  
80100ae4:	c3                   	ret    

80100ae5 <consoleinit>:

void
consoleinit(void)
{
80100ae5:	55                   	push   %ebp
80100ae6:	89 e5                	mov    %esp,%ebp
80100ae8:	83 ec 08             	sub    $0x8,%esp
  initlock(&cons.lock, "console");
80100aeb:	83 ec 08             	sub    $0x8,%esp
80100aee:	68 db 88 10 80       	push   $0x801088db
80100af3:	68 e0 c5 10 80       	push   $0x8010c5e0
80100af8:	e8 3d 48 00 00       	call   8010533a <initlock>
80100afd:	83 c4 10             	add    $0x10,%esp
  initlock(&input.lock, "input");
80100b00:	83 ec 08             	sub    $0x8,%esp
80100b03:	68 e3 88 10 80       	push   $0x801088e3
80100b08:	68 a0 1b 11 80       	push   $0x80111ba0
80100b0d:	e8 28 48 00 00       	call   8010533a <initlock>
80100b12:	83 c4 10             	add    $0x10,%esp

  devsw[CONSOLE].write = consolewrite;
80100b15:	c7 05 4c 26 11 80 6c 	movl   $0x80100a6c,0x8011264c
80100b1c:	0a 10 80 
  devsw[CONSOLE].read = consoleread;
80100b1f:	c7 05 48 26 11 80 5b 	movl   $0x8010095b,0x80112648
80100b26:	09 10 80 
  cons.locking = 1;
80100b29:	c7 05 14 c6 10 80 01 	movl   $0x1,0x8010c614
80100b30:	00 00 00 

  picenable(IRQ_KBD);
80100b33:	83 ec 0c             	sub    $0xc,%esp
80100b36:	6a 01                	push   $0x1
80100b38:	e8 b1 33 00 00       	call   80103eee <picenable>
80100b3d:	83 c4 10             	add    $0x10,%esp
  ioapicenable(IRQ_KBD, 0);
80100b40:	83 ec 08             	sub    $0x8,%esp
80100b43:	6a 00                	push   $0x0
80100b45:	6a 01                	push   $0x1
80100b47:	e8 69 1f 00 00       	call   80102ab5 <ioapicenable>
80100b4c:	83 c4 10             	add    $0x10,%esp
}
80100b4f:	90                   	nop
80100b50:	c9                   	leave  
80100b51:	c3                   	ret    

80100b52 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100b52:	55                   	push   %ebp
80100b53:	89 e5                	mov    %esp,%ebp
80100b55:	81 ec 18 01 00 00    	sub    $0x118,%esp
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;

  begin_op();
80100b5b:	e8 b5 29 00 00       	call   80103515 <begin_op>
  if((ip = namei(path)) == 0){
80100b60:	83 ec 0c             	sub    $0xc,%esp
80100b63:	ff 75 08             	pushl  0x8(%ebp)
80100b66:	e8 9b 19 00 00       	call   80102506 <namei>
80100b6b:	83 c4 10             	add    $0x10,%esp
80100b6e:	89 45 d8             	mov    %eax,-0x28(%ebp)
80100b71:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
80100b75:	75 0f                	jne    80100b86 <exec+0x34>
    end_op();
80100b77:	e8 27 2a 00 00       	call   801035a3 <end_op>
    return -1;
80100b7c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100b81:	e9 ce 03 00 00       	jmp    80100f54 <exec+0x402>
  }
  ilock(ip);
80100b86:	83 ec 0c             	sub    $0xc,%esp
80100b89:	ff 75 d8             	pushl  -0x28(%ebp)
80100b8c:	e8 b7 0d 00 00       	call   80101948 <ilock>
80100b91:	83 c4 10             	add    $0x10,%esp
  pgdir = 0;
80100b94:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) < sizeof(elf))
80100b9b:	6a 34                	push   $0x34
80100b9d:	6a 00                	push   $0x0
80100b9f:	8d 85 0c ff ff ff    	lea    -0xf4(%ebp),%eax
80100ba5:	50                   	push   %eax
80100ba6:	ff 75 d8             	pushl  -0x28(%ebp)
80100ba9:	e8 08 13 00 00       	call   80101eb6 <readi>
80100bae:	83 c4 10             	add    $0x10,%esp
80100bb1:	83 f8 33             	cmp    $0x33,%eax
80100bb4:	0f 86 49 03 00 00    	jbe    80100f03 <exec+0x3b1>
    goto bad;
  if(elf.magic != ELF_MAGIC)
80100bba:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100bc0:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
80100bc5:	0f 85 3b 03 00 00    	jne    80100f06 <exec+0x3b4>
    goto bad;

  if((pgdir = setupkvm()) == 0)
80100bcb:	e8 9d 74 00 00       	call   8010806d <setupkvm>
80100bd0:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80100bd3:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
80100bd7:	0f 84 2c 03 00 00    	je     80100f09 <exec+0x3b7>
    goto bad;

  // Load program into memory.
  sz = 0;
80100bdd:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100be4:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
80100beb:	8b 85 28 ff ff ff    	mov    -0xd8(%ebp),%eax
80100bf1:	89 45 e8             	mov    %eax,-0x18(%ebp)
80100bf4:	e9 ab 00 00 00       	jmp    80100ca4 <exec+0x152>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100bf9:	8b 45 e8             	mov    -0x18(%ebp),%eax
80100bfc:	6a 20                	push   $0x20
80100bfe:	50                   	push   %eax
80100bff:	8d 85 ec fe ff ff    	lea    -0x114(%ebp),%eax
80100c05:	50                   	push   %eax
80100c06:	ff 75 d8             	pushl  -0x28(%ebp)
80100c09:	e8 a8 12 00 00       	call   80101eb6 <readi>
80100c0e:	83 c4 10             	add    $0x10,%esp
80100c11:	83 f8 20             	cmp    $0x20,%eax
80100c14:	0f 85 f2 02 00 00    	jne    80100f0c <exec+0x3ba>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
80100c1a:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
80100c20:	83 f8 01             	cmp    $0x1,%eax
80100c23:	75 71                	jne    80100c96 <exec+0x144>
      continue;
    if(ph.memsz < ph.filesz)
80100c25:	8b 95 00 ff ff ff    	mov    -0x100(%ebp),%edx
80100c2b:	8b 85 fc fe ff ff    	mov    -0x104(%ebp),%eax
80100c31:	39 c2                	cmp    %eax,%edx
80100c33:	0f 82 d6 02 00 00    	jb     80100f0f <exec+0x3bd>
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100c39:	8b 95 f4 fe ff ff    	mov    -0x10c(%ebp),%edx
80100c3f:	8b 85 00 ff ff ff    	mov    -0x100(%ebp),%eax
80100c45:	01 d0                	add    %edx,%eax
80100c47:	83 ec 04             	sub    $0x4,%esp
80100c4a:	50                   	push   %eax
80100c4b:	ff 75 e0             	pushl  -0x20(%ebp)
80100c4e:	ff 75 d4             	pushl  -0x2c(%ebp)
80100c51:	e8 be 77 00 00       	call   80108414 <allocuvm>
80100c56:	83 c4 10             	add    $0x10,%esp
80100c59:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100c5c:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80100c60:	0f 84 ac 02 00 00    	je     80100f12 <exec+0x3c0>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100c66:	8b 95 fc fe ff ff    	mov    -0x104(%ebp),%edx
80100c6c:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100c72:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
80100c78:	83 ec 0c             	sub    $0xc,%esp
80100c7b:	52                   	push   %edx
80100c7c:	50                   	push   %eax
80100c7d:	ff 75 d8             	pushl  -0x28(%ebp)
80100c80:	51                   	push   %ecx
80100c81:	ff 75 d4             	pushl  -0x2c(%ebp)
80100c84:	e8 b4 76 00 00       	call   8010833d <loaduvm>
80100c89:	83 c4 20             	add    $0x20,%esp
80100c8c:	85 c0                	test   %eax,%eax
80100c8e:	0f 88 81 02 00 00    	js     80100f15 <exec+0x3c3>
80100c94:	eb 01                	jmp    80100c97 <exec+0x145>
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
      continue;
80100c96:	90                   	nop
  if((pgdir = setupkvm()) == 0)
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100c97:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
80100c9b:	8b 45 e8             	mov    -0x18(%ebp),%eax
80100c9e:	83 c0 20             	add    $0x20,%eax
80100ca1:	89 45 e8             	mov    %eax,-0x18(%ebp)
80100ca4:	0f b7 85 38 ff ff ff 	movzwl -0xc8(%ebp),%eax
80100cab:	0f b7 c0             	movzwl %ax,%eax
80100cae:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80100cb1:	0f 8f 42 ff ff ff    	jg     80100bf9 <exec+0xa7>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
      goto bad;
  }
  iunlockput(ip);
80100cb7:	83 ec 0c             	sub    $0xc,%esp
80100cba:	ff 75 d8             	pushl  -0x28(%ebp)
80100cbd:	e8 46 0f 00 00       	call   80101c08 <iunlockput>
80100cc2:	83 c4 10             	add    $0x10,%esp
  end_op();
80100cc5:	e8 d9 28 00 00       	call   801035a3 <end_op>
  ip = 0;
80100cca:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
80100cd1:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100cd4:	05 ff 0f 00 00       	add    $0xfff,%eax
80100cd9:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80100cde:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100ce1:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100ce4:	05 00 20 00 00       	add    $0x2000,%eax
80100ce9:	83 ec 04             	sub    $0x4,%esp
80100cec:	50                   	push   %eax
80100ced:	ff 75 e0             	pushl  -0x20(%ebp)
80100cf0:	ff 75 d4             	pushl  -0x2c(%ebp)
80100cf3:	e8 1c 77 00 00       	call   80108414 <allocuvm>
80100cf8:	83 c4 10             	add    $0x10,%esp
80100cfb:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100cfe:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80100d02:	0f 84 10 02 00 00    	je     80100f18 <exec+0x3c6>
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100d08:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100d0b:	2d 00 20 00 00       	sub    $0x2000,%eax
80100d10:	83 ec 08             	sub    $0x8,%esp
80100d13:	50                   	push   %eax
80100d14:	ff 75 d4             	pushl  -0x2c(%ebp)
80100d17:	e8 1e 79 00 00       	call   8010863a <clearpteu>
80100d1c:	83 c4 10             	add    $0x10,%esp
  sp = sz;
80100d1f:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100d22:	89 45 dc             	mov    %eax,-0x24(%ebp)

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100d25:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80100d2c:	e9 96 00 00 00       	jmp    80100dc7 <exec+0x275>
    if(argc >= MAXARG)
80100d31:	83 7d e4 1f          	cmpl   $0x1f,-0x1c(%ebp)
80100d35:	0f 87 e0 01 00 00    	ja     80100f1b <exec+0x3c9>
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100d3b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100d3e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100d45:	8b 45 0c             	mov    0xc(%ebp),%eax
80100d48:	01 d0                	add    %edx,%eax
80100d4a:	8b 00                	mov    (%eax),%eax
80100d4c:	83 ec 0c             	sub    $0xc,%esp
80100d4f:	50                   	push   %eax
80100d50:	e8 b7 4a 00 00       	call   8010580c <strlen>
80100d55:	83 c4 10             	add    $0x10,%esp
80100d58:	89 c2                	mov    %eax,%edx
80100d5a:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100d5d:	29 d0                	sub    %edx,%eax
80100d5f:	83 e8 01             	sub    $0x1,%eax
80100d62:	83 e0 fc             	and    $0xfffffffc,%eax
80100d65:	89 45 dc             	mov    %eax,-0x24(%ebp)
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100d68:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100d6b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100d72:	8b 45 0c             	mov    0xc(%ebp),%eax
80100d75:	01 d0                	add    %edx,%eax
80100d77:	8b 00                	mov    (%eax),%eax
80100d79:	83 ec 0c             	sub    $0xc,%esp
80100d7c:	50                   	push   %eax
80100d7d:	e8 8a 4a 00 00       	call   8010580c <strlen>
80100d82:	83 c4 10             	add    $0x10,%esp
80100d85:	83 c0 01             	add    $0x1,%eax
80100d88:	89 c1                	mov    %eax,%ecx
80100d8a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100d8d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100d94:	8b 45 0c             	mov    0xc(%ebp),%eax
80100d97:	01 d0                	add    %edx,%eax
80100d99:	8b 00                	mov    (%eax),%eax
80100d9b:	51                   	push   %ecx
80100d9c:	50                   	push   %eax
80100d9d:	ff 75 dc             	pushl  -0x24(%ebp)
80100da0:	ff 75 d4             	pushl  -0x2c(%ebp)
80100da3:	e8 49 7a 00 00       	call   801087f1 <copyout>
80100da8:	83 c4 10             	add    $0x10,%esp
80100dab:	85 c0                	test   %eax,%eax
80100dad:	0f 88 6b 01 00 00    	js     80100f1e <exec+0x3cc>
      goto bad;
    ustack[3+argc] = sp;
80100db3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100db6:	8d 50 03             	lea    0x3(%eax),%edx
80100db9:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100dbc:	89 84 95 40 ff ff ff 	mov    %eax,-0xc0(%ebp,%edx,4)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100dc3:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
80100dc7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100dca:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100dd1:	8b 45 0c             	mov    0xc(%ebp),%eax
80100dd4:	01 d0                	add    %edx,%eax
80100dd6:	8b 00                	mov    (%eax),%eax
80100dd8:	85 c0                	test   %eax,%eax
80100dda:	0f 85 51 ff ff ff    	jne    80100d31 <exec+0x1df>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
  }
  ustack[3+argc] = 0;
80100de0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100de3:	83 c0 03             	add    $0x3,%eax
80100de6:	c7 84 85 40 ff ff ff 	movl   $0x0,-0xc0(%ebp,%eax,4)
80100ded:	00 00 00 00 

  ustack[0] = 0xffffffff;  // fake return PC
80100df1:	c7 85 40 ff ff ff ff 	movl   $0xffffffff,-0xc0(%ebp)
80100df8:	ff ff ff 
  ustack[1] = argc;
80100dfb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100dfe:	89 85 44 ff ff ff    	mov    %eax,-0xbc(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100e04:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100e07:	83 c0 01             	add    $0x1,%eax
80100e0a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100e11:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100e14:	29 d0                	sub    %edx,%eax
80100e16:	89 85 48 ff ff ff    	mov    %eax,-0xb8(%ebp)

  sp -= (3+argc+1) * 4;
80100e1c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100e1f:	83 c0 04             	add    $0x4,%eax
80100e22:	c1 e0 02             	shl    $0x2,%eax
80100e25:	29 45 dc             	sub    %eax,-0x24(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100e28:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100e2b:	83 c0 04             	add    $0x4,%eax
80100e2e:	c1 e0 02             	shl    $0x2,%eax
80100e31:	50                   	push   %eax
80100e32:	8d 85 40 ff ff ff    	lea    -0xc0(%ebp),%eax
80100e38:	50                   	push   %eax
80100e39:	ff 75 dc             	pushl  -0x24(%ebp)
80100e3c:	ff 75 d4             	pushl  -0x2c(%ebp)
80100e3f:	e8 ad 79 00 00       	call   801087f1 <copyout>
80100e44:	83 c4 10             	add    $0x10,%esp
80100e47:	85 c0                	test   %eax,%eax
80100e49:	0f 88 d2 00 00 00    	js     80100f21 <exec+0x3cf>
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100e4f:	8b 45 08             	mov    0x8(%ebp),%eax
80100e52:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100e55:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100e58:	89 45 f0             	mov    %eax,-0x10(%ebp)
80100e5b:	eb 17                	jmp    80100e74 <exec+0x322>
    if(*s == '/')
80100e5d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100e60:	0f b6 00             	movzbl (%eax),%eax
80100e63:	3c 2f                	cmp    $0x2f,%al
80100e65:	75 09                	jne    80100e70 <exec+0x31e>
      last = s+1;
80100e67:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100e6a:	83 c0 01             	add    $0x1,%eax
80100e6d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100e70:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100e74:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100e77:	0f b6 00             	movzbl (%eax),%eax
80100e7a:	84 c0                	test   %al,%al
80100e7c:	75 df                	jne    80100e5d <exec+0x30b>
    if(*s == '/')
      last = s+1;
  safestrcpy(proc->name, last, sizeof(proc->name));
80100e7e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100e84:	83 c0 6c             	add    $0x6c,%eax
80100e87:	83 ec 04             	sub    $0x4,%esp
80100e8a:	6a 10                	push   $0x10
80100e8c:	ff 75 f0             	pushl  -0x10(%ebp)
80100e8f:	50                   	push   %eax
80100e90:	e8 2d 49 00 00       	call   801057c2 <safestrcpy>
80100e95:	83 c4 10             	add    $0x10,%esp

  // Commit to the user image.
  oldpgdir = proc->pgdir;
80100e98:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100e9e:	8b 40 04             	mov    0x4(%eax),%eax
80100ea1:	89 45 d0             	mov    %eax,-0x30(%ebp)
  proc->pgdir = pgdir;
80100ea4:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100eaa:	8b 55 d4             	mov    -0x2c(%ebp),%edx
80100ead:	89 50 04             	mov    %edx,0x4(%eax)
  proc->sz = sz;
80100eb0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100eb6:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100eb9:	89 10                	mov    %edx,(%eax)
  proc->tf->eip = elf.entry;  // main
80100ebb:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100ec1:	8b 40 18             	mov    0x18(%eax),%eax
80100ec4:	8b 95 24 ff ff ff    	mov    -0xdc(%ebp),%edx
80100eca:	89 50 38             	mov    %edx,0x38(%eax)
  proc->tf->esp = sp;
80100ecd:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100ed3:	8b 40 18             	mov    0x18(%eax),%eax
80100ed6:	8b 55 dc             	mov    -0x24(%ebp),%edx
80100ed9:	89 50 44             	mov    %edx,0x44(%eax)
  switchuvm(proc);
80100edc:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100ee2:	83 ec 0c             	sub    $0xc,%esp
80100ee5:	50                   	push   %eax
80100ee6:	e8 69 72 00 00       	call   80108154 <switchuvm>
80100eeb:	83 c4 10             	add    $0x10,%esp
  freevm(oldpgdir);
80100eee:	83 ec 0c             	sub    $0xc,%esp
80100ef1:	ff 75 d0             	pushl  -0x30(%ebp)
80100ef4:	e8 a1 76 00 00       	call   8010859a <freevm>
80100ef9:	83 c4 10             	add    $0x10,%esp
  return 0;
80100efc:	b8 00 00 00 00       	mov    $0x0,%eax
80100f01:	eb 51                	jmp    80100f54 <exec+0x402>
  ilock(ip);
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) < sizeof(elf))
    goto bad;
80100f03:	90                   	nop
80100f04:	eb 1c                	jmp    80100f22 <exec+0x3d0>
  if(elf.magic != ELF_MAGIC)
    goto bad;
80100f06:	90                   	nop
80100f07:	eb 19                	jmp    80100f22 <exec+0x3d0>

  if((pgdir = setupkvm()) == 0)
    goto bad;
80100f09:	90                   	nop
80100f0a:	eb 16                	jmp    80100f22 <exec+0x3d0>

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
      goto bad;
80100f0c:	90                   	nop
80100f0d:	eb 13                	jmp    80100f22 <exec+0x3d0>
    if(ph.type != ELF_PROG_LOAD)
      continue;
    if(ph.memsz < ph.filesz)
      goto bad;
80100f0f:	90                   	nop
80100f10:	eb 10                	jmp    80100f22 <exec+0x3d0>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
      goto bad;
80100f12:	90                   	nop
80100f13:	eb 0d                	jmp    80100f22 <exec+0x3d0>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
      goto bad;
80100f15:	90                   	nop
80100f16:	eb 0a                	jmp    80100f22 <exec+0x3d0>

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
    goto bad;
80100f18:	90                   	nop
80100f19:	eb 07                	jmp    80100f22 <exec+0x3d0>
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
    if(argc >= MAXARG)
      goto bad;
80100f1b:	90                   	nop
80100f1c:	eb 04                	jmp    80100f22 <exec+0x3d0>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
80100f1e:	90                   	nop
80100f1f:	eb 01                	jmp    80100f22 <exec+0x3d0>
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // argv pointer

  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;
80100f21:	90                   	nop
  switchuvm(proc);
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
80100f22:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
80100f26:	74 0e                	je     80100f36 <exec+0x3e4>
    freevm(pgdir);
80100f28:	83 ec 0c             	sub    $0xc,%esp
80100f2b:	ff 75 d4             	pushl  -0x2c(%ebp)
80100f2e:	e8 67 76 00 00       	call   8010859a <freevm>
80100f33:	83 c4 10             	add    $0x10,%esp
  if(ip){
80100f36:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
80100f3a:	74 13                	je     80100f4f <exec+0x3fd>
    iunlockput(ip);
80100f3c:	83 ec 0c             	sub    $0xc,%esp
80100f3f:	ff 75 d8             	pushl  -0x28(%ebp)
80100f42:	e8 c1 0c 00 00       	call   80101c08 <iunlockput>
80100f47:	83 c4 10             	add    $0x10,%esp
    end_op();
80100f4a:	e8 54 26 00 00       	call   801035a3 <end_op>
  }
  return -1;
80100f4f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100f54:	c9                   	leave  
80100f55:	c3                   	ret    

80100f56 <fileinit>:
80100f56:	55                   	push   %ebp
80100f57:	89 e5                	mov    %esp,%ebp
80100f59:	83 ec 08             	sub    $0x8,%esp
80100f5c:	83 ec 08             	sub    $0x8,%esp
80100f5f:	68 e9 88 10 80       	push   $0x801088e9
80100f64:	68 80 1c 11 80       	push   $0x80111c80
80100f69:	e8 cc 43 00 00       	call   8010533a <initlock>
80100f6e:	83 c4 10             	add    $0x10,%esp
80100f71:	c9                   	leave  
80100f72:	c3                   	ret    

80100f73 <filealloc>:
80100f73:	55                   	push   %ebp
80100f74:	89 e5                	mov    %esp,%ebp
80100f76:	83 ec 18             	sub    $0x18,%esp
80100f79:	83 ec 0c             	sub    $0xc,%esp
80100f7c:	68 80 1c 11 80       	push   $0x80111c80
80100f81:	e8 d6 43 00 00       	call   8010535c <acquire>
80100f86:	83 c4 10             	add    $0x10,%esp
80100f89:	c7 45 f4 b4 1c 11 80 	movl   $0x80111cb4,-0xc(%ebp)
80100f90:	eb 2d                	jmp    80100fbf <filealloc+0x4c>
80100f92:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100f95:	8b 40 04             	mov    0x4(%eax),%eax
80100f98:	85 c0                	test   %eax,%eax
80100f9a:	75 1f                	jne    80100fbb <filealloc+0x48>
80100f9c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100f9f:	c7 40 04 01 00 00 00 	movl   $0x1,0x4(%eax)
80100fa6:	83 ec 0c             	sub    $0xc,%esp
80100fa9:	68 80 1c 11 80       	push   $0x80111c80
80100fae:	e8 10 44 00 00       	call   801053c3 <release>
80100fb3:	83 c4 10             	add    $0x10,%esp
80100fb6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100fb9:	eb 22                	jmp    80100fdd <filealloc+0x6a>
80100fbb:	83 45 f4 18          	addl   $0x18,-0xc(%ebp)
80100fbf:	81 7d f4 14 26 11 80 	cmpl   $0x80112614,-0xc(%ebp)
80100fc6:	72 ca                	jb     80100f92 <filealloc+0x1f>
80100fc8:	83 ec 0c             	sub    $0xc,%esp
80100fcb:	68 80 1c 11 80       	push   $0x80111c80
80100fd0:	e8 ee 43 00 00       	call   801053c3 <release>
80100fd5:	83 c4 10             	add    $0x10,%esp
80100fd8:	b8 00 00 00 00       	mov    $0x0,%eax
80100fdd:	c9                   	leave  
80100fde:	c3                   	ret    

80100fdf <filedup>:
80100fdf:	55                   	push   %ebp
80100fe0:	89 e5                	mov    %esp,%ebp
80100fe2:	83 ec 08             	sub    $0x8,%esp
80100fe5:	83 ec 0c             	sub    $0xc,%esp
80100fe8:	68 80 1c 11 80       	push   $0x80111c80
80100fed:	e8 6a 43 00 00       	call   8010535c <acquire>
80100ff2:	83 c4 10             	add    $0x10,%esp
80100ff5:	8b 45 08             	mov    0x8(%ebp),%eax
80100ff8:	8b 40 04             	mov    0x4(%eax),%eax
80100ffb:	85 c0                	test   %eax,%eax
80100ffd:	7f 0d                	jg     8010100c <filedup+0x2d>
80100fff:	83 ec 0c             	sub    $0xc,%esp
80101002:	68 f0 88 10 80       	push   $0x801088f0
80101007:	e8 56 f5 ff ff       	call   80100562 <panic>
8010100c:	8b 45 08             	mov    0x8(%ebp),%eax
8010100f:	8b 40 04             	mov    0x4(%eax),%eax
80101012:	8d 50 01             	lea    0x1(%eax),%edx
80101015:	8b 45 08             	mov    0x8(%ebp),%eax
80101018:	89 50 04             	mov    %edx,0x4(%eax)
8010101b:	83 ec 0c             	sub    $0xc,%esp
8010101e:	68 80 1c 11 80       	push   $0x80111c80
80101023:	e8 9b 43 00 00       	call   801053c3 <release>
80101028:	83 c4 10             	add    $0x10,%esp
8010102b:	8b 45 08             	mov    0x8(%ebp),%eax
8010102e:	c9                   	leave  
8010102f:	c3                   	ret    

80101030 <fileclose>:
80101030:	55                   	push   %ebp
80101031:	89 e5                	mov    %esp,%ebp
80101033:	83 ec 28             	sub    $0x28,%esp
80101036:	83 ec 0c             	sub    $0xc,%esp
80101039:	68 80 1c 11 80       	push   $0x80111c80
8010103e:	e8 19 43 00 00       	call   8010535c <acquire>
80101043:	83 c4 10             	add    $0x10,%esp
80101046:	8b 45 08             	mov    0x8(%ebp),%eax
80101049:	8b 40 04             	mov    0x4(%eax),%eax
8010104c:	85 c0                	test   %eax,%eax
8010104e:	7f 0d                	jg     8010105d <fileclose+0x2d>
80101050:	83 ec 0c             	sub    $0xc,%esp
80101053:	68 f8 88 10 80       	push   $0x801088f8
80101058:	e8 05 f5 ff ff       	call   80100562 <panic>
8010105d:	8b 45 08             	mov    0x8(%ebp),%eax
80101060:	8b 40 04             	mov    0x4(%eax),%eax
80101063:	8d 50 ff             	lea    -0x1(%eax),%edx
80101066:	8b 45 08             	mov    0x8(%ebp),%eax
80101069:	89 50 04             	mov    %edx,0x4(%eax)
8010106c:	8b 45 08             	mov    0x8(%ebp),%eax
8010106f:	8b 40 04             	mov    0x4(%eax),%eax
80101072:	85 c0                	test   %eax,%eax
80101074:	7e 15                	jle    8010108b <fileclose+0x5b>
80101076:	83 ec 0c             	sub    $0xc,%esp
80101079:	68 80 1c 11 80       	push   $0x80111c80
8010107e:	e8 40 43 00 00       	call   801053c3 <release>
80101083:	83 c4 10             	add    $0x10,%esp
80101086:	e9 8b 00 00 00       	jmp    80101116 <fileclose+0xe6>
8010108b:	8b 45 08             	mov    0x8(%ebp),%eax
8010108e:	8b 10                	mov    (%eax),%edx
80101090:	89 55 e0             	mov    %edx,-0x20(%ebp)
80101093:	8b 50 04             	mov    0x4(%eax),%edx
80101096:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101099:	8b 50 08             	mov    0x8(%eax),%edx
8010109c:	89 55 e8             	mov    %edx,-0x18(%ebp)
8010109f:	8b 50 0c             	mov    0xc(%eax),%edx
801010a2:	89 55 ec             	mov    %edx,-0x14(%ebp)
801010a5:	8b 50 10             	mov    0x10(%eax),%edx
801010a8:	89 55 f0             	mov    %edx,-0x10(%ebp)
801010ab:	8b 40 14             	mov    0x14(%eax),%eax
801010ae:	89 45 f4             	mov    %eax,-0xc(%ebp)
801010b1:	8b 45 08             	mov    0x8(%ebp),%eax
801010b4:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
801010bb:	8b 45 08             	mov    0x8(%ebp),%eax
801010be:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
801010c4:	83 ec 0c             	sub    $0xc,%esp
801010c7:	68 80 1c 11 80       	push   $0x80111c80
801010cc:	e8 f2 42 00 00       	call   801053c3 <release>
801010d1:	83 c4 10             	add    $0x10,%esp
801010d4:	8b 45 e0             	mov    -0x20(%ebp),%eax
801010d7:	83 f8 01             	cmp    $0x1,%eax
801010da:	75 19                	jne    801010f5 <fileclose+0xc5>
801010dc:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
801010e0:	0f be d0             	movsbl %al,%edx
801010e3:	8b 45 ec             	mov    -0x14(%ebp),%eax
801010e6:	83 ec 08             	sub    $0x8,%esp
801010e9:	52                   	push   %edx
801010ea:	50                   	push   %eax
801010eb:	e8 65 30 00 00       	call   80104155 <pipeclose>
801010f0:	83 c4 10             	add    $0x10,%esp
801010f3:	eb 21                	jmp    80101116 <fileclose+0xe6>
801010f5:	8b 45 e0             	mov    -0x20(%ebp),%eax
801010f8:	83 f8 02             	cmp    $0x2,%eax
801010fb:	75 19                	jne    80101116 <fileclose+0xe6>
801010fd:	e8 13 24 00 00       	call   80103515 <begin_op>
80101102:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101105:	83 ec 0c             	sub    $0xc,%esp
80101108:	50                   	push   %eax
80101109:	e8 0a 0a 00 00       	call   80101b18 <iput>
8010110e:	83 c4 10             	add    $0x10,%esp
80101111:	e8 8d 24 00 00       	call   801035a3 <end_op>
80101116:	c9                   	leave  
80101117:	c3                   	ret    

80101118 <filestat>:
80101118:	55                   	push   %ebp
80101119:	89 e5                	mov    %esp,%ebp
8010111b:	83 ec 08             	sub    $0x8,%esp
8010111e:	8b 45 08             	mov    0x8(%ebp),%eax
80101121:	8b 00                	mov    (%eax),%eax
80101123:	83 f8 02             	cmp    $0x2,%eax
80101126:	75 40                	jne    80101168 <filestat+0x50>
80101128:	8b 45 08             	mov    0x8(%ebp),%eax
8010112b:	8b 40 10             	mov    0x10(%eax),%eax
8010112e:	83 ec 0c             	sub    $0xc,%esp
80101131:	50                   	push   %eax
80101132:	e8 11 08 00 00       	call   80101948 <ilock>
80101137:	83 c4 10             	add    $0x10,%esp
8010113a:	8b 45 08             	mov    0x8(%ebp),%eax
8010113d:	8b 40 10             	mov    0x10(%eax),%eax
80101140:	83 ec 08             	sub    $0x8,%esp
80101143:	ff 75 0c             	pushl  0xc(%ebp)
80101146:	50                   	push   %eax
80101147:	e8 24 0d 00 00       	call   80101e70 <stati>
8010114c:	83 c4 10             	add    $0x10,%esp
8010114f:	8b 45 08             	mov    0x8(%ebp),%eax
80101152:	8b 40 10             	mov    0x10(%eax),%eax
80101155:	83 ec 0c             	sub    $0xc,%esp
80101158:	50                   	push   %eax
80101159:	e8 48 09 00 00       	call   80101aa6 <iunlock>
8010115e:	83 c4 10             	add    $0x10,%esp
80101161:	b8 00 00 00 00       	mov    $0x0,%eax
80101166:	eb 05                	jmp    8010116d <filestat+0x55>
80101168:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010116d:	c9                   	leave  
8010116e:	c3                   	ret    

8010116f <fileread>:
8010116f:	55                   	push   %ebp
80101170:	89 e5                	mov    %esp,%ebp
80101172:	83 ec 18             	sub    $0x18,%esp
80101175:	8b 45 08             	mov    0x8(%ebp),%eax
80101178:	0f b6 40 08          	movzbl 0x8(%eax),%eax
8010117c:	84 c0                	test   %al,%al
8010117e:	75 0a                	jne    8010118a <fileread+0x1b>
80101180:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101185:	e9 9b 00 00 00       	jmp    80101225 <fileread+0xb6>
8010118a:	8b 45 08             	mov    0x8(%ebp),%eax
8010118d:	8b 00                	mov    (%eax),%eax
8010118f:	83 f8 01             	cmp    $0x1,%eax
80101192:	75 1a                	jne    801011ae <fileread+0x3f>
80101194:	8b 45 08             	mov    0x8(%ebp),%eax
80101197:	8b 40 0c             	mov    0xc(%eax),%eax
8010119a:	83 ec 04             	sub    $0x4,%esp
8010119d:	ff 75 10             	pushl  0x10(%ebp)
801011a0:	ff 75 0c             	pushl  0xc(%ebp)
801011a3:	50                   	push   %eax
801011a4:	e8 54 31 00 00       	call   801042fd <piperead>
801011a9:	83 c4 10             	add    $0x10,%esp
801011ac:	eb 77                	jmp    80101225 <fileread+0xb6>
801011ae:	8b 45 08             	mov    0x8(%ebp),%eax
801011b1:	8b 00                	mov    (%eax),%eax
801011b3:	83 f8 02             	cmp    $0x2,%eax
801011b6:	75 60                	jne    80101218 <fileread+0xa9>
801011b8:	8b 45 08             	mov    0x8(%ebp),%eax
801011bb:	8b 40 10             	mov    0x10(%eax),%eax
801011be:	83 ec 0c             	sub    $0xc,%esp
801011c1:	50                   	push   %eax
801011c2:	e8 81 07 00 00       	call   80101948 <ilock>
801011c7:	83 c4 10             	add    $0x10,%esp
801011ca:	8b 4d 10             	mov    0x10(%ebp),%ecx
801011cd:	8b 45 08             	mov    0x8(%ebp),%eax
801011d0:	8b 50 14             	mov    0x14(%eax),%edx
801011d3:	8b 45 08             	mov    0x8(%ebp),%eax
801011d6:	8b 40 10             	mov    0x10(%eax),%eax
801011d9:	51                   	push   %ecx
801011da:	52                   	push   %edx
801011db:	ff 75 0c             	pushl  0xc(%ebp)
801011de:	50                   	push   %eax
801011df:	e8 d2 0c 00 00       	call   80101eb6 <readi>
801011e4:	83 c4 10             	add    $0x10,%esp
801011e7:	89 45 f4             	mov    %eax,-0xc(%ebp)
801011ea:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801011ee:	7e 11                	jle    80101201 <fileread+0x92>
801011f0:	8b 45 08             	mov    0x8(%ebp),%eax
801011f3:	8b 50 14             	mov    0x14(%eax),%edx
801011f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801011f9:	01 c2                	add    %eax,%edx
801011fb:	8b 45 08             	mov    0x8(%ebp),%eax
801011fe:	89 50 14             	mov    %edx,0x14(%eax)
80101201:	8b 45 08             	mov    0x8(%ebp),%eax
80101204:	8b 40 10             	mov    0x10(%eax),%eax
80101207:	83 ec 0c             	sub    $0xc,%esp
8010120a:	50                   	push   %eax
8010120b:	e8 96 08 00 00       	call   80101aa6 <iunlock>
80101210:	83 c4 10             	add    $0x10,%esp
80101213:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101216:	eb 0d                	jmp    80101225 <fileread+0xb6>
80101218:	83 ec 0c             	sub    $0xc,%esp
8010121b:	68 02 89 10 80       	push   $0x80108902
80101220:	e8 3d f3 ff ff       	call   80100562 <panic>
80101225:	c9                   	leave  
80101226:	c3                   	ret    

80101227 <filewrite>:
80101227:	55                   	push   %ebp
80101228:	89 e5                	mov    %esp,%ebp
8010122a:	53                   	push   %ebx
8010122b:	83 ec 14             	sub    $0x14,%esp
8010122e:	8b 45 08             	mov    0x8(%ebp),%eax
80101231:	0f b6 40 09          	movzbl 0x9(%eax),%eax
80101235:	84 c0                	test   %al,%al
80101237:	75 0a                	jne    80101243 <filewrite+0x1c>
80101239:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010123e:	e9 1a 01 00 00       	jmp    8010135d <filewrite+0x136>
80101243:	8b 45 08             	mov    0x8(%ebp),%eax
80101246:	8b 00                	mov    (%eax),%eax
80101248:	83 f8 01             	cmp    $0x1,%eax
8010124b:	75 1d                	jne    8010126a <filewrite+0x43>
8010124d:	8b 45 08             	mov    0x8(%ebp),%eax
80101250:	8b 40 0c             	mov    0xc(%eax),%eax
80101253:	83 ec 04             	sub    $0x4,%esp
80101256:	ff 75 10             	pushl  0x10(%ebp)
80101259:	ff 75 0c             	pushl  0xc(%ebp)
8010125c:	50                   	push   %eax
8010125d:	e8 9d 2f 00 00       	call   801041ff <pipewrite>
80101262:	83 c4 10             	add    $0x10,%esp
80101265:	e9 f3 00 00 00       	jmp    8010135d <filewrite+0x136>
8010126a:	8b 45 08             	mov    0x8(%ebp),%eax
8010126d:	8b 00                	mov    (%eax),%eax
8010126f:	83 f8 02             	cmp    $0x2,%eax
80101272:	0f 85 d8 00 00 00    	jne    80101350 <filewrite+0x129>
80101278:	c7 45 ec 00 1a 00 00 	movl   $0x1a00,-0x14(%ebp)
8010127f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80101286:	e9 a5 00 00 00       	jmp    80101330 <filewrite+0x109>
8010128b:	8b 45 10             	mov    0x10(%ebp),%eax
8010128e:	2b 45 f4             	sub    -0xc(%ebp),%eax
80101291:	89 45 f0             	mov    %eax,-0x10(%ebp)
80101294:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101297:	3b 45 ec             	cmp    -0x14(%ebp),%eax
8010129a:	7e 06                	jle    801012a2 <filewrite+0x7b>
8010129c:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010129f:	89 45 f0             	mov    %eax,-0x10(%ebp)
801012a2:	e8 6e 22 00 00       	call   80103515 <begin_op>
801012a7:	8b 45 08             	mov    0x8(%ebp),%eax
801012aa:	8b 40 10             	mov    0x10(%eax),%eax
801012ad:	83 ec 0c             	sub    $0xc,%esp
801012b0:	50                   	push   %eax
801012b1:	e8 92 06 00 00       	call   80101948 <ilock>
801012b6:	83 c4 10             	add    $0x10,%esp
801012b9:	8b 4d f0             	mov    -0x10(%ebp),%ecx
801012bc:	8b 45 08             	mov    0x8(%ebp),%eax
801012bf:	8b 50 14             	mov    0x14(%eax),%edx
801012c2:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801012c5:	8b 45 0c             	mov    0xc(%ebp),%eax
801012c8:	01 c3                	add    %eax,%ebx
801012ca:	8b 45 08             	mov    0x8(%ebp),%eax
801012cd:	8b 40 10             	mov    0x10(%eax),%eax
801012d0:	51                   	push   %ecx
801012d1:	52                   	push   %edx
801012d2:	53                   	push   %ebx
801012d3:	50                   	push   %eax
801012d4:	e8 34 0d 00 00       	call   8010200d <writei>
801012d9:	83 c4 10             	add    $0x10,%esp
801012dc:	89 45 e8             	mov    %eax,-0x18(%ebp)
801012df:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
801012e3:	7e 11                	jle    801012f6 <filewrite+0xcf>
801012e5:	8b 45 08             	mov    0x8(%ebp),%eax
801012e8:	8b 50 14             	mov    0x14(%eax),%edx
801012eb:	8b 45 e8             	mov    -0x18(%ebp),%eax
801012ee:	01 c2                	add    %eax,%edx
801012f0:	8b 45 08             	mov    0x8(%ebp),%eax
801012f3:	89 50 14             	mov    %edx,0x14(%eax)
801012f6:	8b 45 08             	mov    0x8(%ebp),%eax
801012f9:	8b 40 10             	mov    0x10(%eax),%eax
801012fc:	83 ec 0c             	sub    $0xc,%esp
801012ff:	50                   	push   %eax
80101300:	e8 a1 07 00 00       	call   80101aa6 <iunlock>
80101305:	83 c4 10             	add    $0x10,%esp
80101308:	e8 96 22 00 00       	call   801035a3 <end_op>
8010130d:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
80101311:	79 02                	jns    80101315 <filewrite+0xee>
80101313:	eb 27                	jmp    8010133c <filewrite+0x115>
80101315:	8b 45 e8             	mov    -0x18(%ebp),%eax
80101318:	3b 45 f0             	cmp    -0x10(%ebp),%eax
8010131b:	74 0d                	je     8010132a <filewrite+0x103>
8010131d:	83 ec 0c             	sub    $0xc,%esp
80101320:	68 0b 89 10 80       	push   $0x8010890b
80101325:	e8 38 f2 ff ff       	call   80100562 <panic>
8010132a:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010132d:	01 45 f4             	add    %eax,-0xc(%ebp)
80101330:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101333:	3b 45 10             	cmp    0x10(%ebp),%eax
80101336:	0f 8c 4f ff ff ff    	jl     8010128b <filewrite+0x64>
8010133c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010133f:	3b 45 10             	cmp    0x10(%ebp),%eax
80101342:	75 05                	jne    80101349 <filewrite+0x122>
80101344:	8b 45 10             	mov    0x10(%ebp),%eax
80101347:	eb 14                	jmp    8010135d <filewrite+0x136>
80101349:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010134e:	eb 0d                	jmp    8010135d <filewrite+0x136>
80101350:	83 ec 0c             	sub    $0xc,%esp
80101353:	68 1b 89 10 80       	push   $0x8010891b
80101358:	e8 05 f2 ff ff       	call   80100562 <panic>
8010135d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101360:	c9                   	leave  
80101361:	c3                   	ret    

80101362 <readsb>:
struct superblock sb;   // there should be one per dev, but we run with one dev

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
80101362:	55                   	push   %ebp
80101363:	89 e5                	mov    %esp,%ebp
80101365:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  
  bp = bread(dev, 1);
80101368:	8b 45 08             	mov    0x8(%ebp),%eax
8010136b:	83 ec 08             	sub    $0x8,%esp
8010136e:	6a 01                	push   $0x1
80101370:	50                   	push   %eax
80101371:	e8 3e ee ff ff       	call   801001b4 <bread>
80101376:	83 c4 10             	add    $0x10,%esp
80101379:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memmove(sb, bp->data, sizeof(*sb));
8010137c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010137f:	83 c0 18             	add    $0x18,%eax
80101382:	83 ec 04             	sub    $0x4,%esp
80101385:	6a 1c                	push   $0x1c
80101387:	50                   	push   %eax
80101388:	ff 75 0c             	pushl  0xc(%ebp)
8010138b:	e8 ec 42 00 00       	call   8010567c <memmove>
80101390:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
80101393:	83 ec 0c             	sub    $0xc,%esp
80101396:	ff 75 f4             	pushl  -0xc(%ebp)
80101399:	e8 8d ee ff ff       	call   8010022b <brelse>
8010139e:	83 c4 10             	add    $0x10,%esp
}
801013a1:	90                   	nop
801013a2:	c9                   	leave  
801013a3:	c3                   	ret    

801013a4 <bzero>:

// Zero a block.
static void
bzero(int dev, int bno)
{
801013a4:	55                   	push   %ebp
801013a5:	89 e5                	mov    %esp,%ebp
801013a7:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  
  bp = bread(dev, bno);
801013aa:	8b 55 0c             	mov    0xc(%ebp),%edx
801013ad:	8b 45 08             	mov    0x8(%ebp),%eax
801013b0:	83 ec 08             	sub    $0x8,%esp
801013b3:	52                   	push   %edx
801013b4:	50                   	push   %eax
801013b5:	e8 fa ed ff ff       	call   801001b4 <bread>
801013ba:	83 c4 10             	add    $0x10,%esp
801013bd:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(bp->data, 0, BSIZE);
801013c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801013c3:	83 c0 18             	add    $0x18,%eax
801013c6:	83 ec 04             	sub    $0x4,%esp
801013c9:	68 00 02 00 00       	push   $0x200
801013ce:	6a 00                	push   $0x0
801013d0:	50                   	push   %eax
801013d1:	e8 e7 41 00 00       	call   801055bd <memset>
801013d6:	83 c4 10             	add    $0x10,%esp
  log_write(bp);
801013d9:	83 ec 0c             	sub    $0xc,%esp
801013dc:	ff 75 f4             	pushl  -0xc(%ebp)
801013df:	e8 68 23 00 00       	call   8010374c <log_write>
801013e4:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
801013e7:	83 ec 0c             	sub    $0xc,%esp
801013ea:	ff 75 f4             	pushl  -0xc(%ebp)
801013ed:	e8 39 ee ff ff       	call   8010022b <brelse>
801013f2:	83 c4 10             	add    $0x10,%esp
}
801013f5:	90                   	nop
801013f6:	c9                   	leave  
801013f7:	c3                   	ret    

801013f8 <balloc>:
// Blocks. 

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
801013f8:	55                   	push   %ebp
801013f9:	89 e5                	mov    %esp,%ebp
801013fb:	83 ec 18             	sub    $0x18,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
801013fe:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80101405:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010140c:	e9 13 01 00 00       	jmp    80101524 <balloc+0x12c>
    bp = bread(dev, BBLOCK(b, sb));
80101411:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101414:	8d 90 ff 0f 00 00    	lea    0xfff(%eax),%edx
8010141a:	85 c0                	test   %eax,%eax
8010141c:	0f 48 c2             	cmovs  %edx,%eax
8010141f:	c1 f8 0c             	sar    $0xc,%eax
80101422:	89 c2                	mov    %eax,%edx
80101424:	a1 b8 26 11 80       	mov    0x801126b8,%eax
80101429:	01 d0                	add    %edx,%eax
8010142b:	83 ec 08             	sub    $0x8,%esp
8010142e:	50                   	push   %eax
8010142f:	ff 75 08             	pushl  0x8(%ebp)
80101432:	e8 7d ed ff ff       	call   801001b4 <bread>
80101437:	83 c4 10             	add    $0x10,%esp
8010143a:	89 45 ec             	mov    %eax,-0x14(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010143d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
80101444:	e9 a6 00 00 00       	jmp    801014ef <balloc+0xf7>
      m = 1 << (bi % 8);
80101449:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010144c:	99                   	cltd   
8010144d:	c1 ea 1d             	shr    $0x1d,%edx
80101450:	01 d0                	add    %edx,%eax
80101452:	83 e0 07             	and    $0x7,%eax
80101455:	29 d0                	sub    %edx,%eax
80101457:	ba 01 00 00 00       	mov    $0x1,%edx
8010145c:	89 c1                	mov    %eax,%ecx
8010145e:	d3 e2                	shl    %cl,%edx
80101460:	89 d0                	mov    %edx,%eax
80101462:	89 45 e8             	mov    %eax,-0x18(%ebp)
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101465:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101468:	8d 50 07             	lea    0x7(%eax),%edx
8010146b:	85 c0                	test   %eax,%eax
8010146d:	0f 48 c2             	cmovs  %edx,%eax
80101470:	c1 f8 03             	sar    $0x3,%eax
80101473:	89 c2                	mov    %eax,%edx
80101475:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101478:	0f b6 44 10 18       	movzbl 0x18(%eax,%edx,1),%eax
8010147d:	0f b6 c0             	movzbl %al,%eax
80101480:	23 45 e8             	and    -0x18(%ebp),%eax
80101483:	85 c0                	test   %eax,%eax
80101485:	75 64                	jne    801014eb <balloc+0xf3>
        bp->data[bi/8] |= m;  // Mark block in use.
80101487:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010148a:	8d 50 07             	lea    0x7(%eax),%edx
8010148d:	85 c0                	test   %eax,%eax
8010148f:	0f 48 c2             	cmovs  %edx,%eax
80101492:	c1 f8 03             	sar    $0x3,%eax
80101495:	8b 55 ec             	mov    -0x14(%ebp),%edx
80101498:	0f b6 54 02 18       	movzbl 0x18(%edx,%eax,1),%edx
8010149d:	89 d1                	mov    %edx,%ecx
8010149f:	8b 55 e8             	mov    -0x18(%ebp),%edx
801014a2:	09 ca                	or     %ecx,%edx
801014a4:	89 d1                	mov    %edx,%ecx
801014a6:	8b 55 ec             	mov    -0x14(%ebp),%edx
801014a9:	88 4c 02 18          	mov    %cl,0x18(%edx,%eax,1)
        log_write(bp);
801014ad:	83 ec 0c             	sub    $0xc,%esp
801014b0:	ff 75 ec             	pushl  -0x14(%ebp)
801014b3:	e8 94 22 00 00       	call   8010374c <log_write>
801014b8:	83 c4 10             	add    $0x10,%esp
        brelse(bp);
801014bb:	83 ec 0c             	sub    $0xc,%esp
801014be:	ff 75 ec             	pushl  -0x14(%ebp)
801014c1:	e8 65 ed ff ff       	call   8010022b <brelse>
801014c6:	83 c4 10             	add    $0x10,%esp
        bzero(dev, b + bi);
801014c9:	8b 55 f4             	mov    -0xc(%ebp),%edx
801014cc:	8b 45 f0             	mov    -0x10(%ebp),%eax
801014cf:	01 c2                	add    %eax,%edx
801014d1:	8b 45 08             	mov    0x8(%ebp),%eax
801014d4:	83 ec 08             	sub    $0x8,%esp
801014d7:	52                   	push   %edx
801014d8:	50                   	push   %eax
801014d9:	e8 c6 fe ff ff       	call   801013a4 <bzero>
801014de:	83 c4 10             	add    $0x10,%esp
        return b + bi;
801014e1:	8b 55 f4             	mov    -0xc(%ebp),%edx
801014e4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801014e7:	01 d0                	add    %edx,%eax
801014e9:	eb 57                	jmp    80101542 <balloc+0x14a>
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801014eb:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
801014ef:	81 7d f0 ff 0f 00 00 	cmpl   $0xfff,-0x10(%ebp)
801014f6:	7f 17                	jg     8010150f <balloc+0x117>
801014f8:	8b 55 f4             	mov    -0xc(%ebp),%edx
801014fb:	8b 45 f0             	mov    -0x10(%ebp),%eax
801014fe:	01 d0                	add    %edx,%eax
80101500:	89 c2                	mov    %eax,%edx
80101502:	a1 a0 26 11 80       	mov    0x801126a0,%eax
80101507:	39 c2                	cmp    %eax,%edx
80101509:	0f 82 3a ff ff ff    	jb     80101449 <balloc+0x51>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
8010150f:	83 ec 0c             	sub    $0xc,%esp
80101512:	ff 75 ec             	pushl  -0x14(%ebp)
80101515:	e8 11 ed ff ff       	call   8010022b <brelse>
8010151a:	83 c4 10             	add    $0x10,%esp
{
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
8010151d:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80101524:	8b 15 a0 26 11 80    	mov    0x801126a0,%edx
8010152a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010152d:	39 c2                	cmp    %eax,%edx
8010152f:	0f 87 dc fe ff ff    	ja     80101411 <balloc+0x19>
        return b + bi;
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
80101535:	83 ec 0c             	sub    $0xc,%esp
80101538:	68 28 89 10 80       	push   $0x80108928
8010153d:	e8 20 f0 ff ff       	call   80100562 <panic>
}
80101542:	c9                   	leave  
80101543:	c3                   	ret    

80101544 <bfree>:

// Free a disk block.
static void
bfree(int dev, uint b)
{
80101544:	55                   	push   %ebp
80101545:	89 e5                	mov    %esp,%ebp
80101547:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  int bi, m;

  readsb(dev, &sb);
8010154a:	83 ec 08             	sub    $0x8,%esp
8010154d:	68 a0 26 11 80       	push   $0x801126a0
80101552:	ff 75 08             	pushl  0x8(%ebp)
80101555:	e8 08 fe ff ff       	call   80101362 <readsb>
8010155a:	83 c4 10             	add    $0x10,%esp
  bp = bread(dev, BBLOCK(b, sb));
8010155d:	8b 45 0c             	mov    0xc(%ebp),%eax
80101560:	c1 e8 0c             	shr    $0xc,%eax
80101563:	89 c2                	mov    %eax,%edx
80101565:	a1 b8 26 11 80       	mov    0x801126b8,%eax
8010156a:	01 c2                	add    %eax,%edx
8010156c:	8b 45 08             	mov    0x8(%ebp),%eax
8010156f:	83 ec 08             	sub    $0x8,%esp
80101572:	52                   	push   %edx
80101573:	50                   	push   %eax
80101574:	e8 3b ec ff ff       	call   801001b4 <bread>
80101579:	83 c4 10             	add    $0x10,%esp
8010157c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  bi = b % BPB;
8010157f:	8b 45 0c             	mov    0xc(%ebp),%eax
80101582:	25 ff 0f 00 00       	and    $0xfff,%eax
80101587:	89 45 f0             	mov    %eax,-0x10(%ebp)
  m = 1 << (bi % 8);
8010158a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010158d:	99                   	cltd   
8010158e:	c1 ea 1d             	shr    $0x1d,%edx
80101591:	01 d0                	add    %edx,%eax
80101593:	83 e0 07             	and    $0x7,%eax
80101596:	29 d0                	sub    %edx,%eax
80101598:	ba 01 00 00 00       	mov    $0x1,%edx
8010159d:	89 c1                	mov    %eax,%ecx
8010159f:	d3 e2                	shl    %cl,%edx
801015a1:	89 d0                	mov    %edx,%eax
801015a3:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((bp->data[bi/8] & m) == 0)
801015a6:	8b 45 f0             	mov    -0x10(%ebp),%eax
801015a9:	8d 50 07             	lea    0x7(%eax),%edx
801015ac:	85 c0                	test   %eax,%eax
801015ae:	0f 48 c2             	cmovs  %edx,%eax
801015b1:	c1 f8 03             	sar    $0x3,%eax
801015b4:	89 c2                	mov    %eax,%edx
801015b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801015b9:	0f b6 44 10 18       	movzbl 0x18(%eax,%edx,1),%eax
801015be:	0f b6 c0             	movzbl %al,%eax
801015c1:	23 45 ec             	and    -0x14(%ebp),%eax
801015c4:	85 c0                	test   %eax,%eax
801015c6:	75 0d                	jne    801015d5 <bfree+0x91>
    panic("freeing free block");
801015c8:	83 ec 0c             	sub    $0xc,%esp
801015cb:	68 3e 89 10 80       	push   $0x8010893e
801015d0:	e8 8d ef ff ff       	call   80100562 <panic>
  bp->data[bi/8] &= ~m;
801015d5:	8b 45 f0             	mov    -0x10(%ebp),%eax
801015d8:	8d 50 07             	lea    0x7(%eax),%edx
801015db:	85 c0                	test   %eax,%eax
801015dd:	0f 48 c2             	cmovs  %edx,%eax
801015e0:	c1 f8 03             	sar    $0x3,%eax
801015e3:	8b 55 f4             	mov    -0xc(%ebp),%edx
801015e6:	0f b6 54 02 18       	movzbl 0x18(%edx,%eax,1),%edx
801015eb:	89 d1                	mov    %edx,%ecx
801015ed:	8b 55 ec             	mov    -0x14(%ebp),%edx
801015f0:	f7 d2                	not    %edx
801015f2:	21 ca                	and    %ecx,%edx
801015f4:	89 d1                	mov    %edx,%ecx
801015f6:	8b 55 f4             	mov    -0xc(%ebp),%edx
801015f9:	88 4c 02 18          	mov    %cl,0x18(%edx,%eax,1)
  log_write(bp);
801015fd:	83 ec 0c             	sub    $0xc,%esp
80101600:	ff 75 f4             	pushl  -0xc(%ebp)
80101603:	e8 44 21 00 00       	call   8010374c <log_write>
80101608:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
8010160b:	83 ec 0c             	sub    $0xc,%esp
8010160e:	ff 75 f4             	pushl  -0xc(%ebp)
80101611:	e8 15 ec ff ff       	call   8010022b <brelse>
80101616:	83 c4 10             	add    $0x10,%esp
}
80101619:	90                   	nop
8010161a:	c9                   	leave  
8010161b:	c3                   	ret    

8010161c <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit(int dev)
{
8010161c:	55                   	push   %ebp
8010161d:	89 e5                	mov    %esp,%ebp
8010161f:	57                   	push   %edi
80101620:	56                   	push   %esi
80101621:	53                   	push   %ebx
80101622:	83 ec 1c             	sub    $0x1c,%esp
  initlock(&icache.lock, "icache");
80101625:	83 ec 08             	sub    $0x8,%esp
80101628:	68 51 89 10 80       	push   $0x80108951
8010162d:	68 c0 26 11 80       	push   $0x801126c0
80101632:	e8 03 3d 00 00       	call   8010533a <initlock>
80101637:	83 c4 10             	add    $0x10,%esp
  readsb(dev, &sb);
8010163a:	83 ec 08             	sub    $0x8,%esp
8010163d:	68 a0 26 11 80       	push   $0x801126a0
80101642:	ff 75 08             	pushl  0x8(%ebp)
80101645:	e8 18 fd ff ff       	call   80101362 <readsb>
8010164a:	83 c4 10             	add    $0x10,%esp
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d inodestart %d bmap start %d\n", sb.size,
8010164d:	a1 b8 26 11 80       	mov    0x801126b8,%eax
80101652:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101655:	8b 3d b4 26 11 80    	mov    0x801126b4,%edi
8010165b:	8b 35 b0 26 11 80    	mov    0x801126b0,%esi
80101661:	8b 1d ac 26 11 80    	mov    0x801126ac,%ebx
80101667:	8b 0d a8 26 11 80    	mov    0x801126a8,%ecx
8010166d:	8b 15 a4 26 11 80    	mov    0x801126a4,%edx
80101673:	a1 a0 26 11 80       	mov    0x801126a0,%eax
80101678:	ff 75 e4             	pushl  -0x1c(%ebp)
8010167b:	57                   	push   %edi
8010167c:	56                   	push   %esi
8010167d:	53                   	push   %ebx
8010167e:	51                   	push   %ecx
8010167f:	52                   	push   %edx
80101680:	50                   	push   %eax
80101681:	68 58 89 10 80       	push   $0x80108958
80101686:	e8 37 ed ff ff       	call   801003c2 <cprintf>
8010168b:	83 c4 20             	add    $0x20,%esp
          sb.nblocks, sb.ninodes, sb.nlog, sb.logstart, sb.inodestart, sb.bmapstart);
}
8010168e:	90                   	nop
8010168f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101692:	5b                   	pop    %ebx
80101693:	5e                   	pop    %esi
80101694:	5f                   	pop    %edi
80101695:	5d                   	pop    %ebp
80101696:	c3                   	ret    

80101697 <ialloc>:
//PAGEBREAK!
// Allocate a new inode with the given type on device dev.
// A free inode has a type of zero.
struct inode*
ialloc(uint dev, short type)
{
80101697:	55                   	push   %ebp
80101698:	89 e5                	mov    %esp,%ebp
8010169a:	83 ec 28             	sub    $0x28,%esp
8010169d:	8b 45 0c             	mov    0xc(%ebp),%eax
801016a0:	66 89 45 e4          	mov    %ax,-0x1c(%ebp)
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
801016a4:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
801016ab:	e9 9e 00 00 00       	jmp    8010174e <ialloc+0xb7>
    bp = bread(dev, IBLOCK(inum, sb));
801016b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801016b3:	c1 e8 03             	shr    $0x3,%eax
801016b6:	89 c2                	mov    %eax,%edx
801016b8:	a1 b4 26 11 80       	mov    0x801126b4,%eax
801016bd:	01 d0                	add    %edx,%eax
801016bf:	83 ec 08             	sub    $0x8,%esp
801016c2:	50                   	push   %eax
801016c3:	ff 75 08             	pushl  0x8(%ebp)
801016c6:	e8 e9 ea ff ff       	call   801001b4 <bread>
801016cb:	83 c4 10             	add    $0x10,%esp
801016ce:	89 45 f0             	mov    %eax,-0x10(%ebp)
    dip = (struct dinode*)bp->data + inum%IPB;
801016d1:	8b 45 f0             	mov    -0x10(%ebp),%eax
801016d4:	8d 50 18             	lea    0x18(%eax),%edx
801016d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801016da:	83 e0 07             	and    $0x7,%eax
801016dd:	c1 e0 06             	shl    $0x6,%eax
801016e0:	01 d0                	add    %edx,%eax
801016e2:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(dip->type == 0){  // a free inode
801016e5:	8b 45 ec             	mov    -0x14(%ebp),%eax
801016e8:	0f b7 00             	movzwl (%eax),%eax
801016eb:	66 85 c0             	test   %ax,%ax
801016ee:	75 4c                	jne    8010173c <ialloc+0xa5>
      memset(dip, 0, sizeof(*dip));
801016f0:	83 ec 04             	sub    $0x4,%esp
801016f3:	6a 40                	push   $0x40
801016f5:	6a 00                	push   $0x0
801016f7:	ff 75 ec             	pushl  -0x14(%ebp)
801016fa:	e8 be 3e 00 00       	call   801055bd <memset>
801016ff:	83 c4 10             	add    $0x10,%esp
      dip->type = type;
80101702:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101705:	0f b7 55 e4          	movzwl -0x1c(%ebp),%edx
80101709:	66 89 10             	mov    %dx,(%eax)
      log_write(bp);   // mark it allocated on the disk
8010170c:	83 ec 0c             	sub    $0xc,%esp
8010170f:	ff 75 f0             	pushl  -0x10(%ebp)
80101712:	e8 35 20 00 00       	call   8010374c <log_write>
80101717:	83 c4 10             	add    $0x10,%esp
      brelse(bp);
8010171a:	83 ec 0c             	sub    $0xc,%esp
8010171d:	ff 75 f0             	pushl  -0x10(%ebp)
80101720:	e8 06 eb ff ff       	call   8010022b <brelse>
80101725:	83 c4 10             	add    $0x10,%esp
      return iget(dev, inum);
80101728:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010172b:	83 ec 08             	sub    $0x8,%esp
8010172e:	50                   	push   %eax
8010172f:	ff 75 08             	pushl  0x8(%ebp)
80101732:	e8 f8 00 00 00       	call   8010182f <iget>
80101737:	83 c4 10             	add    $0x10,%esp
8010173a:	eb 30                	jmp    8010176c <ialloc+0xd5>
    }
    brelse(bp);
8010173c:	83 ec 0c             	sub    $0xc,%esp
8010173f:	ff 75 f0             	pushl  -0x10(%ebp)
80101742:	e8 e4 ea ff ff       	call   8010022b <brelse>
80101747:	83 c4 10             	add    $0x10,%esp
{
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
8010174a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010174e:	8b 15 a8 26 11 80    	mov    0x801126a8,%edx
80101754:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101757:	39 c2                	cmp    %eax,%edx
80101759:	0f 87 51 ff ff ff    	ja     801016b0 <ialloc+0x19>
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
8010175f:	83 ec 0c             	sub    $0xc,%esp
80101762:	68 ab 89 10 80       	push   $0x801089ab
80101767:	e8 f6 ed ff ff       	call   80100562 <panic>
}
8010176c:	c9                   	leave  
8010176d:	c3                   	ret    

8010176e <iupdate>:

// Copy a modified in-memory inode to disk.
void
iupdate(struct inode *ip)
{
8010176e:	55                   	push   %ebp
8010176f:	89 e5                	mov    %esp,%ebp
80101771:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101774:	8b 45 08             	mov    0x8(%ebp),%eax
80101777:	8b 40 04             	mov    0x4(%eax),%eax
8010177a:	c1 e8 03             	shr    $0x3,%eax
8010177d:	89 c2                	mov    %eax,%edx
8010177f:	a1 b4 26 11 80       	mov    0x801126b4,%eax
80101784:	01 c2                	add    %eax,%edx
80101786:	8b 45 08             	mov    0x8(%ebp),%eax
80101789:	8b 00                	mov    (%eax),%eax
8010178b:	83 ec 08             	sub    $0x8,%esp
8010178e:	52                   	push   %edx
8010178f:	50                   	push   %eax
80101790:	e8 1f ea ff ff       	call   801001b4 <bread>
80101795:	83 c4 10             	add    $0x10,%esp
80101798:	89 45 f4             	mov    %eax,-0xc(%ebp)
  dip = (struct dinode*)bp->data + ip->inum%IPB;
8010179b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010179e:	8d 50 18             	lea    0x18(%eax),%edx
801017a1:	8b 45 08             	mov    0x8(%ebp),%eax
801017a4:	8b 40 04             	mov    0x4(%eax),%eax
801017a7:	83 e0 07             	and    $0x7,%eax
801017aa:	c1 e0 06             	shl    $0x6,%eax
801017ad:	01 d0                	add    %edx,%eax
801017af:	89 45 f0             	mov    %eax,-0x10(%ebp)
  dip->type = ip->type;
801017b2:	8b 45 08             	mov    0x8(%ebp),%eax
801017b5:	0f b7 50 10          	movzwl 0x10(%eax),%edx
801017b9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801017bc:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
801017bf:	8b 45 08             	mov    0x8(%ebp),%eax
801017c2:	0f b7 50 12          	movzwl 0x12(%eax),%edx
801017c6:	8b 45 f0             	mov    -0x10(%ebp),%eax
801017c9:	66 89 50 02          	mov    %dx,0x2(%eax)
  dip->minor = ip->minor;
801017cd:	8b 45 08             	mov    0x8(%ebp),%eax
801017d0:	0f b7 50 14          	movzwl 0x14(%eax),%edx
801017d4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801017d7:	66 89 50 04          	mov    %dx,0x4(%eax)
  dip->nlink = ip->nlink;
801017db:	8b 45 08             	mov    0x8(%ebp),%eax
801017de:	0f b7 50 16          	movzwl 0x16(%eax),%edx
801017e2:	8b 45 f0             	mov    -0x10(%ebp),%eax
801017e5:	66 89 50 06          	mov    %dx,0x6(%eax)
  dip->size = ip->size;
801017e9:	8b 45 08             	mov    0x8(%ebp),%eax
801017ec:	8b 50 18             	mov    0x18(%eax),%edx
801017ef:	8b 45 f0             	mov    -0x10(%ebp),%eax
801017f2:	89 50 08             	mov    %edx,0x8(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801017f5:	8b 45 08             	mov    0x8(%ebp),%eax
801017f8:	8d 50 1c             	lea    0x1c(%eax),%edx
801017fb:	8b 45 f0             	mov    -0x10(%ebp),%eax
801017fe:	83 c0 0c             	add    $0xc,%eax
80101801:	83 ec 04             	sub    $0x4,%esp
80101804:	6a 34                	push   $0x34
80101806:	52                   	push   %edx
80101807:	50                   	push   %eax
80101808:	e8 6f 3e 00 00       	call   8010567c <memmove>
8010180d:	83 c4 10             	add    $0x10,%esp
  log_write(bp);
80101810:	83 ec 0c             	sub    $0xc,%esp
80101813:	ff 75 f4             	pushl  -0xc(%ebp)
80101816:	e8 31 1f 00 00       	call   8010374c <log_write>
8010181b:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
8010181e:	83 ec 0c             	sub    $0xc,%esp
80101821:	ff 75 f4             	pushl  -0xc(%ebp)
80101824:	e8 02 ea ff ff       	call   8010022b <brelse>
80101829:	83 c4 10             	add    $0x10,%esp
}
8010182c:	90                   	nop
8010182d:	c9                   	leave  
8010182e:	c3                   	ret    

8010182f <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
8010182f:	55                   	push   %ebp
80101830:	89 e5                	mov    %esp,%ebp
80101832:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip, *empty;

  acquire(&icache.lock);
80101835:	83 ec 0c             	sub    $0xc,%esp
80101838:	68 c0 26 11 80       	push   $0x801126c0
8010183d:	e8 1a 3b 00 00       	call   8010535c <acquire>
80101842:	83 c4 10             	add    $0x10,%esp

  // Is the inode already cached?
  empty = 0;
80101845:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010184c:	c7 45 f4 f4 26 11 80 	movl   $0x801126f4,-0xc(%ebp)
80101853:	eb 5d                	jmp    801018b2 <iget+0x83>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101855:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101858:	8b 40 08             	mov    0x8(%eax),%eax
8010185b:	85 c0                	test   %eax,%eax
8010185d:	7e 39                	jle    80101898 <iget+0x69>
8010185f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101862:	8b 00                	mov    (%eax),%eax
80101864:	3b 45 08             	cmp    0x8(%ebp),%eax
80101867:	75 2f                	jne    80101898 <iget+0x69>
80101869:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010186c:	8b 40 04             	mov    0x4(%eax),%eax
8010186f:	3b 45 0c             	cmp    0xc(%ebp),%eax
80101872:	75 24                	jne    80101898 <iget+0x69>
      ip->ref++;
80101874:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101877:	8b 40 08             	mov    0x8(%eax),%eax
8010187a:	8d 50 01             	lea    0x1(%eax),%edx
8010187d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101880:	89 50 08             	mov    %edx,0x8(%eax)
      release(&icache.lock);
80101883:	83 ec 0c             	sub    $0xc,%esp
80101886:	68 c0 26 11 80       	push   $0x801126c0
8010188b:	e8 33 3b 00 00       	call   801053c3 <release>
80101890:	83 c4 10             	add    $0x10,%esp
      return ip;
80101893:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101896:	eb 74                	jmp    8010190c <iget+0xdd>
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101898:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010189c:	75 10                	jne    801018ae <iget+0x7f>
8010189e:	8b 45 f4             	mov    -0xc(%ebp),%eax
801018a1:	8b 40 08             	mov    0x8(%eax),%eax
801018a4:	85 c0                	test   %eax,%eax
801018a6:	75 06                	jne    801018ae <iget+0x7f>
      empty = ip;
801018a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801018ab:	89 45 f0             	mov    %eax,-0x10(%ebp)

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801018ae:	83 45 f4 50          	addl   $0x50,-0xc(%ebp)
801018b2:	81 7d f4 94 36 11 80 	cmpl   $0x80113694,-0xc(%ebp)
801018b9:	72 9a                	jb     80101855 <iget+0x26>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
801018bb:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801018bf:	75 0d                	jne    801018ce <iget+0x9f>
    panic("iget: no inodes");
801018c1:	83 ec 0c             	sub    $0xc,%esp
801018c4:	68 bd 89 10 80       	push   $0x801089bd
801018c9:	e8 94 ec ff ff       	call   80100562 <panic>

  ip = empty;
801018ce:	8b 45 f0             	mov    -0x10(%ebp),%eax
801018d1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  ip->dev = dev;
801018d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801018d7:	8b 55 08             	mov    0x8(%ebp),%edx
801018da:	89 10                	mov    %edx,(%eax)
  ip->inum = inum;
801018dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801018df:	8b 55 0c             	mov    0xc(%ebp),%edx
801018e2:	89 50 04             	mov    %edx,0x4(%eax)
  ip->ref = 1;
801018e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801018e8:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%eax)
  ip->flags = 0;
801018ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
801018f2:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  release(&icache.lock);
801018f9:	83 ec 0c             	sub    $0xc,%esp
801018fc:	68 c0 26 11 80       	push   $0x801126c0
80101901:	e8 bd 3a 00 00       	call   801053c3 <release>
80101906:	83 c4 10             	add    $0x10,%esp

  return ip;
80101909:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
8010190c:	c9                   	leave  
8010190d:	c3                   	ret    

8010190e <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
8010190e:	55                   	push   %ebp
8010190f:	89 e5                	mov    %esp,%ebp
80101911:	83 ec 08             	sub    $0x8,%esp
  acquire(&icache.lock);
80101914:	83 ec 0c             	sub    $0xc,%esp
80101917:	68 c0 26 11 80       	push   $0x801126c0
8010191c:	e8 3b 3a 00 00       	call   8010535c <acquire>
80101921:	83 c4 10             	add    $0x10,%esp
  ip->ref++;
80101924:	8b 45 08             	mov    0x8(%ebp),%eax
80101927:	8b 40 08             	mov    0x8(%eax),%eax
8010192a:	8d 50 01             	lea    0x1(%eax),%edx
8010192d:	8b 45 08             	mov    0x8(%ebp),%eax
80101930:	89 50 08             	mov    %edx,0x8(%eax)
  release(&icache.lock);
80101933:	83 ec 0c             	sub    $0xc,%esp
80101936:	68 c0 26 11 80       	push   $0x801126c0
8010193b:	e8 83 3a 00 00       	call   801053c3 <release>
80101940:	83 c4 10             	add    $0x10,%esp
  return ip;
80101943:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101946:	c9                   	leave  
80101947:	c3                   	ret    

80101948 <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void
ilock(struct inode *ip)
{
80101948:	55                   	push   %ebp
80101949:	89 e5                	mov    %esp,%ebp
8010194b:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
8010194e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80101952:	74 0a                	je     8010195e <ilock+0x16>
80101954:	8b 45 08             	mov    0x8(%ebp),%eax
80101957:	8b 40 08             	mov    0x8(%eax),%eax
8010195a:	85 c0                	test   %eax,%eax
8010195c:	7f 0d                	jg     8010196b <ilock+0x23>
    panic("ilock");
8010195e:	83 ec 0c             	sub    $0xc,%esp
80101961:	68 cd 89 10 80       	push   $0x801089cd
80101966:	e8 f7 eb ff ff       	call   80100562 <panic>

  acquire(&icache.lock);
8010196b:	83 ec 0c             	sub    $0xc,%esp
8010196e:	68 c0 26 11 80       	push   $0x801126c0
80101973:	e8 e4 39 00 00       	call   8010535c <acquire>
80101978:	83 c4 10             	add    $0x10,%esp
  while(ip->flags & I_BUSY)
8010197b:	eb 13                	jmp    80101990 <ilock+0x48>
    sleep(ip, &icache.lock);
8010197d:	83 ec 08             	sub    $0x8,%esp
80101980:	68 c0 26 11 80       	push   $0x801126c0
80101985:	ff 75 08             	pushl  0x8(%ebp)
80101988:	e8 90 36 00 00       	call   8010501d <sleep>
8010198d:	83 c4 10             	add    $0x10,%esp

  if(ip == 0 || ip->ref < 1)
    panic("ilock");

  acquire(&icache.lock);
  while(ip->flags & I_BUSY)
80101990:	8b 45 08             	mov    0x8(%ebp),%eax
80101993:	8b 40 0c             	mov    0xc(%eax),%eax
80101996:	83 e0 01             	and    $0x1,%eax
80101999:	85 c0                	test   %eax,%eax
8010199b:	75 e0                	jne    8010197d <ilock+0x35>
    sleep(ip, &icache.lock);
  ip->flags |= I_BUSY;
8010199d:	8b 45 08             	mov    0x8(%ebp),%eax
801019a0:	8b 40 0c             	mov    0xc(%eax),%eax
801019a3:	83 c8 01             	or     $0x1,%eax
801019a6:	89 c2                	mov    %eax,%edx
801019a8:	8b 45 08             	mov    0x8(%ebp),%eax
801019ab:	89 50 0c             	mov    %edx,0xc(%eax)
  release(&icache.lock);
801019ae:	83 ec 0c             	sub    $0xc,%esp
801019b1:	68 c0 26 11 80       	push   $0x801126c0
801019b6:	e8 08 3a 00 00       	call   801053c3 <release>
801019bb:	83 c4 10             	add    $0x10,%esp

  if(!(ip->flags & I_VALID)){
801019be:	8b 45 08             	mov    0x8(%ebp),%eax
801019c1:	8b 40 0c             	mov    0xc(%eax),%eax
801019c4:	83 e0 02             	and    $0x2,%eax
801019c7:	85 c0                	test   %eax,%eax
801019c9:	0f 85 d4 00 00 00    	jne    80101aa3 <ilock+0x15b>
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801019cf:	8b 45 08             	mov    0x8(%ebp),%eax
801019d2:	8b 40 04             	mov    0x4(%eax),%eax
801019d5:	c1 e8 03             	shr    $0x3,%eax
801019d8:	89 c2                	mov    %eax,%edx
801019da:	a1 b4 26 11 80       	mov    0x801126b4,%eax
801019df:	01 c2                	add    %eax,%edx
801019e1:	8b 45 08             	mov    0x8(%ebp),%eax
801019e4:	8b 00                	mov    (%eax),%eax
801019e6:	83 ec 08             	sub    $0x8,%esp
801019e9:	52                   	push   %edx
801019ea:	50                   	push   %eax
801019eb:	e8 c4 e7 ff ff       	call   801001b4 <bread>
801019f0:	83 c4 10             	add    $0x10,%esp
801019f3:	89 45 f4             	mov    %eax,-0xc(%ebp)
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801019f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801019f9:	8d 50 18             	lea    0x18(%eax),%edx
801019fc:	8b 45 08             	mov    0x8(%ebp),%eax
801019ff:	8b 40 04             	mov    0x4(%eax),%eax
80101a02:	83 e0 07             	and    $0x7,%eax
80101a05:	c1 e0 06             	shl    $0x6,%eax
80101a08:	01 d0                	add    %edx,%eax
80101a0a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    ip->type = dip->type;
80101a0d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101a10:	0f b7 10             	movzwl (%eax),%edx
80101a13:	8b 45 08             	mov    0x8(%ebp),%eax
80101a16:	66 89 50 10          	mov    %dx,0x10(%eax)
    ip->major = dip->major;
80101a1a:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101a1d:	0f b7 50 02          	movzwl 0x2(%eax),%edx
80101a21:	8b 45 08             	mov    0x8(%ebp),%eax
80101a24:	66 89 50 12          	mov    %dx,0x12(%eax)
    ip->minor = dip->minor;
80101a28:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101a2b:	0f b7 50 04          	movzwl 0x4(%eax),%edx
80101a2f:	8b 45 08             	mov    0x8(%ebp),%eax
80101a32:	66 89 50 14          	mov    %dx,0x14(%eax)
    ip->nlink = dip->nlink;
80101a36:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101a39:	0f b7 50 06          	movzwl 0x6(%eax),%edx
80101a3d:	8b 45 08             	mov    0x8(%ebp),%eax
80101a40:	66 89 50 16          	mov    %dx,0x16(%eax)
    ip->size = dip->size;
80101a44:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101a47:	8b 50 08             	mov    0x8(%eax),%edx
80101a4a:	8b 45 08             	mov    0x8(%ebp),%eax
80101a4d:	89 50 18             	mov    %edx,0x18(%eax)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101a50:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101a53:	8d 50 0c             	lea    0xc(%eax),%edx
80101a56:	8b 45 08             	mov    0x8(%ebp),%eax
80101a59:	83 c0 1c             	add    $0x1c,%eax
80101a5c:	83 ec 04             	sub    $0x4,%esp
80101a5f:	6a 34                	push   $0x34
80101a61:	52                   	push   %edx
80101a62:	50                   	push   %eax
80101a63:	e8 14 3c 00 00       	call   8010567c <memmove>
80101a68:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
80101a6b:	83 ec 0c             	sub    $0xc,%esp
80101a6e:	ff 75 f4             	pushl  -0xc(%ebp)
80101a71:	e8 b5 e7 ff ff       	call   8010022b <brelse>
80101a76:	83 c4 10             	add    $0x10,%esp
    ip->flags |= I_VALID;
80101a79:	8b 45 08             	mov    0x8(%ebp),%eax
80101a7c:	8b 40 0c             	mov    0xc(%eax),%eax
80101a7f:	83 c8 02             	or     $0x2,%eax
80101a82:	89 c2                	mov    %eax,%edx
80101a84:	8b 45 08             	mov    0x8(%ebp),%eax
80101a87:	89 50 0c             	mov    %edx,0xc(%eax)
    if(ip->type == 0)
80101a8a:	8b 45 08             	mov    0x8(%ebp),%eax
80101a8d:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80101a91:	66 85 c0             	test   %ax,%ax
80101a94:	75 0d                	jne    80101aa3 <ilock+0x15b>
      panic("ilock: no type");
80101a96:	83 ec 0c             	sub    $0xc,%esp
80101a99:	68 d3 89 10 80       	push   $0x801089d3
80101a9e:	e8 bf ea ff ff       	call   80100562 <panic>
  }
}
80101aa3:	90                   	nop
80101aa4:	c9                   	leave  
80101aa5:	c3                   	ret    

80101aa6 <iunlock>:

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
80101aa6:	55                   	push   %ebp
80101aa7:	89 e5                	mov    %esp,%ebp
80101aa9:	83 ec 08             	sub    $0x8,%esp
  if(ip == 0 || !(ip->flags & I_BUSY) || ip->ref < 1)
80101aac:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80101ab0:	74 17                	je     80101ac9 <iunlock+0x23>
80101ab2:	8b 45 08             	mov    0x8(%ebp),%eax
80101ab5:	8b 40 0c             	mov    0xc(%eax),%eax
80101ab8:	83 e0 01             	and    $0x1,%eax
80101abb:	85 c0                	test   %eax,%eax
80101abd:	74 0a                	je     80101ac9 <iunlock+0x23>
80101abf:	8b 45 08             	mov    0x8(%ebp),%eax
80101ac2:	8b 40 08             	mov    0x8(%eax),%eax
80101ac5:	85 c0                	test   %eax,%eax
80101ac7:	7f 0d                	jg     80101ad6 <iunlock+0x30>
    panic("iunlock");
80101ac9:	83 ec 0c             	sub    $0xc,%esp
80101acc:	68 e2 89 10 80       	push   $0x801089e2
80101ad1:	e8 8c ea ff ff       	call   80100562 <panic>

  acquire(&icache.lock);
80101ad6:	83 ec 0c             	sub    $0xc,%esp
80101ad9:	68 c0 26 11 80       	push   $0x801126c0
80101ade:	e8 79 38 00 00       	call   8010535c <acquire>
80101ae3:	83 c4 10             	add    $0x10,%esp
  ip->flags &= ~I_BUSY;
80101ae6:	8b 45 08             	mov    0x8(%ebp),%eax
80101ae9:	8b 40 0c             	mov    0xc(%eax),%eax
80101aec:	83 e0 fe             	and    $0xfffffffe,%eax
80101aef:	89 c2                	mov    %eax,%edx
80101af1:	8b 45 08             	mov    0x8(%ebp),%eax
80101af4:	89 50 0c             	mov    %edx,0xc(%eax)
  wakeup(ip);
80101af7:	83 ec 0c             	sub    $0xc,%esp
80101afa:	ff 75 08             	pushl  0x8(%ebp)
80101afd:	e8 17 36 00 00       	call   80105119 <wakeup>
80101b02:	83 c4 10             	add    $0x10,%esp
  release(&icache.lock);
80101b05:	83 ec 0c             	sub    $0xc,%esp
80101b08:	68 c0 26 11 80       	push   $0x801126c0
80101b0d:	e8 b1 38 00 00       	call   801053c3 <release>
80101b12:	83 c4 10             	add    $0x10,%esp
}
80101b15:	90                   	nop
80101b16:	c9                   	leave  
80101b17:	c3                   	ret    

80101b18 <iput>:
// to it, free the inode (and its content) on disk.
// All calls to iput() must be inside a transaction in
// case it has to free the inode.
void
iput(struct inode *ip)
{
80101b18:	55                   	push   %ebp
80101b19:	89 e5                	mov    %esp,%ebp
80101b1b:	83 ec 08             	sub    $0x8,%esp
  acquire(&icache.lock);
80101b1e:	83 ec 0c             	sub    $0xc,%esp
80101b21:	68 c0 26 11 80       	push   $0x801126c0
80101b26:	e8 31 38 00 00       	call   8010535c <acquire>
80101b2b:	83 c4 10             	add    $0x10,%esp
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
80101b2e:	8b 45 08             	mov    0x8(%ebp),%eax
80101b31:	8b 40 08             	mov    0x8(%eax),%eax
80101b34:	83 f8 01             	cmp    $0x1,%eax
80101b37:	0f 85 a9 00 00 00    	jne    80101be6 <iput+0xce>
80101b3d:	8b 45 08             	mov    0x8(%ebp),%eax
80101b40:	8b 40 0c             	mov    0xc(%eax),%eax
80101b43:	83 e0 02             	and    $0x2,%eax
80101b46:	85 c0                	test   %eax,%eax
80101b48:	0f 84 98 00 00 00    	je     80101be6 <iput+0xce>
80101b4e:	8b 45 08             	mov    0x8(%ebp),%eax
80101b51:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80101b55:	66 85 c0             	test   %ax,%ax
80101b58:	0f 85 88 00 00 00    	jne    80101be6 <iput+0xce>
    // inode has no links and no other references: truncate and free.
    if(ip->flags & I_BUSY)
80101b5e:	8b 45 08             	mov    0x8(%ebp),%eax
80101b61:	8b 40 0c             	mov    0xc(%eax),%eax
80101b64:	83 e0 01             	and    $0x1,%eax
80101b67:	85 c0                	test   %eax,%eax
80101b69:	74 0d                	je     80101b78 <iput+0x60>
      panic("iput busy");
80101b6b:	83 ec 0c             	sub    $0xc,%esp
80101b6e:	68 ea 89 10 80       	push   $0x801089ea
80101b73:	e8 ea e9 ff ff       	call   80100562 <panic>
    ip->flags |= I_BUSY;
80101b78:	8b 45 08             	mov    0x8(%ebp),%eax
80101b7b:	8b 40 0c             	mov    0xc(%eax),%eax
80101b7e:	83 c8 01             	or     $0x1,%eax
80101b81:	89 c2                	mov    %eax,%edx
80101b83:	8b 45 08             	mov    0x8(%ebp),%eax
80101b86:	89 50 0c             	mov    %edx,0xc(%eax)
    release(&icache.lock);
80101b89:	83 ec 0c             	sub    $0xc,%esp
80101b8c:	68 c0 26 11 80       	push   $0x801126c0
80101b91:	e8 2d 38 00 00       	call   801053c3 <release>
80101b96:	83 c4 10             	add    $0x10,%esp
    itrunc(ip);
80101b99:	83 ec 0c             	sub    $0xc,%esp
80101b9c:	ff 75 08             	pushl  0x8(%ebp)
80101b9f:	e8 a8 01 00 00       	call   80101d4c <itrunc>
80101ba4:	83 c4 10             	add    $0x10,%esp
    ip->type = 0;
80101ba7:	8b 45 08             	mov    0x8(%ebp),%eax
80101baa:	66 c7 40 10 00 00    	movw   $0x0,0x10(%eax)
    iupdate(ip);
80101bb0:	83 ec 0c             	sub    $0xc,%esp
80101bb3:	ff 75 08             	pushl  0x8(%ebp)
80101bb6:	e8 b3 fb ff ff       	call   8010176e <iupdate>
80101bbb:	83 c4 10             	add    $0x10,%esp
    acquire(&icache.lock);
80101bbe:	83 ec 0c             	sub    $0xc,%esp
80101bc1:	68 c0 26 11 80       	push   $0x801126c0
80101bc6:	e8 91 37 00 00       	call   8010535c <acquire>
80101bcb:	83 c4 10             	add    $0x10,%esp
    ip->flags = 0;
80101bce:	8b 45 08             	mov    0x8(%ebp),%eax
80101bd1:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    wakeup(ip);
80101bd8:	83 ec 0c             	sub    $0xc,%esp
80101bdb:	ff 75 08             	pushl  0x8(%ebp)
80101bde:	e8 36 35 00 00       	call   80105119 <wakeup>
80101be3:	83 c4 10             	add    $0x10,%esp
  }
  ip->ref--;
80101be6:	8b 45 08             	mov    0x8(%ebp),%eax
80101be9:	8b 40 08             	mov    0x8(%eax),%eax
80101bec:	8d 50 ff             	lea    -0x1(%eax),%edx
80101bef:	8b 45 08             	mov    0x8(%ebp),%eax
80101bf2:	89 50 08             	mov    %edx,0x8(%eax)
  release(&icache.lock);
80101bf5:	83 ec 0c             	sub    $0xc,%esp
80101bf8:	68 c0 26 11 80       	push   $0x801126c0
80101bfd:	e8 c1 37 00 00       	call   801053c3 <release>
80101c02:	83 c4 10             	add    $0x10,%esp
}
80101c05:	90                   	nop
80101c06:	c9                   	leave  
80101c07:	c3                   	ret    

80101c08 <iunlockput>:

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
80101c08:	55                   	push   %ebp
80101c09:	89 e5                	mov    %esp,%ebp
80101c0b:	83 ec 08             	sub    $0x8,%esp
  iunlock(ip);
80101c0e:	83 ec 0c             	sub    $0xc,%esp
80101c11:	ff 75 08             	pushl  0x8(%ebp)
80101c14:	e8 8d fe ff ff       	call   80101aa6 <iunlock>
80101c19:	83 c4 10             	add    $0x10,%esp
  iput(ip);
80101c1c:	83 ec 0c             	sub    $0xc,%esp
80101c1f:	ff 75 08             	pushl  0x8(%ebp)
80101c22:	e8 f1 fe ff ff       	call   80101b18 <iput>
80101c27:	83 c4 10             	add    $0x10,%esp
}
80101c2a:	90                   	nop
80101c2b:	c9                   	leave  
80101c2c:	c3                   	ret    

80101c2d <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101c2d:	55                   	push   %ebp
80101c2e:	89 e5                	mov    %esp,%ebp
80101c30:	53                   	push   %ebx
80101c31:	83 ec 14             	sub    $0x14,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
80101c34:	83 7d 0c 0b          	cmpl   $0xb,0xc(%ebp)
80101c38:	77 42                	ja     80101c7c <bmap+0x4f>
    if((addr = ip->addrs[bn]) == 0)
80101c3a:	8b 45 08             	mov    0x8(%ebp),%eax
80101c3d:	8b 55 0c             	mov    0xc(%ebp),%edx
80101c40:	83 c2 04             	add    $0x4,%edx
80101c43:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
80101c47:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101c4a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101c4e:	75 24                	jne    80101c74 <bmap+0x47>
      ip->addrs[bn] = addr = balloc(ip->dev);
80101c50:	8b 45 08             	mov    0x8(%ebp),%eax
80101c53:	8b 00                	mov    (%eax),%eax
80101c55:	83 ec 0c             	sub    $0xc,%esp
80101c58:	50                   	push   %eax
80101c59:	e8 9a f7 ff ff       	call   801013f8 <balloc>
80101c5e:	83 c4 10             	add    $0x10,%esp
80101c61:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101c64:	8b 45 08             	mov    0x8(%ebp),%eax
80101c67:	8b 55 0c             	mov    0xc(%ebp),%edx
80101c6a:	8d 4a 04             	lea    0x4(%edx),%ecx
80101c6d:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101c70:	89 54 88 0c          	mov    %edx,0xc(%eax,%ecx,4)
    return addr;
80101c74:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101c77:	e9 cb 00 00 00       	jmp    80101d47 <bmap+0x11a>
  }
  bn -= NDIRECT;
80101c7c:	83 6d 0c 0c          	subl   $0xc,0xc(%ebp)

  if(bn < NINDIRECT){
80101c80:	83 7d 0c 7f          	cmpl   $0x7f,0xc(%ebp)
80101c84:	0f 87 b0 00 00 00    	ja     80101d3a <bmap+0x10d>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
80101c8a:	8b 45 08             	mov    0x8(%ebp),%eax
80101c8d:	8b 40 4c             	mov    0x4c(%eax),%eax
80101c90:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101c93:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101c97:	75 1d                	jne    80101cb6 <bmap+0x89>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101c99:	8b 45 08             	mov    0x8(%ebp),%eax
80101c9c:	8b 00                	mov    (%eax),%eax
80101c9e:	83 ec 0c             	sub    $0xc,%esp
80101ca1:	50                   	push   %eax
80101ca2:	e8 51 f7 ff ff       	call   801013f8 <balloc>
80101ca7:	83 c4 10             	add    $0x10,%esp
80101caa:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101cad:	8b 45 08             	mov    0x8(%ebp),%eax
80101cb0:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101cb3:	89 50 4c             	mov    %edx,0x4c(%eax)
    bp = bread(ip->dev, addr);
80101cb6:	8b 45 08             	mov    0x8(%ebp),%eax
80101cb9:	8b 00                	mov    (%eax),%eax
80101cbb:	83 ec 08             	sub    $0x8,%esp
80101cbe:	ff 75 f4             	pushl  -0xc(%ebp)
80101cc1:	50                   	push   %eax
80101cc2:	e8 ed e4 ff ff       	call   801001b4 <bread>
80101cc7:	83 c4 10             	add    $0x10,%esp
80101cca:	89 45 f0             	mov    %eax,-0x10(%ebp)
    a = (uint*)bp->data;
80101ccd:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101cd0:	83 c0 18             	add    $0x18,%eax
80101cd3:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if((addr = a[bn]) == 0){
80101cd6:	8b 45 0c             	mov    0xc(%ebp),%eax
80101cd9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101ce0:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101ce3:	01 d0                	add    %edx,%eax
80101ce5:	8b 00                	mov    (%eax),%eax
80101ce7:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101cea:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101cee:	75 37                	jne    80101d27 <bmap+0xfa>
      a[bn] = addr = balloc(ip->dev);
80101cf0:	8b 45 0c             	mov    0xc(%ebp),%eax
80101cf3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101cfa:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101cfd:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
80101d00:	8b 45 08             	mov    0x8(%ebp),%eax
80101d03:	8b 00                	mov    (%eax),%eax
80101d05:	83 ec 0c             	sub    $0xc,%esp
80101d08:	50                   	push   %eax
80101d09:	e8 ea f6 ff ff       	call   801013f8 <balloc>
80101d0e:	83 c4 10             	add    $0x10,%esp
80101d11:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101d14:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101d17:	89 03                	mov    %eax,(%ebx)
      log_write(bp);
80101d19:	83 ec 0c             	sub    $0xc,%esp
80101d1c:	ff 75 f0             	pushl  -0x10(%ebp)
80101d1f:	e8 28 1a 00 00       	call   8010374c <log_write>
80101d24:	83 c4 10             	add    $0x10,%esp
    }
    brelse(bp);
80101d27:	83 ec 0c             	sub    $0xc,%esp
80101d2a:	ff 75 f0             	pushl  -0x10(%ebp)
80101d2d:	e8 f9 e4 ff ff       	call   8010022b <brelse>
80101d32:	83 c4 10             	add    $0x10,%esp
    return addr;
80101d35:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101d38:	eb 0d                	jmp    80101d47 <bmap+0x11a>
  }

  panic("bmap: out of range");
80101d3a:	83 ec 0c             	sub    $0xc,%esp
80101d3d:	68 f4 89 10 80       	push   $0x801089f4
80101d42:	e8 1b e8 ff ff       	call   80100562 <panic>
}
80101d47:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101d4a:	c9                   	leave  
80101d4b:	c3                   	ret    

80101d4c <itrunc>:
// to it (no directory entries referring to it)
// and has no in-memory reference to it (is
// not an open file or current directory).
static void
itrunc(struct inode *ip)
{
80101d4c:	55                   	push   %ebp
80101d4d:	89 e5                	mov    %esp,%ebp
80101d4f:	83 ec 18             	sub    $0x18,%esp
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101d52:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80101d59:	eb 45                	jmp    80101da0 <itrunc+0x54>
    if(ip->addrs[i]){
80101d5b:	8b 45 08             	mov    0x8(%ebp),%eax
80101d5e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101d61:	83 c2 04             	add    $0x4,%edx
80101d64:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
80101d68:	85 c0                	test   %eax,%eax
80101d6a:	74 30                	je     80101d9c <itrunc+0x50>
      bfree(ip->dev, ip->addrs[i]);
80101d6c:	8b 45 08             	mov    0x8(%ebp),%eax
80101d6f:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101d72:	83 c2 04             	add    $0x4,%edx
80101d75:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
80101d79:	8b 55 08             	mov    0x8(%ebp),%edx
80101d7c:	8b 12                	mov    (%edx),%edx
80101d7e:	83 ec 08             	sub    $0x8,%esp
80101d81:	50                   	push   %eax
80101d82:	52                   	push   %edx
80101d83:	e8 bc f7 ff ff       	call   80101544 <bfree>
80101d88:	83 c4 10             	add    $0x10,%esp
      ip->addrs[i] = 0;
80101d8b:	8b 45 08             	mov    0x8(%ebp),%eax
80101d8e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101d91:	83 c2 04             	add    $0x4,%edx
80101d94:	c7 44 90 0c 00 00 00 	movl   $0x0,0xc(%eax,%edx,4)
80101d9b:	00 
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101d9c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80101da0:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
80101da4:	7e b5                	jle    80101d5b <itrunc+0xf>
      bfree(ip->dev, ip->addrs[i]);
      ip->addrs[i] = 0;
    }
  }
  
  if(ip->addrs[NDIRECT]){
80101da6:	8b 45 08             	mov    0x8(%ebp),%eax
80101da9:	8b 40 4c             	mov    0x4c(%eax),%eax
80101dac:	85 c0                	test   %eax,%eax
80101dae:	0f 84 a1 00 00 00    	je     80101e55 <itrunc+0x109>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101db4:	8b 45 08             	mov    0x8(%ebp),%eax
80101db7:	8b 50 4c             	mov    0x4c(%eax),%edx
80101dba:	8b 45 08             	mov    0x8(%ebp),%eax
80101dbd:	8b 00                	mov    (%eax),%eax
80101dbf:	83 ec 08             	sub    $0x8,%esp
80101dc2:	52                   	push   %edx
80101dc3:	50                   	push   %eax
80101dc4:	e8 eb e3 ff ff       	call   801001b4 <bread>
80101dc9:	83 c4 10             	add    $0x10,%esp
80101dcc:	89 45 ec             	mov    %eax,-0x14(%ebp)
    a = (uint*)bp->data;
80101dcf:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101dd2:	83 c0 18             	add    $0x18,%eax
80101dd5:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for(j = 0; j < NINDIRECT; j++){
80101dd8:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
80101ddf:	eb 3c                	jmp    80101e1d <itrunc+0xd1>
      if(a[j])
80101de1:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101de4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101deb:	8b 45 e8             	mov    -0x18(%ebp),%eax
80101dee:	01 d0                	add    %edx,%eax
80101df0:	8b 00                	mov    (%eax),%eax
80101df2:	85 c0                	test   %eax,%eax
80101df4:	74 23                	je     80101e19 <itrunc+0xcd>
        bfree(ip->dev, a[j]);
80101df6:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101df9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101e00:	8b 45 e8             	mov    -0x18(%ebp),%eax
80101e03:	01 d0                	add    %edx,%eax
80101e05:	8b 00                	mov    (%eax),%eax
80101e07:	8b 55 08             	mov    0x8(%ebp),%edx
80101e0a:	8b 12                	mov    (%edx),%edx
80101e0c:	83 ec 08             	sub    $0x8,%esp
80101e0f:	50                   	push   %eax
80101e10:	52                   	push   %edx
80101e11:	e8 2e f7 ff ff       	call   80101544 <bfree>
80101e16:	83 c4 10             	add    $0x10,%esp
  }
  
  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    a = (uint*)bp->data;
    for(j = 0; j < NINDIRECT; j++){
80101e19:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
80101e1d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101e20:	83 f8 7f             	cmp    $0x7f,%eax
80101e23:	76 bc                	jbe    80101de1 <itrunc+0x95>
      if(a[j])
        bfree(ip->dev, a[j]);
    }
    brelse(bp);
80101e25:	83 ec 0c             	sub    $0xc,%esp
80101e28:	ff 75 ec             	pushl  -0x14(%ebp)
80101e2b:	e8 fb e3 ff ff       	call   8010022b <brelse>
80101e30:	83 c4 10             	add    $0x10,%esp
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101e33:	8b 45 08             	mov    0x8(%ebp),%eax
80101e36:	8b 40 4c             	mov    0x4c(%eax),%eax
80101e39:	8b 55 08             	mov    0x8(%ebp),%edx
80101e3c:	8b 12                	mov    (%edx),%edx
80101e3e:	83 ec 08             	sub    $0x8,%esp
80101e41:	50                   	push   %eax
80101e42:	52                   	push   %edx
80101e43:	e8 fc f6 ff ff       	call   80101544 <bfree>
80101e48:	83 c4 10             	add    $0x10,%esp
    ip->addrs[NDIRECT] = 0;
80101e4b:	8b 45 08             	mov    0x8(%ebp),%eax
80101e4e:	c7 40 4c 00 00 00 00 	movl   $0x0,0x4c(%eax)
  }

  ip->size = 0;
80101e55:	8b 45 08             	mov    0x8(%ebp),%eax
80101e58:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
  iupdate(ip);
80101e5f:	83 ec 0c             	sub    $0xc,%esp
80101e62:	ff 75 08             	pushl  0x8(%ebp)
80101e65:	e8 04 f9 ff ff       	call   8010176e <iupdate>
80101e6a:	83 c4 10             	add    $0x10,%esp
}
80101e6d:	90                   	nop
80101e6e:	c9                   	leave  
80101e6f:	c3                   	ret    

80101e70 <stati>:

// Copy stat information from inode.
void
stati(struct inode *ip, struct stat *st)
{
80101e70:	55                   	push   %ebp
80101e71:	89 e5                	mov    %esp,%ebp
  st->dev = ip->dev;
80101e73:	8b 45 08             	mov    0x8(%ebp),%eax
80101e76:	8b 00                	mov    (%eax),%eax
80101e78:	89 c2                	mov    %eax,%edx
80101e7a:	8b 45 0c             	mov    0xc(%ebp),%eax
80101e7d:	89 50 04             	mov    %edx,0x4(%eax)
  st->ino = ip->inum;
80101e80:	8b 45 08             	mov    0x8(%ebp),%eax
80101e83:	8b 50 04             	mov    0x4(%eax),%edx
80101e86:	8b 45 0c             	mov    0xc(%ebp),%eax
80101e89:	89 50 08             	mov    %edx,0x8(%eax)
  st->type = ip->type;
80101e8c:	8b 45 08             	mov    0x8(%ebp),%eax
80101e8f:	0f b7 50 10          	movzwl 0x10(%eax),%edx
80101e93:	8b 45 0c             	mov    0xc(%ebp),%eax
80101e96:	66 89 10             	mov    %dx,(%eax)
  st->nlink = ip->nlink;
80101e99:	8b 45 08             	mov    0x8(%ebp),%eax
80101e9c:	0f b7 50 16          	movzwl 0x16(%eax),%edx
80101ea0:	8b 45 0c             	mov    0xc(%ebp),%eax
80101ea3:	66 89 50 0c          	mov    %dx,0xc(%eax)
  st->size = ip->size;
80101ea7:	8b 45 08             	mov    0x8(%ebp),%eax
80101eaa:	8b 50 18             	mov    0x18(%eax),%edx
80101ead:	8b 45 0c             	mov    0xc(%ebp),%eax
80101eb0:	89 50 10             	mov    %edx,0x10(%eax)
}
80101eb3:	90                   	nop
80101eb4:	5d                   	pop    %ebp
80101eb5:	c3                   	ret    

80101eb6 <readi>:

//PAGEBREAK!
// Read data from inode.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101eb6:	55                   	push   %ebp
80101eb7:	89 e5                	mov    %esp,%ebp
80101eb9:	83 ec 18             	sub    $0x18,%esp
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101ebc:	8b 45 08             	mov    0x8(%ebp),%eax
80101ebf:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80101ec3:	66 83 f8 03          	cmp    $0x3,%ax
80101ec7:	75 5c                	jne    80101f25 <readi+0x6f>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101ec9:	8b 45 08             	mov    0x8(%ebp),%eax
80101ecc:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101ed0:	66 85 c0             	test   %ax,%ax
80101ed3:	78 20                	js     80101ef5 <readi+0x3f>
80101ed5:	8b 45 08             	mov    0x8(%ebp),%eax
80101ed8:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101edc:	66 83 f8 09          	cmp    $0x9,%ax
80101ee0:	7f 13                	jg     80101ef5 <readi+0x3f>
80101ee2:	8b 45 08             	mov    0x8(%ebp),%eax
80101ee5:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101ee9:	98                   	cwtl   
80101eea:	8b 04 c5 40 26 11 80 	mov    -0x7feed9c0(,%eax,8),%eax
80101ef1:	85 c0                	test   %eax,%eax
80101ef3:	75 0a                	jne    80101eff <readi+0x49>
      return -1;
80101ef5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101efa:	e9 0c 01 00 00       	jmp    8010200b <readi+0x155>
    return devsw[ip->major].read(ip, dst, n);
80101eff:	8b 45 08             	mov    0x8(%ebp),%eax
80101f02:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101f06:	98                   	cwtl   
80101f07:	8b 04 c5 40 26 11 80 	mov    -0x7feed9c0(,%eax,8),%eax
80101f0e:	8b 55 14             	mov    0x14(%ebp),%edx
80101f11:	83 ec 04             	sub    $0x4,%esp
80101f14:	52                   	push   %edx
80101f15:	ff 75 0c             	pushl  0xc(%ebp)
80101f18:	ff 75 08             	pushl  0x8(%ebp)
80101f1b:	ff d0                	call   *%eax
80101f1d:	83 c4 10             	add    $0x10,%esp
80101f20:	e9 e6 00 00 00       	jmp    8010200b <readi+0x155>
  }

  if(off > ip->size || off + n < off)
80101f25:	8b 45 08             	mov    0x8(%ebp),%eax
80101f28:	8b 40 18             	mov    0x18(%eax),%eax
80101f2b:	3b 45 10             	cmp    0x10(%ebp),%eax
80101f2e:	72 0d                	jb     80101f3d <readi+0x87>
80101f30:	8b 55 10             	mov    0x10(%ebp),%edx
80101f33:	8b 45 14             	mov    0x14(%ebp),%eax
80101f36:	01 d0                	add    %edx,%eax
80101f38:	3b 45 10             	cmp    0x10(%ebp),%eax
80101f3b:	73 0a                	jae    80101f47 <readi+0x91>
    return -1;
80101f3d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101f42:	e9 c4 00 00 00       	jmp    8010200b <readi+0x155>
  if(off + n > ip->size)
80101f47:	8b 55 10             	mov    0x10(%ebp),%edx
80101f4a:	8b 45 14             	mov    0x14(%ebp),%eax
80101f4d:	01 c2                	add    %eax,%edx
80101f4f:	8b 45 08             	mov    0x8(%ebp),%eax
80101f52:	8b 40 18             	mov    0x18(%eax),%eax
80101f55:	39 c2                	cmp    %eax,%edx
80101f57:	76 0c                	jbe    80101f65 <readi+0xaf>
    n = ip->size - off;
80101f59:	8b 45 08             	mov    0x8(%ebp),%eax
80101f5c:	8b 40 18             	mov    0x18(%eax),%eax
80101f5f:	2b 45 10             	sub    0x10(%ebp),%eax
80101f62:	89 45 14             	mov    %eax,0x14(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101f65:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80101f6c:	e9 8b 00 00 00       	jmp    80101ffc <readi+0x146>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101f71:	8b 45 10             	mov    0x10(%ebp),%eax
80101f74:	c1 e8 09             	shr    $0x9,%eax
80101f77:	83 ec 08             	sub    $0x8,%esp
80101f7a:	50                   	push   %eax
80101f7b:	ff 75 08             	pushl  0x8(%ebp)
80101f7e:	e8 aa fc ff ff       	call   80101c2d <bmap>
80101f83:	83 c4 10             	add    $0x10,%esp
80101f86:	89 c2                	mov    %eax,%edx
80101f88:	8b 45 08             	mov    0x8(%ebp),%eax
80101f8b:	8b 00                	mov    (%eax),%eax
80101f8d:	83 ec 08             	sub    $0x8,%esp
80101f90:	52                   	push   %edx
80101f91:	50                   	push   %eax
80101f92:	e8 1d e2 ff ff       	call   801001b4 <bread>
80101f97:	83 c4 10             	add    $0x10,%esp
80101f9a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101f9d:	8b 45 10             	mov    0x10(%ebp),%eax
80101fa0:	25 ff 01 00 00       	and    $0x1ff,%eax
80101fa5:	ba 00 02 00 00       	mov    $0x200,%edx
80101faa:	29 c2                	sub    %eax,%edx
80101fac:	8b 45 14             	mov    0x14(%ebp),%eax
80101faf:	2b 45 f4             	sub    -0xc(%ebp),%eax
80101fb2:	39 c2                	cmp    %eax,%edx
80101fb4:	0f 46 c2             	cmovbe %edx,%eax
80101fb7:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(dst, bp->data + off%BSIZE, m);
80101fba:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101fbd:	8d 50 18             	lea    0x18(%eax),%edx
80101fc0:	8b 45 10             	mov    0x10(%ebp),%eax
80101fc3:	25 ff 01 00 00       	and    $0x1ff,%eax
80101fc8:	01 d0                	add    %edx,%eax
80101fca:	83 ec 04             	sub    $0x4,%esp
80101fcd:	ff 75 ec             	pushl  -0x14(%ebp)
80101fd0:	50                   	push   %eax
80101fd1:	ff 75 0c             	pushl  0xc(%ebp)
80101fd4:	e8 a3 36 00 00       	call   8010567c <memmove>
80101fd9:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
80101fdc:	83 ec 0c             	sub    $0xc,%esp
80101fdf:	ff 75 f0             	pushl  -0x10(%ebp)
80101fe2:	e8 44 e2 ff ff       	call   8010022b <brelse>
80101fe7:	83 c4 10             	add    $0x10,%esp
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101fea:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101fed:	01 45 f4             	add    %eax,-0xc(%ebp)
80101ff0:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101ff3:	01 45 10             	add    %eax,0x10(%ebp)
80101ff6:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101ff9:	01 45 0c             	add    %eax,0xc(%ebp)
80101ffc:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101fff:	3b 45 14             	cmp    0x14(%ebp),%eax
80102002:	0f 82 69 ff ff ff    	jb     80101f71 <readi+0xbb>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
80102008:	8b 45 14             	mov    0x14(%ebp),%eax
}
8010200b:	c9                   	leave  
8010200c:	c3                   	ret    

8010200d <writei>:

// PAGEBREAK!
// Write data to inode.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
8010200d:	55                   	push   %ebp
8010200e:	89 e5                	mov    %esp,%ebp
80102010:	83 ec 18             	sub    $0x18,%esp
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80102013:	8b 45 08             	mov    0x8(%ebp),%eax
80102016:	0f b7 40 10          	movzwl 0x10(%eax),%eax
8010201a:	66 83 f8 03          	cmp    $0x3,%ax
8010201e:	75 5c                	jne    8010207c <writei+0x6f>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80102020:	8b 45 08             	mov    0x8(%ebp),%eax
80102023:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80102027:	66 85 c0             	test   %ax,%ax
8010202a:	78 20                	js     8010204c <writei+0x3f>
8010202c:	8b 45 08             	mov    0x8(%ebp),%eax
8010202f:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80102033:	66 83 f8 09          	cmp    $0x9,%ax
80102037:	7f 13                	jg     8010204c <writei+0x3f>
80102039:	8b 45 08             	mov    0x8(%ebp),%eax
8010203c:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80102040:	98                   	cwtl   
80102041:	8b 04 c5 44 26 11 80 	mov    -0x7feed9bc(,%eax,8),%eax
80102048:	85 c0                	test   %eax,%eax
8010204a:	75 0a                	jne    80102056 <writei+0x49>
      return -1;
8010204c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102051:	e9 3d 01 00 00       	jmp    80102193 <writei+0x186>
    return devsw[ip->major].write(ip, src, n);
80102056:	8b 45 08             	mov    0x8(%ebp),%eax
80102059:	0f b7 40 12          	movzwl 0x12(%eax),%eax
8010205d:	98                   	cwtl   
8010205e:	8b 04 c5 44 26 11 80 	mov    -0x7feed9bc(,%eax,8),%eax
80102065:	8b 55 14             	mov    0x14(%ebp),%edx
80102068:	83 ec 04             	sub    $0x4,%esp
8010206b:	52                   	push   %edx
8010206c:	ff 75 0c             	pushl  0xc(%ebp)
8010206f:	ff 75 08             	pushl  0x8(%ebp)
80102072:	ff d0                	call   *%eax
80102074:	83 c4 10             	add    $0x10,%esp
80102077:	e9 17 01 00 00       	jmp    80102193 <writei+0x186>
  }

  if(off > ip->size || off + n < off)
8010207c:	8b 45 08             	mov    0x8(%ebp),%eax
8010207f:	8b 40 18             	mov    0x18(%eax),%eax
80102082:	3b 45 10             	cmp    0x10(%ebp),%eax
80102085:	72 0d                	jb     80102094 <writei+0x87>
80102087:	8b 55 10             	mov    0x10(%ebp),%edx
8010208a:	8b 45 14             	mov    0x14(%ebp),%eax
8010208d:	01 d0                	add    %edx,%eax
8010208f:	3b 45 10             	cmp    0x10(%ebp),%eax
80102092:	73 0a                	jae    8010209e <writei+0x91>
    return -1;
80102094:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102099:	e9 f5 00 00 00       	jmp    80102193 <writei+0x186>
  if(off + n > MAXFILE*BSIZE)
8010209e:	8b 55 10             	mov    0x10(%ebp),%edx
801020a1:	8b 45 14             	mov    0x14(%ebp),%eax
801020a4:	01 d0                	add    %edx,%eax
801020a6:	3d 00 18 01 00       	cmp    $0x11800,%eax
801020ab:	76 0a                	jbe    801020b7 <writei+0xaa>
    return -1;
801020ad:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801020b2:	e9 dc 00 00 00       	jmp    80102193 <writei+0x186>

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
801020b7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801020be:	e9 99 00 00 00       	jmp    8010215c <writei+0x14f>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801020c3:	8b 45 10             	mov    0x10(%ebp),%eax
801020c6:	c1 e8 09             	shr    $0x9,%eax
801020c9:	83 ec 08             	sub    $0x8,%esp
801020cc:	50                   	push   %eax
801020cd:	ff 75 08             	pushl  0x8(%ebp)
801020d0:	e8 58 fb ff ff       	call   80101c2d <bmap>
801020d5:	83 c4 10             	add    $0x10,%esp
801020d8:	89 c2                	mov    %eax,%edx
801020da:	8b 45 08             	mov    0x8(%ebp),%eax
801020dd:	8b 00                	mov    (%eax),%eax
801020df:	83 ec 08             	sub    $0x8,%esp
801020e2:	52                   	push   %edx
801020e3:	50                   	push   %eax
801020e4:	e8 cb e0 ff ff       	call   801001b4 <bread>
801020e9:	83 c4 10             	add    $0x10,%esp
801020ec:	89 45 f0             	mov    %eax,-0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
801020ef:	8b 45 10             	mov    0x10(%ebp),%eax
801020f2:	25 ff 01 00 00       	and    $0x1ff,%eax
801020f7:	ba 00 02 00 00       	mov    $0x200,%edx
801020fc:	29 c2                	sub    %eax,%edx
801020fe:	8b 45 14             	mov    0x14(%ebp),%eax
80102101:	2b 45 f4             	sub    -0xc(%ebp),%eax
80102104:	39 c2                	cmp    %eax,%edx
80102106:	0f 46 c2             	cmovbe %edx,%eax
80102109:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(bp->data + off%BSIZE, src, m);
8010210c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010210f:	8d 50 18             	lea    0x18(%eax),%edx
80102112:	8b 45 10             	mov    0x10(%ebp),%eax
80102115:	25 ff 01 00 00       	and    $0x1ff,%eax
8010211a:	01 d0                	add    %edx,%eax
8010211c:	83 ec 04             	sub    $0x4,%esp
8010211f:	ff 75 ec             	pushl  -0x14(%ebp)
80102122:	ff 75 0c             	pushl  0xc(%ebp)
80102125:	50                   	push   %eax
80102126:	e8 51 35 00 00       	call   8010567c <memmove>
8010212b:	83 c4 10             	add    $0x10,%esp
    log_write(bp);
8010212e:	83 ec 0c             	sub    $0xc,%esp
80102131:	ff 75 f0             	pushl  -0x10(%ebp)
80102134:	e8 13 16 00 00       	call   8010374c <log_write>
80102139:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
8010213c:	83 ec 0c             	sub    $0xc,%esp
8010213f:	ff 75 f0             	pushl  -0x10(%ebp)
80102142:	e8 e4 e0 ff ff       	call   8010022b <brelse>
80102147:	83 c4 10             	add    $0x10,%esp
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
8010214a:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010214d:	01 45 f4             	add    %eax,-0xc(%ebp)
80102150:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102153:	01 45 10             	add    %eax,0x10(%ebp)
80102156:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102159:	01 45 0c             	add    %eax,0xc(%ebp)
8010215c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010215f:	3b 45 14             	cmp    0x14(%ebp),%eax
80102162:	0f 82 5b ff ff ff    	jb     801020c3 <writei+0xb6>
    memmove(bp->data + off%BSIZE, src, m);
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
80102168:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
8010216c:	74 22                	je     80102190 <writei+0x183>
8010216e:	8b 45 08             	mov    0x8(%ebp),%eax
80102171:	8b 40 18             	mov    0x18(%eax),%eax
80102174:	3b 45 10             	cmp    0x10(%ebp),%eax
80102177:	73 17                	jae    80102190 <writei+0x183>
    ip->size = off;
80102179:	8b 45 08             	mov    0x8(%ebp),%eax
8010217c:	8b 55 10             	mov    0x10(%ebp),%edx
8010217f:	89 50 18             	mov    %edx,0x18(%eax)
    iupdate(ip);
80102182:	83 ec 0c             	sub    $0xc,%esp
80102185:	ff 75 08             	pushl  0x8(%ebp)
80102188:	e8 e1 f5 ff ff       	call   8010176e <iupdate>
8010218d:	83 c4 10             	add    $0x10,%esp
  }
  return n;
80102190:	8b 45 14             	mov    0x14(%ebp),%eax
}
80102193:	c9                   	leave  
80102194:	c3                   	ret    

80102195 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80102195:	55                   	push   %ebp
80102196:	89 e5                	mov    %esp,%ebp
80102198:	83 ec 08             	sub    $0x8,%esp
  return strncmp(s, t, DIRSIZ);
8010219b:	83 ec 04             	sub    $0x4,%esp
8010219e:	6a 0e                	push   $0xe
801021a0:	ff 75 0c             	pushl  0xc(%ebp)
801021a3:	ff 75 08             	pushl  0x8(%ebp)
801021a6:	e8 69 35 00 00       	call   80105714 <strncmp>
801021ab:	83 c4 10             	add    $0x10,%esp
}
801021ae:	c9                   	leave  
801021af:	c3                   	ret    

801021b0 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
801021b0:	55                   	push   %ebp
801021b1:	89 e5                	mov    %esp,%ebp
801021b3:	83 ec 28             	sub    $0x28,%esp
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
801021b6:	8b 45 08             	mov    0x8(%ebp),%eax
801021b9:	0f b7 40 10          	movzwl 0x10(%eax),%eax
801021bd:	66 83 f8 01          	cmp    $0x1,%ax
801021c1:	74 0d                	je     801021d0 <dirlookup+0x20>
    panic("dirlookup not DIR");
801021c3:	83 ec 0c             	sub    $0xc,%esp
801021c6:	68 07 8a 10 80       	push   $0x80108a07
801021cb:	e8 92 e3 ff ff       	call   80100562 <panic>

  for(off = 0; off < dp->size; off += sizeof(de)){
801021d0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801021d7:	eb 7b                	jmp    80102254 <dirlookup+0xa4>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801021d9:	6a 10                	push   $0x10
801021db:	ff 75 f4             	pushl  -0xc(%ebp)
801021de:	8d 45 e0             	lea    -0x20(%ebp),%eax
801021e1:	50                   	push   %eax
801021e2:	ff 75 08             	pushl  0x8(%ebp)
801021e5:	e8 cc fc ff ff       	call   80101eb6 <readi>
801021ea:	83 c4 10             	add    $0x10,%esp
801021ed:	83 f8 10             	cmp    $0x10,%eax
801021f0:	74 0d                	je     801021ff <dirlookup+0x4f>
      panic("dirlink read");
801021f2:	83 ec 0c             	sub    $0xc,%esp
801021f5:	68 19 8a 10 80       	push   $0x80108a19
801021fa:	e8 63 e3 ff ff       	call   80100562 <panic>
    if(de.inum == 0)
801021ff:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
80102203:	66 85 c0             	test   %ax,%ax
80102206:	74 47                	je     8010224f <dirlookup+0x9f>
      continue;
    if(namecmp(name, de.name) == 0){
80102208:	83 ec 08             	sub    $0x8,%esp
8010220b:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010220e:	83 c0 02             	add    $0x2,%eax
80102211:	50                   	push   %eax
80102212:	ff 75 0c             	pushl  0xc(%ebp)
80102215:	e8 7b ff ff ff       	call   80102195 <namecmp>
8010221a:	83 c4 10             	add    $0x10,%esp
8010221d:	85 c0                	test   %eax,%eax
8010221f:	75 2f                	jne    80102250 <dirlookup+0xa0>
      // entry matches path element
      if(poff)
80102221:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80102225:	74 08                	je     8010222f <dirlookup+0x7f>
        *poff = off;
80102227:	8b 45 10             	mov    0x10(%ebp),%eax
8010222a:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010222d:	89 10                	mov    %edx,(%eax)
      inum = de.inum;
8010222f:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
80102233:	0f b7 c0             	movzwl %ax,%eax
80102236:	89 45 f0             	mov    %eax,-0x10(%ebp)
      return iget(dp->dev, inum);
80102239:	8b 45 08             	mov    0x8(%ebp),%eax
8010223c:	8b 00                	mov    (%eax),%eax
8010223e:	83 ec 08             	sub    $0x8,%esp
80102241:	ff 75 f0             	pushl  -0x10(%ebp)
80102244:	50                   	push   %eax
80102245:	e8 e5 f5 ff ff       	call   8010182f <iget>
8010224a:	83 c4 10             	add    $0x10,%esp
8010224d:	eb 19                	jmp    80102268 <dirlookup+0xb8>

  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
    if(de.inum == 0)
      continue;
8010224f:	90                   	nop
  struct dirent de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80102250:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
80102254:	8b 45 08             	mov    0x8(%ebp),%eax
80102257:	8b 40 18             	mov    0x18(%eax),%eax
8010225a:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010225d:	0f 87 76 ff ff ff    	ja     801021d9 <dirlookup+0x29>
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
80102263:	b8 00 00 00 00       	mov    $0x0,%eax
}
80102268:	c9                   	leave  
80102269:	c3                   	ret    

8010226a <dirlink>:

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
8010226a:	55                   	push   %ebp
8010226b:	89 e5                	mov    %esp,%ebp
8010226d:	83 ec 28             	sub    $0x28,%esp
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
80102270:	83 ec 04             	sub    $0x4,%esp
80102273:	6a 00                	push   $0x0
80102275:	ff 75 0c             	pushl  0xc(%ebp)
80102278:	ff 75 08             	pushl  0x8(%ebp)
8010227b:	e8 30 ff ff ff       	call   801021b0 <dirlookup>
80102280:	83 c4 10             	add    $0x10,%esp
80102283:	89 45 f0             	mov    %eax,-0x10(%ebp)
80102286:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010228a:	74 18                	je     801022a4 <dirlink+0x3a>
    iput(ip);
8010228c:	83 ec 0c             	sub    $0xc,%esp
8010228f:	ff 75 f0             	pushl  -0x10(%ebp)
80102292:	e8 81 f8 ff ff       	call   80101b18 <iput>
80102297:	83 c4 10             	add    $0x10,%esp
    return -1;
8010229a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010229f:	e9 9c 00 00 00       	jmp    80102340 <dirlink+0xd6>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
801022a4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801022ab:	eb 39                	jmp    801022e6 <dirlink+0x7c>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801022ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
801022b0:	6a 10                	push   $0x10
801022b2:	50                   	push   %eax
801022b3:	8d 45 e0             	lea    -0x20(%ebp),%eax
801022b6:	50                   	push   %eax
801022b7:	ff 75 08             	pushl  0x8(%ebp)
801022ba:	e8 f7 fb ff ff       	call   80101eb6 <readi>
801022bf:	83 c4 10             	add    $0x10,%esp
801022c2:	83 f8 10             	cmp    $0x10,%eax
801022c5:	74 0d                	je     801022d4 <dirlink+0x6a>
      panic("dirlink read");
801022c7:	83 ec 0c             	sub    $0xc,%esp
801022ca:	68 19 8a 10 80       	push   $0x80108a19
801022cf:	e8 8e e2 ff ff       	call   80100562 <panic>
    if(de.inum == 0)
801022d4:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
801022d8:	66 85 c0             	test   %ax,%ax
801022db:	74 18                	je     801022f5 <dirlink+0x8b>
    iput(ip);
    return -1;
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
801022dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801022e0:	83 c0 10             	add    $0x10,%eax
801022e3:	89 45 f4             	mov    %eax,-0xc(%ebp)
801022e6:	8b 45 08             	mov    0x8(%ebp),%eax
801022e9:	8b 50 18             	mov    0x18(%eax),%edx
801022ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
801022ef:	39 c2                	cmp    %eax,%edx
801022f1:	77 ba                	ja     801022ad <dirlink+0x43>
801022f3:	eb 01                	jmp    801022f6 <dirlink+0x8c>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
    if(de.inum == 0)
      break;
801022f5:	90                   	nop
  }

  strncpy(de.name, name, DIRSIZ);
801022f6:	83 ec 04             	sub    $0x4,%esp
801022f9:	6a 0e                	push   $0xe
801022fb:	ff 75 0c             	pushl  0xc(%ebp)
801022fe:	8d 45 e0             	lea    -0x20(%ebp),%eax
80102301:	83 c0 02             	add    $0x2,%eax
80102304:	50                   	push   %eax
80102305:	e8 60 34 00 00       	call   8010576a <strncpy>
8010230a:	83 c4 10             	add    $0x10,%esp
  de.inum = inum;
8010230d:	8b 45 10             	mov    0x10(%ebp),%eax
80102310:	66 89 45 e0          	mov    %ax,-0x20(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102314:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102317:	6a 10                	push   $0x10
80102319:	50                   	push   %eax
8010231a:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010231d:	50                   	push   %eax
8010231e:	ff 75 08             	pushl  0x8(%ebp)
80102321:	e8 e7 fc ff ff       	call   8010200d <writei>
80102326:	83 c4 10             	add    $0x10,%esp
80102329:	83 f8 10             	cmp    $0x10,%eax
8010232c:	74 0d                	je     8010233b <dirlink+0xd1>
    panic("dirlink");
8010232e:	83 ec 0c             	sub    $0xc,%esp
80102331:	68 26 8a 10 80       	push   $0x80108a26
80102336:	e8 27 e2 ff ff       	call   80100562 <panic>
  
  return 0;
8010233b:	b8 00 00 00 00       	mov    $0x0,%eax
}
80102340:	c9                   	leave  
80102341:	c3                   	ret    

80102342 <skipelem>:
//   skipelem("a", name) = "", setting name = "a"
//   skipelem("", name) = skipelem("////", name) = 0
//
static char*
skipelem(char *path, char *name)
{
80102342:	55                   	push   %ebp
80102343:	89 e5                	mov    %esp,%ebp
80102345:	83 ec 18             	sub    $0x18,%esp
  char *s;
  int len;

  while(*path == '/')
80102348:	eb 04                	jmp    8010234e <skipelem+0xc>
    path++;
8010234a:	83 45 08 01          	addl   $0x1,0x8(%ebp)
skipelem(char *path, char *name)
{
  char *s;
  int len;

  while(*path == '/')
8010234e:	8b 45 08             	mov    0x8(%ebp),%eax
80102351:	0f b6 00             	movzbl (%eax),%eax
80102354:	3c 2f                	cmp    $0x2f,%al
80102356:	74 f2                	je     8010234a <skipelem+0x8>
    path++;
  if(*path == 0)
80102358:	8b 45 08             	mov    0x8(%ebp),%eax
8010235b:	0f b6 00             	movzbl (%eax),%eax
8010235e:	84 c0                	test   %al,%al
80102360:	75 07                	jne    80102369 <skipelem+0x27>
    return 0;
80102362:	b8 00 00 00 00       	mov    $0x0,%eax
80102367:	eb 7b                	jmp    801023e4 <skipelem+0xa2>
  s = path;
80102369:	8b 45 08             	mov    0x8(%ebp),%eax
8010236c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(*path != '/' && *path != 0)
8010236f:	eb 04                	jmp    80102375 <skipelem+0x33>
    path++;
80102371:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80102375:	8b 45 08             	mov    0x8(%ebp),%eax
80102378:	0f b6 00             	movzbl (%eax),%eax
8010237b:	3c 2f                	cmp    $0x2f,%al
8010237d:	74 0a                	je     80102389 <skipelem+0x47>
8010237f:	8b 45 08             	mov    0x8(%ebp),%eax
80102382:	0f b6 00             	movzbl (%eax),%eax
80102385:	84 c0                	test   %al,%al
80102387:	75 e8                	jne    80102371 <skipelem+0x2f>
    path++;
  len = path - s;
80102389:	8b 55 08             	mov    0x8(%ebp),%edx
8010238c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010238f:	29 c2                	sub    %eax,%edx
80102391:	89 d0                	mov    %edx,%eax
80102393:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(len >= DIRSIZ)
80102396:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
8010239a:	7e 15                	jle    801023b1 <skipelem+0x6f>
    memmove(name, s, DIRSIZ);
8010239c:	83 ec 04             	sub    $0x4,%esp
8010239f:	6a 0e                	push   $0xe
801023a1:	ff 75 f4             	pushl  -0xc(%ebp)
801023a4:	ff 75 0c             	pushl  0xc(%ebp)
801023a7:	e8 d0 32 00 00       	call   8010567c <memmove>
801023ac:	83 c4 10             	add    $0x10,%esp
801023af:	eb 26                	jmp    801023d7 <skipelem+0x95>
  else {
    memmove(name, s, len);
801023b1:	8b 45 f0             	mov    -0x10(%ebp),%eax
801023b4:	83 ec 04             	sub    $0x4,%esp
801023b7:	50                   	push   %eax
801023b8:	ff 75 f4             	pushl  -0xc(%ebp)
801023bb:	ff 75 0c             	pushl  0xc(%ebp)
801023be:	e8 b9 32 00 00       	call   8010567c <memmove>
801023c3:	83 c4 10             	add    $0x10,%esp
    name[len] = 0;
801023c6:	8b 55 f0             	mov    -0x10(%ebp),%edx
801023c9:	8b 45 0c             	mov    0xc(%ebp),%eax
801023cc:	01 d0                	add    %edx,%eax
801023ce:	c6 00 00             	movb   $0x0,(%eax)
  }
  while(*path == '/')
801023d1:	eb 04                	jmp    801023d7 <skipelem+0x95>
    path++;
801023d3:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
801023d7:	8b 45 08             	mov    0x8(%ebp),%eax
801023da:	0f b6 00             	movzbl (%eax),%eax
801023dd:	3c 2f                	cmp    $0x2f,%al
801023df:	74 f2                	je     801023d3 <skipelem+0x91>
    path++;
  return path;
801023e1:	8b 45 08             	mov    0x8(%ebp),%eax
}
801023e4:	c9                   	leave  
801023e5:	c3                   	ret    

801023e6 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
801023e6:	55                   	push   %ebp
801023e7:	89 e5                	mov    %esp,%ebp
801023e9:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip, *next;

  if(*path == '/')
801023ec:	8b 45 08             	mov    0x8(%ebp),%eax
801023ef:	0f b6 00             	movzbl (%eax),%eax
801023f2:	3c 2f                	cmp    $0x2f,%al
801023f4:	75 17                	jne    8010240d <namex+0x27>
    ip = iget(ROOTDEV, ROOTINO);
801023f6:	83 ec 08             	sub    $0x8,%esp
801023f9:	6a 01                	push   $0x1
801023fb:	6a 01                	push   $0x1
801023fd:	e8 2d f4 ff ff       	call   8010182f <iget>
80102402:	83 c4 10             	add    $0x10,%esp
80102405:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102408:	e9 bb 00 00 00       	jmp    801024c8 <namex+0xe2>
  else
    ip = idup(proc->cwd);
8010240d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80102413:	8b 40 68             	mov    0x68(%eax),%eax
80102416:	83 ec 0c             	sub    $0xc,%esp
80102419:	50                   	push   %eax
8010241a:	e8 ef f4 ff ff       	call   8010190e <idup>
8010241f:	83 c4 10             	add    $0x10,%esp
80102422:	89 45 f4             	mov    %eax,-0xc(%ebp)

  while((path = skipelem(path, name)) != 0){
80102425:	e9 9e 00 00 00       	jmp    801024c8 <namex+0xe2>
    ilock(ip);
8010242a:	83 ec 0c             	sub    $0xc,%esp
8010242d:	ff 75 f4             	pushl  -0xc(%ebp)
80102430:	e8 13 f5 ff ff       	call   80101948 <ilock>
80102435:	83 c4 10             	add    $0x10,%esp
    if(ip->type != T_DIR){
80102438:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010243b:	0f b7 40 10          	movzwl 0x10(%eax),%eax
8010243f:	66 83 f8 01          	cmp    $0x1,%ax
80102443:	74 18                	je     8010245d <namex+0x77>
      iunlockput(ip);
80102445:	83 ec 0c             	sub    $0xc,%esp
80102448:	ff 75 f4             	pushl  -0xc(%ebp)
8010244b:	e8 b8 f7 ff ff       	call   80101c08 <iunlockput>
80102450:	83 c4 10             	add    $0x10,%esp
      return 0;
80102453:	b8 00 00 00 00       	mov    $0x0,%eax
80102458:	e9 a7 00 00 00       	jmp    80102504 <namex+0x11e>
    }
    if(nameiparent && *path == '\0'){
8010245d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80102461:	74 20                	je     80102483 <namex+0x9d>
80102463:	8b 45 08             	mov    0x8(%ebp),%eax
80102466:	0f b6 00             	movzbl (%eax),%eax
80102469:	84 c0                	test   %al,%al
8010246b:	75 16                	jne    80102483 <namex+0x9d>
      // Stop one level early.
      iunlock(ip);
8010246d:	83 ec 0c             	sub    $0xc,%esp
80102470:	ff 75 f4             	pushl  -0xc(%ebp)
80102473:	e8 2e f6 ff ff       	call   80101aa6 <iunlock>
80102478:	83 c4 10             	add    $0x10,%esp
      return ip;
8010247b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010247e:	e9 81 00 00 00       	jmp    80102504 <namex+0x11e>
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80102483:	83 ec 04             	sub    $0x4,%esp
80102486:	6a 00                	push   $0x0
80102488:	ff 75 10             	pushl  0x10(%ebp)
8010248b:	ff 75 f4             	pushl  -0xc(%ebp)
8010248e:	e8 1d fd ff ff       	call   801021b0 <dirlookup>
80102493:	83 c4 10             	add    $0x10,%esp
80102496:	89 45 f0             	mov    %eax,-0x10(%ebp)
80102499:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010249d:	75 15                	jne    801024b4 <namex+0xce>
      iunlockput(ip);
8010249f:	83 ec 0c             	sub    $0xc,%esp
801024a2:	ff 75 f4             	pushl  -0xc(%ebp)
801024a5:	e8 5e f7 ff ff       	call   80101c08 <iunlockput>
801024aa:	83 c4 10             	add    $0x10,%esp
      return 0;
801024ad:	b8 00 00 00 00       	mov    $0x0,%eax
801024b2:	eb 50                	jmp    80102504 <namex+0x11e>
    }
    iunlockput(ip);
801024b4:	83 ec 0c             	sub    $0xc,%esp
801024b7:	ff 75 f4             	pushl  -0xc(%ebp)
801024ba:	e8 49 f7 ff ff       	call   80101c08 <iunlockput>
801024bf:	83 c4 10             	add    $0x10,%esp
    ip = next;
801024c2:	8b 45 f0             	mov    -0x10(%ebp),%eax
801024c5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(proc->cwd);

  while((path = skipelem(path, name)) != 0){
801024c8:	83 ec 08             	sub    $0x8,%esp
801024cb:	ff 75 10             	pushl  0x10(%ebp)
801024ce:	ff 75 08             	pushl  0x8(%ebp)
801024d1:	e8 6c fe ff ff       	call   80102342 <skipelem>
801024d6:	83 c4 10             	add    $0x10,%esp
801024d9:	89 45 08             	mov    %eax,0x8(%ebp)
801024dc:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801024e0:	0f 85 44 ff ff ff    	jne    8010242a <namex+0x44>
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
801024e6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
801024ea:	74 15                	je     80102501 <namex+0x11b>
    iput(ip);
801024ec:	83 ec 0c             	sub    $0xc,%esp
801024ef:	ff 75 f4             	pushl  -0xc(%ebp)
801024f2:	e8 21 f6 ff ff       	call   80101b18 <iput>
801024f7:	83 c4 10             	add    $0x10,%esp
    return 0;
801024fa:	b8 00 00 00 00       	mov    $0x0,%eax
801024ff:	eb 03                	jmp    80102504 <namex+0x11e>
  }
  return ip;
80102501:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80102504:	c9                   	leave  
80102505:	c3                   	ret    

80102506 <namei>:

struct inode*
namei(char *path)
{
80102506:	55                   	push   %ebp
80102507:	89 e5                	mov    %esp,%ebp
80102509:	83 ec 18             	sub    $0x18,%esp
  char name[DIRSIZ];
  return namex(path, 0, name);
8010250c:	83 ec 04             	sub    $0x4,%esp
8010250f:	8d 45 ea             	lea    -0x16(%ebp),%eax
80102512:	50                   	push   %eax
80102513:	6a 00                	push   $0x0
80102515:	ff 75 08             	pushl  0x8(%ebp)
80102518:	e8 c9 fe ff ff       	call   801023e6 <namex>
8010251d:	83 c4 10             	add    $0x10,%esp
}
80102520:	c9                   	leave  
80102521:	c3                   	ret    

80102522 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80102522:	55                   	push   %ebp
80102523:	89 e5                	mov    %esp,%ebp
80102525:	83 ec 08             	sub    $0x8,%esp
  return namex(path, 1, name);
80102528:	83 ec 04             	sub    $0x4,%esp
8010252b:	ff 75 0c             	pushl  0xc(%ebp)
8010252e:	6a 01                	push   $0x1
80102530:	ff 75 08             	pushl  0x8(%ebp)
80102533:	e8 ae fe ff ff       	call   801023e6 <namex>
80102538:	83 c4 10             	add    $0x10,%esp
}
8010253b:	c9                   	leave  
8010253c:	c3                   	ret    

8010253d <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
8010253d:	55                   	push   %ebp
8010253e:	89 e5                	mov    %esp,%ebp
80102540:	83 ec 14             	sub    $0x14,%esp
80102543:	8b 45 08             	mov    0x8(%ebp),%eax
80102546:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010254a:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
8010254e:	89 c2                	mov    %eax,%edx
80102550:	ec                   	in     (%dx),%al
80102551:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80102554:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80102558:	c9                   	leave  
80102559:	c3                   	ret    

8010255a <insl>:

static inline void
insl(int port, void *addr, int cnt)
{
8010255a:	55                   	push   %ebp
8010255b:	89 e5                	mov    %esp,%ebp
8010255d:	57                   	push   %edi
8010255e:	53                   	push   %ebx
  asm volatile("cld; rep insl" :
8010255f:	8b 55 08             	mov    0x8(%ebp),%edx
80102562:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102565:	8b 45 10             	mov    0x10(%ebp),%eax
80102568:	89 cb                	mov    %ecx,%ebx
8010256a:	89 df                	mov    %ebx,%edi
8010256c:	89 c1                	mov    %eax,%ecx
8010256e:	fc                   	cld    
8010256f:	f3 6d                	rep insl (%dx),%es:(%edi)
80102571:	89 c8                	mov    %ecx,%eax
80102573:	89 fb                	mov    %edi,%ebx
80102575:	89 5d 0c             	mov    %ebx,0xc(%ebp)
80102578:	89 45 10             	mov    %eax,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "d" (port), "0" (addr), "1" (cnt) :
               "memory", "cc");
}
8010257b:	90                   	nop
8010257c:	5b                   	pop    %ebx
8010257d:	5f                   	pop    %edi
8010257e:	5d                   	pop    %ebp
8010257f:	c3                   	ret    

80102580 <outb>:

static inline void
outb(ushort port, uchar data)
{
80102580:	55                   	push   %ebp
80102581:	89 e5                	mov    %esp,%ebp
80102583:	83 ec 08             	sub    $0x8,%esp
80102586:	8b 55 08             	mov    0x8(%ebp),%edx
80102589:	8b 45 0c             	mov    0xc(%ebp),%eax
8010258c:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80102590:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102593:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80102597:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
8010259b:	ee                   	out    %al,(%dx)
}
8010259c:	90                   	nop
8010259d:	c9                   	leave  
8010259e:	c3                   	ret    

8010259f <outsl>:
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
}

static inline void
outsl(int port, const void *addr, int cnt)
{
8010259f:	55                   	push   %ebp
801025a0:	89 e5                	mov    %esp,%ebp
801025a2:	56                   	push   %esi
801025a3:	53                   	push   %ebx
  asm volatile("cld; rep outsl" :
801025a4:	8b 55 08             	mov    0x8(%ebp),%edx
801025a7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801025aa:	8b 45 10             	mov    0x10(%ebp),%eax
801025ad:	89 cb                	mov    %ecx,%ebx
801025af:	89 de                	mov    %ebx,%esi
801025b1:	89 c1                	mov    %eax,%ecx
801025b3:	fc                   	cld    
801025b4:	f3 6f                	rep outsl %ds:(%esi),(%dx)
801025b6:	89 c8                	mov    %ecx,%eax
801025b8:	89 f3                	mov    %esi,%ebx
801025ba:	89 5d 0c             	mov    %ebx,0xc(%ebp)
801025bd:	89 45 10             	mov    %eax,0x10(%ebp)
               "=S" (addr), "=c" (cnt) :
               "d" (port), "0" (addr), "1" (cnt) :
               "cc");
}
801025c0:	90                   	nop
801025c1:	5b                   	pop    %ebx
801025c2:	5e                   	pop    %esi
801025c3:	5d                   	pop    %ebp
801025c4:	c3                   	ret    

801025c5 <idewait>:
static void idestart(struct buf*);

// Wait for IDE disk to become ready.
static int
idewait(int checkerr)
{
801025c5:	55                   	push   %ebp
801025c6:	89 e5                	mov    %esp,%ebp
801025c8:	83 ec 10             	sub    $0x10,%esp
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY) 
801025cb:	90                   	nop
801025cc:	68 f7 01 00 00       	push   $0x1f7
801025d1:	e8 67 ff ff ff       	call   8010253d <inb>
801025d6:	83 c4 04             	add    $0x4,%esp
801025d9:	0f b6 c0             	movzbl %al,%eax
801025dc:	89 45 fc             	mov    %eax,-0x4(%ebp)
801025df:	8b 45 fc             	mov    -0x4(%ebp),%eax
801025e2:	25 c0 00 00 00       	and    $0xc0,%eax
801025e7:	83 f8 40             	cmp    $0x40,%eax
801025ea:	75 e0                	jne    801025cc <idewait+0x7>
    ;
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
801025ec:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801025f0:	74 11                	je     80102603 <idewait+0x3e>
801025f2:	8b 45 fc             	mov    -0x4(%ebp),%eax
801025f5:	83 e0 21             	and    $0x21,%eax
801025f8:	85 c0                	test   %eax,%eax
801025fa:	74 07                	je     80102603 <idewait+0x3e>
    return -1;
801025fc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102601:	eb 05                	jmp    80102608 <idewait+0x43>
  return 0;
80102603:	b8 00 00 00 00       	mov    $0x0,%eax
}
80102608:	c9                   	leave  
80102609:	c3                   	ret    

8010260a <ideinit>:

void
ideinit(void)
{
8010260a:	55                   	push   %ebp
8010260b:	89 e5                	mov    %esp,%ebp
8010260d:	83 ec 18             	sub    $0x18,%esp
  int i;
  
  initlock(&idelock, "ide");
80102610:	83 ec 08             	sub    $0x8,%esp
80102613:	68 2e 8a 10 80       	push   $0x80108a2e
80102618:	68 20 c6 10 80       	push   $0x8010c620
8010261d:	e8 18 2d 00 00       	call   8010533a <initlock>
80102622:	83 c4 10             	add    $0x10,%esp
  picenable(IRQ_IDE);
80102625:	83 ec 0c             	sub    $0xc,%esp
80102628:	6a 0e                	push   $0xe
8010262a:	e8 bf 18 00 00       	call   80103eee <picenable>
8010262f:	83 c4 10             	add    $0x10,%esp
  ioapicenable(IRQ_IDE, ncpu - 1);
80102632:	a1 e0 3d 11 80       	mov    0x80113de0,%eax
80102637:	83 e8 01             	sub    $0x1,%eax
8010263a:	83 ec 08             	sub    $0x8,%esp
8010263d:	50                   	push   %eax
8010263e:	6a 0e                	push   $0xe
80102640:	e8 70 04 00 00       	call   80102ab5 <ioapicenable>
80102645:	83 c4 10             	add    $0x10,%esp
  idewait(0);
80102648:	83 ec 0c             	sub    $0xc,%esp
8010264b:	6a 00                	push   $0x0
8010264d:	e8 73 ff ff ff       	call   801025c5 <idewait>
80102652:	83 c4 10             	add    $0x10,%esp
  
  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
80102655:	83 ec 08             	sub    $0x8,%esp
80102658:	68 f0 00 00 00       	push   $0xf0
8010265d:	68 f6 01 00 00       	push   $0x1f6
80102662:	e8 19 ff ff ff       	call   80102580 <outb>
80102667:	83 c4 10             	add    $0x10,%esp
  for(i=0; i<1000; i++){
8010266a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80102671:	eb 24                	jmp    80102697 <ideinit+0x8d>
    if(inb(0x1f7) != 0){
80102673:	83 ec 0c             	sub    $0xc,%esp
80102676:	68 f7 01 00 00       	push   $0x1f7
8010267b:	e8 bd fe ff ff       	call   8010253d <inb>
80102680:	83 c4 10             	add    $0x10,%esp
80102683:	84 c0                	test   %al,%al
80102685:	74 0c                	je     80102693 <ideinit+0x89>
      havedisk1 = 1;
80102687:	c7 05 58 c6 10 80 01 	movl   $0x1,0x8010c658
8010268e:	00 00 00 
      break;
80102691:	eb 0d                	jmp    801026a0 <ideinit+0x96>
  ioapicenable(IRQ_IDE, ncpu - 1);
  idewait(0);
  
  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
  for(i=0; i<1000; i++){
80102693:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80102697:	81 7d f4 e7 03 00 00 	cmpl   $0x3e7,-0xc(%ebp)
8010269e:	7e d3                	jle    80102673 <ideinit+0x69>
      break;
    }
  }
  
  // Switch back to disk 0.
  outb(0x1f6, 0xe0 | (0<<4));
801026a0:	83 ec 08             	sub    $0x8,%esp
801026a3:	68 e0 00 00 00       	push   $0xe0
801026a8:	68 f6 01 00 00       	push   $0x1f6
801026ad:	e8 ce fe ff ff       	call   80102580 <outb>
801026b2:	83 c4 10             	add    $0x10,%esp
}
801026b5:	90                   	nop
801026b6:	c9                   	leave  
801026b7:	c3                   	ret    

801026b8 <idestart>:

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
801026b8:	55                   	push   %ebp
801026b9:	89 e5                	mov    %esp,%ebp
801026bb:	83 ec 18             	sub    $0x18,%esp
  if(b == 0)
801026be:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801026c2:	75 0d                	jne    801026d1 <idestart+0x19>
    panic("idestart");
801026c4:	83 ec 0c             	sub    $0xc,%esp
801026c7:	68 32 8a 10 80       	push   $0x80108a32
801026cc:	e8 91 de ff ff       	call   80100562 <panic>
  if(b->blockno >= FSSIZE)
801026d1:	8b 45 08             	mov    0x8(%ebp),%eax
801026d4:	8b 40 08             	mov    0x8(%eax),%eax
801026d7:	3d e7 03 00 00       	cmp    $0x3e7,%eax
801026dc:	76 0d                	jbe    801026eb <idestart+0x33>
    panic("incorrect blockno");
801026de:	83 ec 0c             	sub    $0xc,%esp
801026e1:	68 3b 8a 10 80       	push   $0x80108a3b
801026e6:	e8 77 de ff ff       	call   80100562 <panic>
  int sector_per_block =  BSIZE/SECTOR_SIZE;
801026eb:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
  int sector = b->blockno * sector_per_block;
801026f2:	8b 45 08             	mov    0x8(%ebp),%eax
801026f5:	8b 50 08             	mov    0x8(%eax),%edx
801026f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801026fb:	0f af c2             	imul   %edx,%eax
801026fe:	89 45 f0             	mov    %eax,-0x10(%ebp)

  if (sector_per_block > 7) panic("idestart");
80102701:	83 7d f4 07          	cmpl   $0x7,-0xc(%ebp)
80102705:	7e 0d                	jle    80102714 <idestart+0x5c>
80102707:	83 ec 0c             	sub    $0xc,%esp
8010270a:	68 32 8a 10 80       	push   $0x80108a32
8010270f:	e8 4e de ff ff       	call   80100562 <panic>
  
  idewait(0);
80102714:	83 ec 0c             	sub    $0xc,%esp
80102717:	6a 00                	push   $0x0
80102719:	e8 a7 fe ff ff       	call   801025c5 <idewait>
8010271e:	83 c4 10             	add    $0x10,%esp
  outb(0x3f6, 0);  // generate interrupt
80102721:	83 ec 08             	sub    $0x8,%esp
80102724:	6a 00                	push   $0x0
80102726:	68 f6 03 00 00       	push   $0x3f6
8010272b:	e8 50 fe ff ff       	call   80102580 <outb>
80102730:	83 c4 10             	add    $0x10,%esp
  outb(0x1f2, sector_per_block);  // number of sectors
80102733:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102736:	0f b6 c0             	movzbl %al,%eax
80102739:	83 ec 08             	sub    $0x8,%esp
8010273c:	50                   	push   %eax
8010273d:	68 f2 01 00 00       	push   $0x1f2
80102742:	e8 39 fe ff ff       	call   80102580 <outb>
80102747:	83 c4 10             	add    $0x10,%esp
  outb(0x1f3, sector & 0xff);
8010274a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010274d:	0f b6 c0             	movzbl %al,%eax
80102750:	83 ec 08             	sub    $0x8,%esp
80102753:	50                   	push   %eax
80102754:	68 f3 01 00 00       	push   $0x1f3
80102759:	e8 22 fe ff ff       	call   80102580 <outb>
8010275e:	83 c4 10             	add    $0x10,%esp
  outb(0x1f4, (sector >> 8) & 0xff);
80102761:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102764:	c1 f8 08             	sar    $0x8,%eax
80102767:	0f b6 c0             	movzbl %al,%eax
8010276a:	83 ec 08             	sub    $0x8,%esp
8010276d:	50                   	push   %eax
8010276e:	68 f4 01 00 00       	push   $0x1f4
80102773:	e8 08 fe ff ff       	call   80102580 <outb>
80102778:	83 c4 10             	add    $0x10,%esp
  outb(0x1f5, (sector >> 16) & 0xff);
8010277b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010277e:	c1 f8 10             	sar    $0x10,%eax
80102781:	0f b6 c0             	movzbl %al,%eax
80102784:	83 ec 08             	sub    $0x8,%esp
80102787:	50                   	push   %eax
80102788:	68 f5 01 00 00       	push   $0x1f5
8010278d:	e8 ee fd ff ff       	call   80102580 <outb>
80102792:	83 c4 10             	add    $0x10,%esp
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
80102795:	8b 45 08             	mov    0x8(%ebp),%eax
80102798:	8b 40 04             	mov    0x4(%eax),%eax
8010279b:	83 e0 01             	and    $0x1,%eax
8010279e:	c1 e0 04             	shl    $0x4,%eax
801027a1:	89 c2                	mov    %eax,%edx
801027a3:	8b 45 f0             	mov    -0x10(%ebp),%eax
801027a6:	c1 f8 18             	sar    $0x18,%eax
801027a9:	83 e0 0f             	and    $0xf,%eax
801027ac:	09 d0                	or     %edx,%eax
801027ae:	83 c8 e0             	or     $0xffffffe0,%eax
801027b1:	0f b6 c0             	movzbl %al,%eax
801027b4:	83 ec 08             	sub    $0x8,%esp
801027b7:	50                   	push   %eax
801027b8:	68 f6 01 00 00       	push   $0x1f6
801027bd:	e8 be fd ff ff       	call   80102580 <outb>
801027c2:	83 c4 10             	add    $0x10,%esp
  if(b->flags & B_DIRTY){
801027c5:	8b 45 08             	mov    0x8(%ebp),%eax
801027c8:	8b 00                	mov    (%eax),%eax
801027ca:	83 e0 04             	and    $0x4,%eax
801027cd:	85 c0                	test   %eax,%eax
801027cf:	74 30                	je     80102801 <idestart+0x149>
    outb(0x1f7, IDE_CMD_WRITE);
801027d1:	83 ec 08             	sub    $0x8,%esp
801027d4:	6a 30                	push   $0x30
801027d6:	68 f7 01 00 00       	push   $0x1f7
801027db:	e8 a0 fd ff ff       	call   80102580 <outb>
801027e0:	83 c4 10             	add    $0x10,%esp
    outsl(0x1f0, b->data, BSIZE/4);
801027e3:	8b 45 08             	mov    0x8(%ebp),%eax
801027e6:	83 c0 18             	add    $0x18,%eax
801027e9:	83 ec 04             	sub    $0x4,%esp
801027ec:	68 80 00 00 00       	push   $0x80
801027f1:	50                   	push   %eax
801027f2:	68 f0 01 00 00       	push   $0x1f0
801027f7:	e8 a3 fd ff ff       	call   8010259f <outsl>
801027fc:	83 c4 10             	add    $0x10,%esp
  } else {
    outb(0x1f7, IDE_CMD_READ);
  }
}
801027ff:	eb 12                	jmp    80102813 <idestart+0x15b>
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
  if(b->flags & B_DIRTY){
    outb(0x1f7, IDE_CMD_WRITE);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, IDE_CMD_READ);
80102801:	83 ec 08             	sub    $0x8,%esp
80102804:	6a 20                	push   $0x20
80102806:	68 f7 01 00 00       	push   $0x1f7
8010280b:	e8 70 fd ff ff       	call   80102580 <outb>
80102810:	83 c4 10             	add    $0x10,%esp
  }
}
80102813:	90                   	nop
80102814:	c9                   	leave  
80102815:	c3                   	ret    

80102816 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102816:	55                   	push   %ebp
80102817:	89 e5                	mov    %esp,%ebp
80102819:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
8010281c:	83 ec 0c             	sub    $0xc,%esp
8010281f:	68 20 c6 10 80       	push   $0x8010c620
80102824:	e8 33 2b 00 00       	call   8010535c <acquire>
80102829:	83 c4 10             	add    $0x10,%esp
  if((b = idequeue) == 0){
8010282c:	a1 54 c6 10 80       	mov    0x8010c654,%eax
80102831:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102834:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80102838:	75 15                	jne    8010284f <ideintr+0x39>
    release(&idelock);
8010283a:	83 ec 0c             	sub    $0xc,%esp
8010283d:	68 20 c6 10 80       	push   $0x8010c620
80102842:	e8 7c 2b 00 00       	call   801053c3 <release>
80102847:	83 c4 10             	add    $0x10,%esp
    // cprintf("spurious IDE interrupt\n");
    return;
8010284a:	e9 9a 00 00 00       	jmp    801028e9 <ideintr+0xd3>
  }
  idequeue = b->qnext;
8010284f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102852:	8b 40 14             	mov    0x14(%eax),%eax
80102855:	a3 54 c6 10 80       	mov    %eax,0x8010c654

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
8010285a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010285d:	8b 00                	mov    (%eax),%eax
8010285f:	83 e0 04             	and    $0x4,%eax
80102862:	85 c0                	test   %eax,%eax
80102864:	75 2d                	jne    80102893 <ideintr+0x7d>
80102866:	83 ec 0c             	sub    $0xc,%esp
80102869:	6a 01                	push   $0x1
8010286b:	e8 55 fd ff ff       	call   801025c5 <idewait>
80102870:	83 c4 10             	add    $0x10,%esp
80102873:	85 c0                	test   %eax,%eax
80102875:	78 1c                	js     80102893 <ideintr+0x7d>
    insl(0x1f0, b->data, BSIZE/4);
80102877:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010287a:	83 c0 18             	add    $0x18,%eax
8010287d:	83 ec 04             	sub    $0x4,%esp
80102880:	68 80 00 00 00       	push   $0x80
80102885:	50                   	push   %eax
80102886:	68 f0 01 00 00       	push   $0x1f0
8010288b:	e8 ca fc ff ff       	call   8010255a <insl>
80102890:	83 c4 10             	add    $0x10,%esp
  
  // Wake process waiting for this buf.
  b->flags |= B_VALID;
80102893:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102896:	8b 00                	mov    (%eax),%eax
80102898:	83 c8 02             	or     $0x2,%eax
8010289b:	89 c2                	mov    %eax,%edx
8010289d:	8b 45 f4             	mov    -0xc(%ebp),%eax
801028a0:	89 10                	mov    %edx,(%eax)
  b->flags &= ~B_DIRTY;
801028a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801028a5:	8b 00                	mov    (%eax),%eax
801028a7:	83 e0 fb             	and    $0xfffffffb,%eax
801028aa:	89 c2                	mov    %eax,%edx
801028ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
801028af:	89 10                	mov    %edx,(%eax)
  wakeup(b);
801028b1:	83 ec 0c             	sub    $0xc,%esp
801028b4:	ff 75 f4             	pushl  -0xc(%ebp)
801028b7:	e8 5d 28 00 00       	call   80105119 <wakeup>
801028bc:	83 c4 10             	add    $0x10,%esp
  
  // Start disk on next buf in queue.
  if(idequeue != 0)
801028bf:	a1 54 c6 10 80       	mov    0x8010c654,%eax
801028c4:	85 c0                	test   %eax,%eax
801028c6:	74 11                	je     801028d9 <ideintr+0xc3>
    idestart(idequeue);
801028c8:	a1 54 c6 10 80       	mov    0x8010c654,%eax
801028cd:	83 ec 0c             	sub    $0xc,%esp
801028d0:	50                   	push   %eax
801028d1:	e8 e2 fd ff ff       	call   801026b8 <idestart>
801028d6:	83 c4 10             	add    $0x10,%esp

  release(&idelock);
801028d9:	83 ec 0c             	sub    $0xc,%esp
801028dc:	68 20 c6 10 80       	push   $0x8010c620
801028e1:	e8 dd 2a 00 00       	call   801053c3 <release>
801028e6:	83 c4 10             	add    $0x10,%esp
}
801028e9:	c9                   	leave  
801028ea:	c3                   	ret    

801028eb <iderw>:
// Sync buf with disk. 
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
801028eb:	55                   	push   %ebp
801028ec:	89 e5                	mov    %esp,%ebp
801028ee:	83 ec 18             	sub    $0x18,%esp
  struct buf **pp;

  if(!(b->flags & B_BUSY))
801028f1:	8b 45 08             	mov    0x8(%ebp),%eax
801028f4:	8b 00                	mov    (%eax),%eax
801028f6:	83 e0 01             	and    $0x1,%eax
801028f9:	85 c0                	test   %eax,%eax
801028fb:	75 0d                	jne    8010290a <iderw+0x1f>
    panic("iderw: buf not busy");
801028fd:	83 ec 0c             	sub    $0xc,%esp
80102900:	68 4d 8a 10 80       	push   $0x80108a4d
80102905:	e8 58 dc ff ff       	call   80100562 <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
8010290a:	8b 45 08             	mov    0x8(%ebp),%eax
8010290d:	8b 00                	mov    (%eax),%eax
8010290f:	83 e0 06             	and    $0x6,%eax
80102912:	83 f8 02             	cmp    $0x2,%eax
80102915:	75 0d                	jne    80102924 <iderw+0x39>
    panic("iderw: nothing to do");
80102917:	83 ec 0c             	sub    $0xc,%esp
8010291a:	68 61 8a 10 80       	push   $0x80108a61
8010291f:	e8 3e dc ff ff       	call   80100562 <panic>
  if(b->dev != 0 && !havedisk1)
80102924:	8b 45 08             	mov    0x8(%ebp),%eax
80102927:	8b 40 04             	mov    0x4(%eax),%eax
8010292a:	85 c0                	test   %eax,%eax
8010292c:	74 16                	je     80102944 <iderw+0x59>
8010292e:	a1 58 c6 10 80       	mov    0x8010c658,%eax
80102933:	85 c0                	test   %eax,%eax
80102935:	75 0d                	jne    80102944 <iderw+0x59>
    panic("iderw: ide disk 1 not present");
80102937:	83 ec 0c             	sub    $0xc,%esp
8010293a:	68 76 8a 10 80       	push   $0x80108a76
8010293f:	e8 1e dc ff ff       	call   80100562 <panic>

  acquire(&idelock);  //DOC:acquire-lock
80102944:	83 ec 0c             	sub    $0xc,%esp
80102947:	68 20 c6 10 80       	push   $0x8010c620
8010294c:	e8 0b 2a 00 00       	call   8010535c <acquire>
80102951:	83 c4 10             	add    $0x10,%esp

  // Append b to idequeue.
  b->qnext = 0;
80102954:	8b 45 08             	mov    0x8(%ebp),%eax
80102957:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010295e:	c7 45 f4 54 c6 10 80 	movl   $0x8010c654,-0xc(%ebp)
80102965:	eb 0b                	jmp    80102972 <iderw+0x87>
80102967:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010296a:	8b 00                	mov    (%eax),%eax
8010296c:	83 c0 14             	add    $0x14,%eax
8010296f:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102972:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102975:	8b 00                	mov    (%eax),%eax
80102977:	85 c0                	test   %eax,%eax
80102979:	75 ec                	jne    80102967 <iderw+0x7c>
    ;
  *pp = b;
8010297b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010297e:	8b 55 08             	mov    0x8(%ebp),%edx
80102981:	89 10                	mov    %edx,(%eax)
  
  // Start disk if necessary.
  if(idequeue == b)
80102983:	a1 54 c6 10 80       	mov    0x8010c654,%eax
80102988:	3b 45 08             	cmp    0x8(%ebp),%eax
8010298b:	75 23                	jne    801029b0 <iderw+0xc5>
    idestart(b);
8010298d:	83 ec 0c             	sub    $0xc,%esp
80102990:	ff 75 08             	pushl  0x8(%ebp)
80102993:	e8 20 fd ff ff       	call   801026b8 <idestart>
80102998:	83 c4 10             	add    $0x10,%esp
  
  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010299b:	eb 13                	jmp    801029b0 <iderw+0xc5>
    sleep(b, &idelock);
8010299d:	83 ec 08             	sub    $0x8,%esp
801029a0:	68 20 c6 10 80       	push   $0x8010c620
801029a5:	ff 75 08             	pushl  0x8(%ebp)
801029a8:	e8 70 26 00 00       	call   8010501d <sleep>
801029ad:	83 c4 10             	add    $0x10,%esp
  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);
  
  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801029b0:	8b 45 08             	mov    0x8(%ebp),%eax
801029b3:	8b 00                	mov    (%eax),%eax
801029b5:	83 e0 06             	and    $0x6,%eax
801029b8:	83 f8 02             	cmp    $0x2,%eax
801029bb:	75 e0                	jne    8010299d <iderw+0xb2>
    sleep(b, &idelock);
  }

  release(&idelock);
801029bd:	83 ec 0c             	sub    $0xc,%esp
801029c0:	68 20 c6 10 80       	push   $0x8010c620
801029c5:	e8 f9 29 00 00       	call   801053c3 <release>
801029ca:	83 c4 10             	add    $0x10,%esp
}
801029cd:	90                   	nop
801029ce:	c9                   	leave  
801029cf:	c3                   	ret    

801029d0 <ioapicread>:
801029d0:	55                   	push   %ebp
801029d1:	89 e5                	mov    %esp,%ebp
801029d3:	a1 94 36 11 80       	mov    0x80113694,%eax
801029d8:	8b 55 08             	mov    0x8(%ebp),%edx
801029db:	89 10                	mov    %edx,(%eax)
801029dd:	a1 94 36 11 80       	mov    0x80113694,%eax
801029e2:	8b 40 10             	mov    0x10(%eax),%eax
801029e5:	5d                   	pop    %ebp
801029e6:	c3                   	ret    

801029e7 <ioapicwrite>:
801029e7:	55                   	push   %ebp
801029e8:	89 e5                	mov    %esp,%ebp
801029ea:	a1 94 36 11 80       	mov    0x80113694,%eax
801029ef:	8b 55 08             	mov    0x8(%ebp),%edx
801029f2:	89 10                	mov    %edx,(%eax)
801029f4:	a1 94 36 11 80       	mov    0x80113694,%eax
801029f9:	8b 55 0c             	mov    0xc(%ebp),%edx
801029fc:	89 50 10             	mov    %edx,0x10(%eax)
801029ff:	5d                   	pop    %ebp
80102a00:	c3                   	ret    

80102a01 <ioapicinit>:
80102a01:	55                   	push   %ebp
80102a02:	89 e5                	mov    %esp,%ebp
80102a04:	83 ec 18             	sub    $0x18,%esp
80102a07:	a1 e4 37 11 80       	mov    0x801137e4,%eax
80102a0c:	85 c0                	test   %eax,%eax
80102a0e:	75 05                	jne    80102a15 <ioapicinit+0x14>
80102a10:	e9 9e 00 00 00       	jmp    80102ab3 <ioapicinit+0xb2>
80102a15:	c7 05 94 36 11 80 00 	movl   $0xfec00000,0x80113694
80102a1c:	00 c0 fe 
80102a1f:	6a 01                	push   $0x1
80102a21:	e8 aa ff ff ff       	call   801029d0 <ioapicread>
80102a26:	83 c4 04             	add    $0x4,%esp
80102a29:	c1 e8 10             	shr    $0x10,%eax
80102a2c:	25 ff 00 00 00       	and    $0xff,%eax
80102a31:	89 45 f0             	mov    %eax,-0x10(%ebp)
80102a34:	6a 00                	push   $0x0
80102a36:	e8 95 ff ff ff       	call   801029d0 <ioapicread>
80102a3b:	83 c4 04             	add    $0x4,%esp
80102a3e:	c1 e8 18             	shr    $0x18,%eax
80102a41:	89 45 ec             	mov    %eax,-0x14(%ebp)
80102a44:	0f b6 05 e0 37 11 80 	movzbl 0x801137e0,%eax
80102a4b:	0f b6 c0             	movzbl %al,%eax
80102a4e:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80102a51:	74 10                	je     80102a63 <ioapicinit+0x62>
80102a53:	83 ec 0c             	sub    $0xc,%esp
80102a56:	68 94 8a 10 80       	push   $0x80108a94
80102a5b:	e8 62 d9 ff ff       	call   801003c2 <cprintf>
80102a60:	83 c4 10             	add    $0x10,%esp
80102a63:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80102a6a:	eb 3f                	jmp    80102aab <ioapicinit+0xaa>
80102a6c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102a6f:	83 c0 20             	add    $0x20,%eax
80102a72:	0d 00 00 01 00       	or     $0x10000,%eax
80102a77:	89 c2                	mov    %eax,%edx
80102a79:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102a7c:	83 c0 08             	add    $0x8,%eax
80102a7f:	01 c0                	add    %eax,%eax
80102a81:	83 ec 08             	sub    $0x8,%esp
80102a84:	52                   	push   %edx
80102a85:	50                   	push   %eax
80102a86:	e8 5c ff ff ff       	call   801029e7 <ioapicwrite>
80102a8b:	83 c4 10             	add    $0x10,%esp
80102a8e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102a91:	83 c0 08             	add    $0x8,%eax
80102a94:	01 c0                	add    %eax,%eax
80102a96:	83 c0 01             	add    $0x1,%eax
80102a99:	83 ec 08             	sub    $0x8,%esp
80102a9c:	6a 00                	push   $0x0
80102a9e:	50                   	push   %eax
80102a9f:	e8 43 ff ff ff       	call   801029e7 <ioapicwrite>
80102aa4:	83 c4 10             	add    $0x10,%esp
80102aa7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80102aab:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102aae:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80102ab1:	7e b9                	jle    80102a6c <ioapicinit+0x6b>
80102ab3:	c9                   	leave  
80102ab4:	c3                   	ret    

80102ab5 <ioapicenable>:
80102ab5:	55                   	push   %ebp
80102ab6:	89 e5                	mov    %esp,%ebp
80102ab8:	a1 e4 37 11 80       	mov    0x801137e4,%eax
80102abd:	85 c0                	test   %eax,%eax
80102abf:	75 02                	jne    80102ac3 <ioapicenable+0xe>
80102ac1:	eb 37                	jmp    80102afa <ioapicenable+0x45>
80102ac3:	8b 45 08             	mov    0x8(%ebp),%eax
80102ac6:	83 c0 20             	add    $0x20,%eax
80102ac9:	89 c2                	mov    %eax,%edx
80102acb:	8b 45 08             	mov    0x8(%ebp),%eax
80102ace:	83 c0 08             	add    $0x8,%eax
80102ad1:	01 c0                	add    %eax,%eax
80102ad3:	52                   	push   %edx
80102ad4:	50                   	push   %eax
80102ad5:	e8 0d ff ff ff       	call   801029e7 <ioapicwrite>
80102ada:	83 c4 08             	add    $0x8,%esp
80102add:	8b 45 0c             	mov    0xc(%ebp),%eax
80102ae0:	c1 e0 18             	shl    $0x18,%eax
80102ae3:	89 c2                	mov    %eax,%edx
80102ae5:	8b 45 08             	mov    0x8(%ebp),%eax
80102ae8:	83 c0 08             	add    $0x8,%eax
80102aeb:	01 c0                	add    %eax,%eax
80102aed:	83 c0 01             	add    $0x1,%eax
80102af0:	52                   	push   %edx
80102af1:	50                   	push   %eax
80102af2:	e8 f0 fe ff ff       	call   801029e7 <ioapicwrite>
80102af7:	83 c4 08             	add    $0x8,%esp
80102afa:	c9                   	leave  
80102afb:	c3                   	ret    

80102afc <v2p>:
80102afc:	55                   	push   %ebp
80102afd:	89 e5                	mov    %esp,%ebp
80102aff:	8b 45 08             	mov    0x8(%ebp),%eax
80102b02:	05 00 00 00 80       	add    $0x80000000,%eax
80102b07:	5d                   	pop    %ebp
80102b08:	c3                   	ret    

80102b09 <kinit1>:
80102b09:	55                   	push   %ebp
80102b0a:	89 e5                	mov    %esp,%ebp
80102b0c:	83 ec 08             	sub    $0x8,%esp
80102b0f:	83 ec 08             	sub    $0x8,%esp
80102b12:	68 c6 8a 10 80       	push   $0x80108ac6
80102b17:	68 a0 36 11 80       	push   $0x801136a0
80102b1c:	e8 19 28 00 00       	call   8010533a <initlock>
80102b21:	83 c4 10             	add    $0x10,%esp
80102b24:	c7 05 d4 36 11 80 00 	movl   $0x0,0x801136d4
80102b2b:	00 00 00 
80102b2e:	83 ec 08             	sub    $0x8,%esp
80102b31:	ff 75 0c             	pushl  0xc(%ebp)
80102b34:	ff 75 08             	pushl  0x8(%ebp)
80102b37:	e8 28 00 00 00       	call   80102b64 <freerange>
80102b3c:	83 c4 10             	add    $0x10,%esp
80102b3f:	c9                   	leave  
80102b40:	c3                   	ret    

80102b41 <kinit2>:
80102b41:	55                   	push   %ebp
80102b42:	89 e5                	mov    %esp,%ebp
80102b44:	83 ec 08             	sub    $0x8,%esp
80102b47:	83 ec 08             	sub    $0x8,%esp
80102b4a:	ff 75 0c             	pushl  0xc(%ebp)
80102b4d:	ff 75 08             	pushl  0x8(%ebp)
80102b50:	e8 0f 00 00 00       	call   80102b64 <freerange>
80102b55:	83 c4 10             	add    $0x10,%esp
80102b58:	c7 05 d4 36 11 80 01 	movl   $0x1,0x801136d4
80102b5f:	00 00 00 
80102b62:	c9                   	leave  
80102b63:	c3                   	ret    

80102b64 <freerange>:
80102b64:	55                   	push   %ebp
80102b65:	89 e5                	mov    %esp,%ebp
80102b67:	83 ec 18             	sub    $0x18,%esp
80102b6a:	8b 45 08             	mov    0x8(%ebp),%eax
80102b6d:	05 ff 0f 00 00       	add    $0xfff,%eax
80102b72:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80102b77:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102b7a:	eb 15                	jmp    80102b91 <freerange+0x2d>
80102b7c:	83 ec 0c             	sub    $0xc,%esp
80102b7f:	ff 75 f4             	pushl  -0xc(%ebp)
80102b82:	e8 19 00 00 00       	call   80102ba0 <kfree>
80102b87:	83 c4 10             	add    $0x10,%esp
80102b8a:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80102b91:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102b94:	05 00 10 00 00       	add    $0x1000,%eax
80102b99:	3b 45 0c             	cmp    0xc(%ebp),%eax
80102b9c:	76 de                	jbe    80102b7c <freerange+0x18>
80102b9e:	c9                   	leave  
80102b9f:	c3                   	ret    

80102ba0 <kfree>:
80102ba0:	55                   	push   %ebp
80102ba1:	89 e5                	mov    %esp,%ebp
80102ba3:	83 ec 18             	sub    $0x18,%esp
80102ba6:	8b 45 08             	mov    0x8(%ebp),%eax
80102ba9:	25 ff 0f 00 00       	and    $0xfff,%eax
80102bae:	85 c0                	test   %eax,%eax
80102bb0:	75 1b                	jne    80102bcd <kfree+0x2d>
80102bb2:	81 7d 08 dc 67 11 80 	cmpl   $0x801167dc,0x8(%ebp)
80102bb9:	72 12                	jb     80102bcd <kfree+0x2d>
80102bbb:	ff 75 08             	pushl  0x8(%ebp)
80102bbe:	e8 39 ff ff ff       	call   80102afc <v2p>
80102bc3:	83 c4 04             	add    $0x4,%esp
80102bc6:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102bcb:	76 0d                	jbe    80102bda <kfree+0x3a>
80102bcd:	83 ec 0c             	sub    $0xc,%esp
80102bd0:	68 cb 8a 10 80       	push   $0x80108acb
80102bd5:	e8 88 d9 ff ff       	call   80100562 <panic>
80102bda:	83 ec 04             	sub    $0x4,%esp
80102bdd:	68 00 10 00 00       	push   $0x1000
80102be2:	6a 01                	push   $0x1
80102be4:	ff 75 08             	pushl  0x8(%ebp)
80102be7:	e8 d1 29 00 00       	call   801055bd <memset>
80102bec:	83 c4 10             	add    $0x10,%esp
80102bef:	a1 d4 36 11 80       	mov    0x801136d4,%eax
80102bf4:	85 c0                	test   %eax,%eax
80102bf6:	74 10                	je     80102c08 <kfree+0x68>
80102bf8:	83 ec 0c             	sub    $0xc,%esp
80102bfb:	68 a0 36 11 80       	push   $0x801136a0
80102c00:	e8 57 27 00 00       	call   8010535c <acquire>
80102c05:	83 c4 10             	add    $0x10,%esp
80102c08:	8b 45 08             	mov    0x8(%ebp),%eax
80102c0b:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102c0e:	8b 15 d8 36 11 80    	mov    0x801136d8,%edx
80102c14:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102c17:	89 10                	mov    %edx,(%eax)
80102c19:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102c1c:	a3 d8 36 11 80       	mov    %eax,0x801136d8
80102c21:	a1 d4 36 11 80       	mov    0x801136d4,%eax
80102c26:	85 c0                	test   %eax,%eax
80102c28:	74 10                	je     80102c3a <kfree+0x9a>
80102c2a:	83 ec 0c             	sub    $0xc,%esp
80102c2d:	68 a0 36 11 80       	push   $0x801136a0
80102c32:	e8 8c 27 00 00       	call   801053c3 <release>
80102c37:	83 c4 10             	add    $0x10,%esp
80102c3a:	c9                   	leave  
80102c3b:	c3                   	ret    

80102c3c <kalloc>:
80102c3c:	55                   	push   %ebp
80102c3d:	89 e5                	mov    %esp,%ebp
80102c3f:	83 ec 18             	sub    $0x18,%esp
80102c42:	a1 d4 36 11 80       	mov    0x801136d4,%eax
80102c47:	85 c0                	test   %eax,%eax
80102c49:	74 10                	je     80102c5b <kalloc+0x1f>
80102c4b:	83 ec 0c             	sub    $0xc,%esp
80102c4e:	68 a0 36 11 80       	push   $0x801136a0
80102c53:	e8 04 27 00 00       	call   8010535c <acquire>
80102c58:	83 c4 10             	add    $0x10,%esp
80102c5b:	a1 d8 36 11 80       	mov    0x801136d8,%eax
80102c60:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102c63:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80102c67:	74 0a                	je     80102c73 <kalloc+0x37>
80102c69:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102c6c:	8b 00                	mov    (%eax),%eax
80102c6e:	a3 d8 36 11 80       	mov    %eax,0x801136d8
80102c73:	a1 d4 36 11 80       	mov    0x801136d4,%eax
80102c78:	85 c0                	test   %eax,%eax
80102c7a:	74 10                	je     80102c8c <kalloc+0x50>
80102c7c:	83 ec 0c             	sub    $0xc,%esp
80102c7f:	68 a0 36 11 80       	push   $0x801136a0
80102c84:	e8 3a 27 00 00       	call   801053c3 <release>
80102c89:	83 c4 10             	add    $0x10,%esp
80102c8c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102c8f:	c9                   	leave  
80102c90:	c3                   	ret    

80102c91 <inb>:
80102c91:	55                   	push   %ebp
80102c92:	89 e5                	mov    %esp,%ebp
80102c94:	83 ec 14             	sub    $0x14,%esp
80102c97:	8b 45 08             	mov    0x8(%ebp),%eax
80102c9a:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
80102c9e:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80102ca2:	89 c2                	mov    %eax,%edx
80102ca4:	ec                   	in     (%dx),%al
80102ca5:	88 45 ff             	mov    %al,-0x1(%ebp)
80102ca8:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
80102cac:	c9                   	leave  
80102cad:	c3                   	ret    

80102cae <kbdgetc>:
80102cae:	55                   	push   %ebp
80102caf:	89 e5                	mov    %esp,%ebp
80102cb1:	83 ec 10             	sub    $0x10,%esp
80102cb4:	6a 64                	push   $0x64
80102cb6:	e8 d6 ff ff ff       	call   80102c91 <inb>
80102cbb:	83 c4 04             	add    $0x4,%esp
80102cbe:	0f b6 c0             	movzbl %al,%eax
80102cc1:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102cc4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102cc7:	83 e0 01             	and    $0x1,%eax
80102cca:	85 c0                	test   %eax,%eax
80102ccc:	75 0a                	jne    80102cd8 <kbdgetc+0x2a>
80102cce:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102cd3:	e9 23 01 00 00       	jmp    80102dfb <kbdgetc+0x14d>
80102cd8:	6a 60                	push   $0x60
80102cda:	e8 b2 ff ff ff       	call   80102c91 <inb>
80102cdf:	83 c4 04             	add    $0x4,%esp
80102ce2:	0f b6 c0             	movzbl %al,%eax
80102ce5:	89 45 fc             	mov    %eax,-0x4(%ebp)
80102ce8:	81 7d fc e0 00 00 00 	cmpl   $0xe0,-0x4(%ebp)
80102cef:	75 17                	jne    80102d08 <kbdgetc+0x5a>
80102cf1:	a1 5c c6 10 80       	mov    0x8010c65c,%eax
80102cf6:	83 c8 40             	or     $0x40,%eax
80102cf9:	a3 5c c6 10 80       	mov    %eax,0x8010c65c
80102cfe:	b8 00 00 00 00       	mov    $0x0,%eax
80102d03:	e9 f3 00 00 00       	jmp    80102dfb <kbdgetc+0x14d>
80102d08:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102d0b:	25 80 00 00 00       	and    $0x80,%eax
80102d10:	85 c0                	test   %eax,%eax
80102d12:	74 45                	je     80102d59 <kbdgetc+0xab>
80102d14:	a1 5c c6 10 80       	mov    0x8010c65c,%eax
80102d19:	83 e0 40             	and    $0x40,%eax
80102d1c:	85 c0                	test   %eax,%eax
80102d1e:	75 08                	jne    80102d28 <kbdgetc+0x7a>
80102d20:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102d23:	83 e0 7f             	and    $0x7f,%eax
80102d26:	eb 03                	jmp    80102d2b <kbdgetc+0x7d>
80102d28:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102d2b:	89 45 fc             	mov    %eax,-0x4(%ebp)
80102d2e:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102d31:	05 40 a0 10 80       	add    $0x8010a040,%eax
80102d36:	0f b6 00             	movzbl (%eax),%eax
80102d39:	83 c8 40             	or     $0x40,%eax
80102d3c:	0f b6 c0             	movzbl %al,%eax
80102d3f:	f7 d0                	not    %eax
80102d41:	89 c2                	mov    %eax,%edx
80102d43:	a1 5c c6 10 80       	mov    0x8010c65c,%eax
80102d48:	21 d0                	and    %edx,%eax
80102d4a:	a3 5c c6 10 80       	mov    %eax,0x8010c65c
80102d4f:	b8 00 00 00 00       	mov    $0x0,%eax
80102d54:	e9 a2 00 00 00       	jmp    80102dfb <kbdgetc+0x14d>
80102d59:	a1 5c c6 10 80       	mov    0x8010c65c,%eax
80102d5e:	83 e0 40             	and    $0x40,%eax
80102d61:	85 c0                	test   %eax,%eax
80102d63:	74 14                	je     80102d79 <kbdgetc+0xcb>
80102d65:	81 4d fc 80 00 00 00 	orl    $0x80,-0x4(%ebp)
80102d6c:	a1 5c c6 10 80       	mov    0x8010c65c,%eax
80102d71:	83 e0 bf             	and    $0xffffffbf,%eax
80102d74:	a3 5c c6 10 80       	mov    %eax,0x8010c65c
80102d79:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102d7c:	05 40 a0 10 80       	add    $0x8010a040,%eax
80102d81:	0f b6 00             	movzbl (%eax),%eax
80102d84:	0f b6 d0             	movzbl %al,%edx
80102d87:	a1 5c c6 10 80       	mov    0x8010c65c,%eax
80102d8c:	09 d0                	or     %edx,%eax
80102d8e:	a3 5c c6 10 80       	mov    %eax,0x8010c65c
80102d93:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102d96:	05 40 a1 10 80       	add    $0x8010a140,%eax
80102d9b:	0f b6 00             	movzbl (%eax),%eax
80102d9e:	0f b6 d0             	movzbl %al,%edx
80102da1:	a1 5c c6 10 80       	mov    0x8010c65c,%eax
80102da6:	31 d0                	xor    %edx,%eax
80102da8:	a3 5c c6 10 80       	mov    %eax,0x8010c65c
80102dad:	a1 5c c6 10 80       	mov    0x8010c65c,%eax
80102db2:	83 e0 03             	and    $0x3,%eax
80102db5:	8b 14 85 40 a5 10 80 	mov    -0x7fef5ac0(,%eax,4),%edx
80102dbc:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102dbf:	01 d0                	add    %edx,%eax
80102dc1:	0f b6 00             	movzbl (%eax),%eax
80102dc4:	0f b6 c0             	movzbl %al,%eax
80102dc7:	89 45 f8             	mov    %eax,-0x8(%ebp)
80102dca:	a1 5c c6 10 80       	mov    0x8010c65c,%eax
80102dcf:	83 e0 08             	and    $0x8,%eax
80102dd2:	85 c0                	test   %eax,%eax
80102dd4:	74 22                	je     80102df8 <kbdgetc+0x14a>
80102dd6:	83 7d f8 60          	cmpl   $0x60,-0x8(%ebp)
80102dda:	76 0c                	jbe    80102de8 <kbdgetc+0x13a>
80102ddc:	83 7d f8 7a          	cmpl   $0x7a,-0x8(%ebp)
80102de0:	77 06                	ja     80102de8 <kbdgetc+0x13a>
80102de2:	83 6d f8 20          	subl   $0x20,-0x8(%ebp)
80102de6:	eb 10                	jmp    80102df8 <kbdgetc+0x14a>
80102de8:	83 7d f8 40          	cmpl   $0x40,-0x8(%ebp)
80102dec:	76 0a                	jbe    80102df8 <kbdgetc+0x14a>
80102dee:	83 7d f8 5a          	cmpl   $0x5a,-0x8(%ebp)
80102df2:	77 04                	ja     80102df8 <kbdgetc+0x14a>
80102df4:	83 45 f8 20          	addl   $0x20,-0x8(%ebp)
80102df8:	8b 45 f8             	mov    -0x8(%ebp),%eax
80102dfb:	c9                   	leave  
80102dfc:	c3                   	ret    

80102dfd <kbdintr>:
80102dfd:	55                   	push   %ebp
80102dfe:	89 e5                	mov    %esp,%ebp
80102e00:	83 ec 08             	sub    $0x8,%esp
80102e03:	83 ec 0c             	sub    $0xc,%esp
80102e06:	68 ae 2c 10 80       	push   $0x80102cae
80102e0b:	e8 c9 d9 ff ff       	call   801007d9 <consoleintr>
80102e10:	83 c4 10             	add    $0x10,%esp
80102e13:	c9                   	leave  
80102e14:	c3                   	ret    

80102e15 <inb>:
80102e15:	55                   	push   %ebp
80102e16:	89 e5                	mov    %esp,%ebp
80102e18:	83 ec 14             	sub    $0x14,%esp
80102e1b:	8b 45 08             	mov    0x8(%ebp),%eax
80102e1e:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
80102e22:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80102e26:	89 c2                	mov    %eax,%edx
80102e28:	ec                   	in     (%dx),%al
80102e29:	88 45 ff             	mov    %al,-0x1(%ebp)
80102e2c:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
80102e30:	c9                   	leave  
80102e31:	c3                   	ret    

80102e32 <outb>:
80102e32:	55                   	push   %ebp
80102e33:	89 e5                	mov    %esp,%ebp
80102e35:	83 ec 08             	sub    $0x8,%esp
80102e38:	8b 55 08             	mov    0x8(%ebp),%edx
80102e3b:	8b 45 0c             	mov    0xc(%ebp),%eax
80102e3e:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80102e42:	88 45 f8             	mov    %al,-0x8(%ebp)
80102e45:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80102e49:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80102e4d:	ee                   	out    %al,(%dx)
80102e4e:	c9                   	leave  
80102e4f:	c3                   	ret    

80102e50 <readeflags>:
80102e50:	55                   	push   %ebp
80102e51:	89 e5                	mov    %esp,%ebp
80102e53:	83 ec 10             	sub    $0x10,%esp
80102e56:	9c                   	pushf  
80102e57:	58                   	pop    %eax
80102e58:	89 45 fc             	mov    %eax,-0x4(%ebp)
80102e5b:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102e5e:	c9                   	leave  
80102e5f:	c3                   	ret    

80102e60 <lapicw>:
80102e60:	55                   	push   %ebp
80102e61:	89 e5                	mov    %esp,%ebp
80102e63:	a1 dc 36 11 80       	mov    0x801136dc,%eax
80102e68:	8b 55 08             	mov    0x8(%ebp),%edx
80102e6b:	c1 e2 02             	shl    $0x2,%edx
80102e6e:	01 c2                	add    %eax,%edx
80102e70:	8b 45 0c             	mov    0xc(%ebp),%eax
80102e73:	89 02                	mov    %eax,(%edx)
80102e75:	a1 dc 36 11 80       	mov    0x801136dc,%eax
80102e7a:	83 c0 20             	add    $0x20,%eax
80102e7d:	8b 00                	mov    (%eax),%eax
80102e7f:	5d                   	pop    %ebp
80102e80:	c3                   	ret    

80102e81 <lapicinit>:
80102e81:	55                   	push   %ebp
80102e82:	89 e5                	mov    %esp,%ebp
80102e84:	a1 dc 36 11 80       	mov    0x801136dc,%eax
80102e89:	85 c0                	test   %eax,%eax
80102e8b:	75 05                	jne    80102e92 <lapicinit+0x11>
80102e8d:	e9 09 01 00 00       	jmp    80102f9b <lapicinit+0x11a>
80102e92:	68 3f 01 00 00       	push   $0x13f
80102e97:	6a 3c                	push   $0x3c
80102e99:	e8 c2 ff ff ff       	call   80102e60 <lapicw>
80102e9e:	83 c4 08             	add    $0x8,%esp
80102ea1:	6a 0b                	push   $0xb
80102ea3:	68 f8 00 00 00       	push   $0xf8
80102ea8:	e8 b3 ff ff ff       	call   80102e60 <lapicw>
80102ead:	83 c4 08             	add    $0x8,%esp
80102eb0:	68 20 00 02 00       	push   $0x20020
80102eb5:	68 c8 00 00 00       	push   $0xc8
80102eba:	e8 a1 ff ff ff       	call   80102e60 <lapicw>
80102ebf:	83 c4 08             	add    $0x8,%esp
80102ec2:	68 80 96 98 00       	push   $0x989680
80102ec7:	68 e0 00 00 00       	push   $0xe0
80102ecc:	e8 8f ff ff ff       	call   80102e60 <lapicw>
80102ed1:	83 c4 08             	add    $0x8,%esp
80102ed4:	68 00 00 01 00       	push   $0x10000
80102ed9:	68 d4 00 00 00       	push   $0xd4
80102ede:	e8 7d ff ff ff       	call   80102e60 <lapicw>
80102ee3:	83 c4 08             	add    $0x8,%esp
80102ee6:	68 00 00 01 00       	push   $0x10000
80102eeb:	68 d8 00 00 00       	push   $0xd8
80102ef0:	e8 6b ff ff ff       	call   80102e60 <lapicw>
80102ef5:	83 c4 08             	add    $0x8,%esp
80102ef8:	a1 dc 36 11 80       	mov    0x801136dc,%eax
80102efd:	83 c0 30             	add    $0x30,%eax
80102f00:	8b 00                	mov    (%eax),%eax
80102f02:	c1 e8 10             	shr    $0x10,%eax
80102f05:	0f b6 c0             	movzbl %al,%eax
80102f08:	83 f8 03             	cmp    $0x3,%eax
80102f0b:	76 12                	jbe    80102f1f <lapicinit+0x9e>
80102f0d:	68 00 00 01 00       	push   $0x10000
80102f12:	68 d0 00 00 00       	push   $0xd0
80102f17:	e8 44 ff ff ff       	call   80102e60 <lapicw>
80102f1c:	83 c4 08             	add    $0x8,%esp
80102f1f:	6a 33                	push   $0x33
80102f21:	68 dc 00 00 00       	push   $0xdc
80102f26:	e8 35 ff ff ff       	call   80102e60 <lapicw>
80102f2b:	83 c4 08             	add    $0x8,%esp
80102f2e:	6a 00                	push   $0x0
80102f30:	68 a0 00 00 00       	push   $0xa0
80102f35:	e8 26 ff ff ff       	call   80102e60 <lapicw>
80102f3a:	83 c4 08             	add    $0x8,%esp
80102f3d:	6a 00                	push   $0x0
80102f3f:	68 a0 00 00 00       	push   $0xa0
80102f44:	e8 17 ff ff ff       	call   80102e60 <lapicw>
80102f49:	83 c4 08             	add    $0x8,%esp
80102f4c:	6a 00                	push   $0x0
80102f4e:	6a 2c                	push   $0x2c
80102f50:	e8 0b ff ff ff       	call   80102e60 <lapicw>
80102f55:	83 c4 08             	add    $0x8,%esp
80102f58:	6a 00                	push   $0x0
80102f5a:	68 c4 00 00 00       	push   $0xc4
80102f5f:	e8 fc fe ff ff       	call   80102e60 <lapicw>
80102f64:	83 c4 08             	add    $0x8,%esp
80102f67:	68 00 85 08 00       	push   $0x88500
80102f6c:	68 c0 00 00 00       	push   $0xc0
80102f71:	e8 ea fe ff ff       	call   80102e60 <lapicw>
80102f76:	83 c4 08             	add    $0x8,%esp
80102f79:	90                   	nop
80102f7a:	a1 dc 36 11 80       	mov    0x801136dc,%eax
80102f7f:	05 00 03 00 00       	add    $0x300,%eax
80102f84:	8b 00                	mov    (%eax),%eax
80102f86:	25 00 10 00 00       	and    $0x1000,%eax
80102f8b:	85 c0                	test   %eax,%eax
80102f8d:	75 eb                	jne    80102f7a <lapicinit+0xf9>
80102f8f:	6a 00                	push   $0x0
80102f91:	6a 20                	push   $0x20
80102f93:	e8 c8 fe ff ff       	call   80102e60 <lapicw>
80102f98:	83 c4 08             	add    $0x8,%esp
80102f9b:	c9                   	leave  
80102f9c:	c3                   	ret    

80102f9d <cpunum>:
80102f9d:	55                   	push   %ebp
80102f9e:	89 e5                	mov    %esp,%ebp
80102fa0:	83 ec 08             	sub    $0x8,%esp
80102fa3:	e8 a8 fe ff ff       	call   80102e50 <readeflags>
80102fa8:	25 00 02 00 00       	and    $0x200,%eax
80102fad:	85 c0                	test   %eax,%eax
80102faf:	74 26                	je     80102fd7 <cpunum+0x3a>
80102fb1:	a1 60 c6 10 80       	mov    0x8010c660,%eax
80102fb6:	8d 50 01             	lea    0x1(%eax),%edx
80102fb9:	89 15 60 c6 10 80    	mov    %edx,0x8010c660
80102fbf:	85 c0                	test   %eax,%eax
80102fc1:	75 14                	jne    80102fd7 <cpunum+0x3a>
80102fc3:	8b 45 04             	mov    0x4(%ebp),%eax
80102fc6:	83 ec 08             	sub    $0x8,%esp
80102fc9:	50                   	push   %eax
80102fca:	68 d4 8a 10 80       	push   $0x80108ad4
80102fcf:	e8 ee d3 ff ff       	call   801003c2 <cprintf>
80102fd4:	83 c4 10             	add    $0x10,%esp
80102fd7:	a1 dc 36 11 80       	mov    0x801136dc,%eax
80102fdc:	85 c0                	test   %eax,%eax
80102fde:	74 0f                	je     80102fef <cpunum+0x52>
80102fe0:	a1 dc 36 11 80       	mov    0x801136dc,%eax
80102fe5:	83 c0 20             	add    $0x20,%eax
80102fe8:	8b 00                	mov    (%eax),%eax
80102fea:	c1 e8 18             	shr    $0x18,%eax
80102fed:	eb 05                	jmp    80102ff4 <cpunum+0x57>
80102fef:	b8 00 00 00 00       	mov    $0x0,%eax
80102ff4:	c9                   	leave  
80102ff5:	c3                   	ret    

80102ff6 <lapiceoi>:
80102ff6:	55                   	push   %ebp
80102ff7:	89 e5                	mov    %esp,%ebp
80102ff9:	a1 dc 36 11 80       	mov    0x801136dc,%eax
80102ffe:	85 c0                	test   %eax,%eax
80103000:	74 0c                	je     8010300e <lapiceoi+0x18>
80103002:	6a 00                	push   $0x0
80103004:	6a 2c                	push   $0x2c
80103006:	e8 55 fe ff ff       	call   80102e60 <lapicw>
8010300b:	83 c4 08             	add    $0x8,%esp
8010300e:	c9                   	leave  
8010300f:	c3                   	ret    

80103010 <microdelay>:
80103010:	55                   	push   %ebp
80103011:	89 e5                	mov    %esp,%ebp
80103013:	5d                   	pop    %ebp
80103014:	c3                   	ret    

80103015 <lapicstartap>:
80103015:	55                   	push   %ebp
80103016:	89 e5                	mov    %esp,%ebp
80103018:	83 ec 14             	sub    $0x14,%esp
8010301b:	8b 45 08             	mov    0x8(%ebp),%eax
8010301e:	88 45 ec             	mov    %al,-0x14(%ebp)
80103021:	6a 0f                	push   $0xf
80103023:	6a 70                	push   $0x70
80103025:	e8 08 fe ff ff       	call   80102e32 <outb>
8010302a:	83 c4 08             	add    $0x8,%esp
8010302d:	6a 0a                	push   $0xa
8010302f:	6a 71                	push   $0x71
80103031:	e8 fc fd ff ff       	call   80102e32 <outb>
80103036:	83 c4 08             	add    $0x8,%esp
80103039:	c7 45 f8 67 04 00 80 	movl   $0x80000467,-0x8(%ebp)
80103040:	8b 45 f8             	mov    -0x8(%ebp),%eax
80103043:	66 c7 00 00 00       	movw   $0x0,(%eax)
80103048:	8b 45 f8             	mov    -0x8(%ebp),%eax
8010304b:	83 c0 02             	add    $0x2,%eax
8010304e:	8b 55 0c             	mov    0xc(%ebp),%edx
80103051:	c1 ea 04             	shr    $0x4,%edx
80103054:	66 89 10             	mov    %dx,(%eax)
80103057:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
8010305b:	c1 e0 18             	shl    $0x18,%eax
8010305e:	50                   	push   %eax
8010305f:	68 c4 00 00 00       	push   $0xc4
80103064:	e8 f7 fd ff ff       	call   80102e60 <lapicw>
80103069:	83 c4 08             	add    $0x8,%esp
8010306c:	68 00 c5 00 00       	push   $0xc500
80103071:	68 c0 00 00 00       	push   $0xc0
80103076:	e8 e5 fd ff ff       	call   80102e60 <lapicw>
8010307b:	83 c4 08             	add    $0x8,%esp
8010307e:	68 c8 00 00 00       	push   $0xc8
80103083:	e8 88 ff ff ff       	call   80103010 <microdelay>
80103088:	83 c4 04             	add    $0x4,%esp
8010308b:	68 00 85 00 00       	push   $0x8500
80103090:	68 c0 00 00 00       	push   $0xc0
80103095:	e8 c6 fd ff ff       	call   80102e60 <lapicw>
8010309a:	83 c4 08             	add    $0x8,%esp
8010309d:	6a 64                	push   $0x64
8010309f:	e8 6c ff ff ff       	call   80103010 <microdelay>
801030a4:	83 c4 04             	add    $0x4,%esp
801030a7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
801030ae:	eb 3d                	jmp    801030ed <lapicstartap+0xd8>
801030b0:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
801030b4:	c1 e0 18             	shl    $0x18,%eax
801030b7:	50                   	push   %eax
801030b8:	68 c4 00 00 00       	push   $0xc4
801030bd:	e8 9e fd ff ff       	call   80102e60 <lapicw>
801030c2:	83 c4 08             	add    $0x8,%esp
801030c5:	8b 45 0c             	mov    0xc(%ebp),%eax
801030c8:	c1 e8 0c             	shr    $0xc,%eax
801030cb:	80 cc 06             	or     $0x6,%ah
801030ce:	50                   	push   %eax
801030cf:	68 c0 00 00 00       	push   $0xc0
801030d4:	e8 87 fd ff ff       	call   80102e60 <lapicw>
801030d9:	83 c4 08             	add    $0x8,%esp
801030dc:	68 c8 00 00 00       	push   $0xc8
801030e1:	e8 2a ff ff ff       	call   80103010 <microdelay>
801030e6:	83 c4 04             	add    $0x4,%esp
801030e9:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
801030ed:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
801030f1:	7e bd                	jle    801030b0 <lapicstartap+0x9b>
801030f3:	c9                   	leave  
801030f4:	c3                   	ret    

801030f5 <cmos_read>:
801030f5:	55                   	push   %ebp
801030f6:	89 e5                	mov    %esp,%ebp
801030f8:	8b 45 08             	mov    0x8(%ebp),%eax
801030fb:	0f b6 c0             	movzbl %al,%eax
801030fe:	50                   	push   %eax
801030ff:	6a 70                	push   $0x70
80103101:	e8 2c fd ff ff       	call   80102e32 <outb>
80103106:	83 c4 08             	add    $0x8,%esp
80103109:	68 c8 00 00 00       	push   $0xc8
8010310e:	e8 fd fe ff ff       	call   80103010 <microdelay>
80103113:	83 c4 04             	add    $0x4,%esp
80103116:	6a 71                	push   $0x71
80103118:	e8 f8 fc ff ff       	call   80102e15 <inb>
8010311d:	83 c4 04             	add    $0x4,%esp
80103120:	0f b6 c0             	movzbl %al,%eax
80103123:	c9                   	leave  
80103124:	c3                   	ret    

80103125 <fill_rtcdate>:
80103125:	55                   	push   %ebp
80103126:	89 e5                	mov    %esp,%ebp
80103128:	6a 00                	push   $0x0
8010312a:	e8 c6 ff ff ff       	call   801030f5 <cmos_read>
8010312f:	83 c4 04             	add    $0x4,%esp
80103132:	89 c2                	mov    %eax,%edx
80103134:	8b 45 08             	mov    0x8(%ebp),%eax
80103137:	89 10                	mov    %edx,(%eax)
80103139:	6a 02                	push   $0x2
8010313b:	e8 b5 ff ff ff       	call   801030f5 <cmos_read>
80103140:	83 c4 04             	add    $0x4,%esp
80103143:	89 c2                	mov    %eax,%edx
80103145:	8b 45 08             	mov    0x8(%ebp),%eax
80103148:	89 50 04             	mov    %edx,0x4(%eax)
8010314b:	6a 04                	push   $0x4
8010314d:	e8 a3 ff ff ff       	call   801030f5 <cmos_read>
80103152:	83 c4 04             	add    $0x4,%esp
80103155:	89 c2                	mov    %eax,%edx
80103157:	8b 45 08             	mov    0x8(%ebp),%eax
8010315a:	89 50 08             	mov    %edx,0x8(%eax)
8010315d:	6a 07                	push   $0x7
8010315f:	e8 91 ff ff ff       	call   801030f5 <cmos_read>
80103164:	83 c4 04             	add    $0x4,%esp
80103167:	89 c2                	mov    %eax,%edx
80103169:	8b 45 08             	mov    0x8(%ebp),%eax
8010316c:	89 50 0c             	mov    %edx,0xc(%eax)
8010316f:	6a 08                	push   $0x8
80103171:	e8 7f ff ff ff       	call   801030f5 <cmos_read>
80103176:	83 c4 04             	add    $0x4,%esp
80103179:	89 c2                	mov    %eax,%edx
8010317b:	8b 45 08             	mov    0x8(%ebp),%eax
8010317e:	89 50 10             	mov    %edx,0x10(%eax)
80103181:	6a 09                	push   $0x9
80103183:	e8 6d ff ff ff       	call   801030f5 <cmos_read>
80103188:	83 c4 04             	add    $0x4,%esp
8010318b:	89 c2                	mov    %eax,%edx
8010318d:	8b 45 08             	mov    0x8(%ebp),%eax
80103190:	89 50 14             	mov    %edx,0x14(%eax)
80103193:	c9                   	leave  
80103194:	c3                   	ret    

80103195 <cmostime>:
80103195:	55                   	push   %ebp
80103196:	89 e5                	mov    %esp,%ebp
80103198:	83 ec 48             	sub    $0x48,%esp
8010319b:	6a 0b                	push   $0xb
8010319d:	e8 53 ff ff ff       	call   801030f5 <cmos_read>
801031a2:	83 c4 04             	add    $0x4,%esp
801031a5:	89 45 f4             	mov    %eax,-0xc(%ebp)
801031a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801031ab:	83 e0 04             	and    $0x4,%eax
801031ae:	85 c0                	test   %eax,%eax
801031b0:	0f 94 c0             	sete   %al
801031b3:	0f b6 c0             	movzbl %al,%eax
801031b6:	89 45 f0             	mov    %eax,-0x10(%ebp)
801031b9:	8d 45 d8             	lea    -0x28(%ebp),%eax
801031bc:	50                   	push   %eax
801031bd:	e8 63 ff ff ff       	call   80103125 <fill_rtcdate>
801031c2:	83 c4 04             	add    $0x4,%esp
801031c5:	6a 0a                	push   $0xa
801031c7:	e8 29 ff ff ff       	call   801030f5 <cmos_read>
801031cc:	83 c4 04             	add    $0x4,%esp
801031cf:	25 80 00 00 00       	and    $0x80,%eax
801031d4:	85 c0                	test   %eax,%eax
801031d6:	74 02                	je     801031da <cmostime+0x45>
801031d8:	eb 32                	jmp    8010320c <cmostime+0x77>
801031da:	8d 45 c0             	lea    -0x40(%ebp),%eax
801031dd:	50                   	push   %eax
801031de:	e8 42 ff ff ff       	call   80103125 <fill_rtcdate>
801031e3:	83 c4 04             	add    $0x4,%esp
801031e6:	83 ec 04             	sub    $0x4,%esp
801031e9:	6a 18                	push   $0x18
801031eb:	8d 45 c0             	lea    -0x40(%ebp),%eax
801031ee:	50                   	push   %eax
801031ef:	8d 45 d8             	lea    -0x28(%ebp),%eax
801031f2:	50                   	push   %eax
801031f3:	e8 2c 24 00 00       	call   80105624 <memcmp>
801031f8:	83 c4 10             	add    $0x10,%esp
801031fb:	85 c0                	test   %eax,%eax
801031fd:	75 0d                	jne    8010320c <cmostime+0x77>
801031ff:	90                   	nop
80103200:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80103204:	0f 84 b8 00 00 00    	je     801032c2 <cmostime+0x12d>
8010320a:	eb 02                	jmp    8010320e <cmostime+0x79>
8010320c:	eb ab                	jmp    801031b9 <cmostime+0x24>
8010320e:	8b 45 d8             	mov    -0x28(%ebp),%eax
80103211:	c1 e8 04             	shr    $0x4,%eax
80103214:	89 c2                	mov    %eax,%edx
80103216:	89 d0                	mov    %edx,%eax
80103218:	c1 e0 02             	shl    $0x2,%eax
8010321b:	01 d0                	add    %edx,%eax
8010321d:	01 c0                	add    %eax,%eax
8010321f:	89 c2                	mov    %eax,%edx
80103221:	8b 45 d8             	mov    -0x28(%ebp),%eax
80103224:	83 e0 0f             	and    $0xf,%eax
80103227:	01 d0                	add    %edx,%eax
80103229:	89 45 d8             	mov    %eax,-0x28(%ebp)
8010322c:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010322f:	c1 e8 04             	shr    $0x4,%eax
80103232:	89 c2                	mov    %eax,%edx
80103234:	89 d0                	mov    %edx,%eax
80103236:	c1 e0 02             	shl    $0x2,%eax
80103239:	01 d0                	add    %edx,%eax
8010323b:	01 c0                	add    %eax,%eax
8010323d:	89 c2                	mov    %eax,%edx
8010323f:	8b 45 dc             	mov    -0x24(%ebp),%eax
80103242:	83 e0 0f             	and    $0xf,%eax
80103245:	01 d0                	add    %edx,%eax
80103247:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010324a:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010324d:	c1 e8 04             	shr    $0x4,%eax
80103250:	89 c2                	mov    %eax,%edx
80103252:	89 d0                	mov    %edx,%eax
80103254:	c1 e0 02             	shl    $0x2,%eax
80103257:	01 d0                	add    %edx,%eax
80103259:	01 c0                	add    %eax,%eax
8010325b:	89 c2                	mov    %eax,%edx
8010325d:	8b 45 e0             	mov    -0x20(%ebp),%eax
80103260:	83 e0 0f             	and    $0xf,%eax
80103263:	01 d0                	add    %edx,%eax
80103265:	89 45 e0             	mov    %eax,-0x20(%ebp)
80103268:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010326b:	c1 e8 04             	shr    $0x4,%eax
8010326e:	89 c2                	mov    %eax,%edx
80103270:	89 d0                	mov    %edx,%eax
80103272:	c1 e0 02             	shl    $0x2,%eax
80103275:	01 d0                	add    %edx,%eax
80103277:	01 c0                	add    %eax,%eax
80103279:	89 c2                	mov    %eax,%edx
8010327b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010327e:	83 e0 0f             	and    $0xf,%eax
80103281:	01 d0                	add    %edx,%eax
80103283:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103286:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103289:	c1 e8 04             	shr    $0x4,%eax
8010328c:	89 c2                	mov    %eax,%edx
8010328e:	89 d0                	mov    %edx,%eax
80103290:	c1 e0 02             	shl    $0x2,%eax
80103293:	01 d0                	add    %edx,%eax
80103295:	01 c0                	add    %eax,%eax
80103297:	89 c2                	mov    %eax,%edx
80103299:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010329c:	83 e0 0f             	and    $0xf,%eax
8010329f:	01 d0                	add    %edx,%eax
801032a1:	89 45 e8             	mov    %eax,-0x18(%ebp)
801032a4:	8b 45 ec             	mov    -0x14(%ebp),%eax
801032a7:	c1 e8 04             	shr    $0x4,%eax
801032aa:	89 c2                	mov    %eax,%edx
801032ac:	89 d0                	mov    %edx,%eax
801032ae:	c1 e0 02             	shl    $0x2,%eax
801032b1:	01 d0                	add    %edx,%eax
801032b3:	01 c0                	add    %eax,%eax
801032b5:	89 c2                	mov    %eax,%edx
801032b7:	8b 45 ec             	mov    -0x14(%ebp),%eax
801032ba:	83 e0 0f             	and    $0xf,%eax
801032bd:	01 d0                	add    %edx,%eax
801032bf:	89 45 ec             	mov    %eax,-0x14(%ebp)
801032c2:	8b 45 08             	mov    0x8(%ebp),%eax
801032c5:	8b 55 d8             	mov    -0x28(%ebp),%edx
801032c8:	89 10                	mov    %edx,(%eax)
801032ca:	8b 55 dc             	mov    -0x24(%ebp),%edx
801032cd:	89 50 04             	mov    %edx,0x4(%eax)
801032d0:	8b 55 e0             	mov    -0x20(%ebp),%edx
801032d3:	89 50 08             	mov    %edx,0x8(%eax)
801032d6:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801032d9:	89 50 0c             	mov    %edx,0xc(%eax)
801032dc:	8b 55 e8             	mov    -0x18(%ebp),%edx
801032df:	89 50 10             	mov    %edx,0x10(%eax)
801032e2:	8b 55 ec             	mov    -0x14(%ebp),%edx
801032e5:	89 50 14             	mov    %edx,0x14(%eax)
801032e8:	8b 45 08             	mov    0x8(%ebp),%eax
801032eb:	8b 40 14             	mov    0x14(%eax),%eax
801032ee:	8d 90 d0 07 00 00    	lea    0x7d0(%eax),%edx
801032f4:	8b 45 08             	mov    0x8(%ebp),%eax
801032f7:	89 50 14             	mov    %edx,0x14(%eax)
801032fa:	c9                   	leave  
801032fb:	c3                   	ret    

801032fc <initlog>:
801032fc:	55                   	push   %ebp
801032fd:	89 e5                	mov    %esp,%ebp
801032ff:	83 ec 28             	sub    $0x28,%esp
80103302:	83 ec 08             	sub    $0x8,%esp
80103305:	68 00 8b 10 80       	push   $0x80108b00
8010330a:	68 00 37 11 80       	push   $0x80113700
8010330f:	e8 26 20 00 00       	call   8010533a <initlock>
80103314:	83 c4 10             	add    $0x10,%esp
80103317:	83 ec 08             	sub    $0x8,%esp
8010331a:	8d 45 dc             	lea    -0x24(%ebp),%eax
8010331d:	50                   	push   %eax
8010331e:	ff 75 08             	pushl  0x8(%ebp)
80103321:	e8 3c e0 ff ff       	call   80101362 <readsb>
80103326:	83 c4 10             	add    $0x10,%esp
80103329:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010332c:	a3 34 37 11 80       	mov    %eax,0x80113734
80103331:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103334:	a3 38 37 11 80       	mov    %eax,0x80113738
80103339:	8b 45 08             	mov    0x8(%ebp),%eax
8010333c:	a3 44 37 11 80       	mov    %eax,0x80113744
80103341:	e8 ae 01 00 00       	call   801034f4 <recover_from_log>
80103346:	c9                   	leave  
80103347:	c3                   	ret    

80103348 <install_trans>:
80103348:	55                   	push   %ebp
80103349:	89 e5                	mov    %esp,%ebp
8010334b:	83 ec 18             	sub    $0x18,%esp
8010334e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103355:	e9 95 00 00 00       	jmp    801033ef <install_trans+0xa7>
8010335a:	8b 15 34 37 11 80    	mov    0x80113734,%edx
80103360:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103363:	01 d0                	add    %edx,%eax
80103365:	83 c0 01             	add    $0x1,%eax
80103368:	89 c2                	mov    %eax,%edx
8010336a:	a1 44 37 11 80       	mov    0x80113744,%eax
8010336f:	83 ec 08             	sub    $0x8,%esp
80103372:	52                   	push   %edx
80103373:	50                   	push   %eax
80103374:	e8 3b ce ff ff       	call   801001b4 <bread>
80103379:	83 c4 10             	add    $0x10,%esp
8010337c:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010337f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103382:	83 c0 10             	add    $0x10,%eax
80103385:	8b 04 85 0c 37 11 80 	mov    -0x7feec8f4(,%eax,4),%eax
8010338c:	89 c2                	mov    %eax,%edx
8010338e:	a1 44 37 11 80       	mov    0x80113744,%eax
80103393:	83 ec 08             	sub    $0x8,%esp
80103396:	52                   	push   %edx
80103397:	50                   	push   %eax
80103398:	e8 17 ce ff ff       	call   801001b4 <bread>
8010339d:	83 c4 10             	add    $0x10,%esp
801033a0:	89 45 ec             	mov    %eax,-0x14(%ebp)
801033a3:	8b 45 f0             	mov    -0x10(%ebp),%eax
801033a6:	8d 50 18             	lea    0x18(%eax),%edx
801033a9:	8b 45 ec             	mov    -0x14(%ebp),%eax
801033ac:	83 c0 18             	add    $0x18,%eax
801033af:	83 ec 04             	sub    $0x4,%esp
801033b2:	68 00 02 00 00       	push   $0x200
801033b7:	52                   	push   %edx
801033b8:	50                   	push   %eax
801033b9:	e8 be 22 00 00       	call   8010567c <memmove>
801033be:	83 c4 10             	add    $0x10,%esp
801033c1:	83 ec 0c             	sub    $0xc,%esp
801033c4:	ff 75 ec             	pushl  -0x14(%ebp)
801033c7:	e8 21 ce ff ff       	call   801001ed <bwrite>
801033cc:	83 c4 10             	add    $0x10,%esp
801033cf:	83 ec 0c             	sub    $0xc,%esp
801033d2:	ff 75 f0             	pushl  -0x10(%ebp)
801033d5:	e8 51 ce ff ff       	call   8010022b <brelse>
801033da:	83 c4 10             	add    $0x10,%esp
801033dd:	83 ec 0c             	sub    $0xc,%esp
801033e0:	ff 75 ec             	pushl  -0x14(%ebp)
801033e3:	e8 43 ce ff ff       	call   8010022b <brelse>
801033e8:	83 c4 10             	add    $0x10,%esp
801033eb:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801033ef:	a1 48 37 11 80       	mov    0x80113748,%eax
801033f4:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801033f7:	0f 8f 5d ff ff ff    	jg     8010335a <install_trans+0x12>
801033fd:	c9                   	leave  
801033fe:	c3                   	ret    

801033ff <read_head>:
801033ff:	55                   	push   %ebp
80103400:	89 e5                	mov    %esp,%ebp
80103402:	83 ec 18             	sub    $0x18,%esp
80103405:	a1 34 37 11 80       	mov    0x80113734,%eax
8010340a:	89 c2                	mov    %eax,%edx
8010340c:	a1 44 37 11 80       	mov    0x80113744,%eax
80103411:	83 ec 08             	sub    $0x8,%esp
80103414:	52                   	push   %edx
80103415:	50                   	push   %eax
80103416:	e8 99 cd ff ff       	call   801001b4 <bread>
8010341b:	83 c4 10             	add    $0x10,%esp
8010341e:	89 45 f0             	mov    %eax,-0x10(%ebp)
80103421:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103424:	83 c0 18             	add    $0x18,%eax
80103427:	89 45 ec             	mov    %eax,-0x14(%ebp)
8010342a:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010342d:	8b 00                	mov    (%eax),%eax
8010342f:	a3 48 37 11 80       	mov    %eax,0x80113748
80103434:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010343b:	eb 1b                	jmp    80103458 <read_head+0x59>
8010343d:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103440:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103443:	8b 44 90 04          	mov    0x4(%eax,%edx,4),%eax
80103447:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010344a:	83 c2 10             	add    $0x10,%edx
8010344d:	89 04 95 0c 37 11 80 	mov    %eax,-0x7feec8f4(,%edx,4)
80103454:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80103458:	a1 48 37 11 80       	mov    0x80113748,%eax
8010345d:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80103460:	7f db                	jg     8010343d <read_head+0x3e>
80103462:	83 ec 0c             	sub    $0xc,%esp
80103465:	ff 75 f0             	pushl  -0x10(%ebp)
80103468:	e8 be cd ff ff       	call   8010022b <brelse>
8010346d:	83 c4 10             	add    $0x10,%esp
80103470:	c9                   	leave  
80103471:	c3                   	ret    

80103472 <write_head>:
80103472:	55                   	push   %ebp
80103473:	89 e5                	mov    %esp,%ebp
80103475:	83 ec 18             	sub    $0x18,%esp
80103478:	a1 34 37 11 80       	mov    0x80113734,%eax
8010347d:	89 c2                	mov    %eax,%edx
8010347f:	a1 44 37 11 80       	mov    0x80113744,%eax
80103484:	83 ec 08             	sub    $0x8,%esp
80103487:	52                   	push   %edx
80103488:	50                   	push   %eax
80103489:	e8 26 cd ff ff       	call   801001b4 <bread>
8010348e:	83 c4 10             	add    $0x10,%esp
80103491:	89 45 f0             	mov    %eax,-0x10(%ebp)
80103494:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103497:	83 c0 18             	add    $0x18,%eax
8010349a:	89 45 ec             	mov    %eax,-0x14(%ebp)
8010349d:	8b 15 48 37 11 80    	mov    0x80113748,%edx
801034a3:	8b 45 ec             	mov    -0x14(%ebp),%eax
801034a6:	89 10                	mov    %edx,(%eax)
801034a8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801034af:	eb 1b                	jmp    801034cc <write_head+0x5a>
801034b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801034b4:	83 c0 10             	add    $0x10,%eax
801034b7:	8b 0c 85 0c 37 11 80 	mov    -0x7feec8f4(,%eax,4),%ecx
801034be:	8b 45 ec             	mov    -0x14(%ebp),%eax
801034c1:	8b 55 f4             	mov    -0xc(%ebp),%edx
801034c4:	89 4c 90 04          	mov    %ecx,0x4(%eax,%edx,4)
801034c8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801034cc:	a1 48 37 11 80       	mov    0x80113748,%eax
801034d1:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801034d4:	7f db                	jg     801034b1 <write_head+0x3f>
801034d6:	83 ec 0c             	sub    $0xc,%esp
801034d9:	ff 75 f0             	pushl  -0x10(%ebp)
801034dc:	e8 0c cd ff ff       	call   801001ed <bwrite>
801034e1:	83 c4 10             	add    $0x10,%esp
801034e4:	83 ec 0c             	sub    $0xc,%esp
801034e7:	ff 75 f0             	pushl  -0x10(%ebp)
801034ea:	e8 3c cd ff ff       	call   8010022b <brelse>
801034ef:	83 c4 10             	add    $0x10,%esp
801034f2:	c9                   	leave  
801034f3:	c3                   	ret    

801034f4 <recover_from_log>:
801034f4:	55                   	push   %ebp
801034f5:	89 e5                	mov    %esp,%ebp
801034f7:	83 ec 08             	sub    $0x8,%esp
801034fa:	e8 00 ff ff ff       	call   801033ff <read_head>
801034ff:	e8 44 fe ff ff       	call   80103348 <install_trans>
80103504:	c7 05 48 37 11 80 00 	movl   $0x0,0x80113748
8010350b:	00 00 00 
8010350e:	e8 5f ff ff ff       	call   80103472 <write_head>
80103513:	c9                   	leave  
80103514:	c3                   	ret    

80103515 <begin_op>:
80103515:	55                   	push   %ebp
80103516:	89 e5                	mov    %esp,%ebp
80103518:	83 ec 08             	sub    $0x8,%esp
8010351b:	83 ec 0c             	sub    $0xc,%esp
8010351e:	68 00 37 11 80       	push   $0x80113700
80103523:	e8 34 1e 00 00       	call   8010535c <acquire>
80103528:	83 c4 10             	add    $0x10,%esp
8010352b:	a1 40 37 11 80       	mov    0x80113740,%eax
80103530:	85 c0                	test   %eax,%eax
80103532:	74 17                	je     8010354b <begin_op+0x36>
80103534:	83 ec 08             	sub    $0x8,%esp
80103537:	68 00 37 11 80       	push   $0x80113700
8010353c:	68 00 37 11 80       	push   $0x80113700
80103541:	e8 d7 1a 00 00       	call   8010501d <sleep>
80103546:	83 c4 10             	add    $0x10,%esp
80103549:	eb 54                	jmp    8010359f <begin_op+0x8a>
8010354b:	8b 0d 48 37 11 80    	mov    0x80113748,%ecx
80103551:	a1 3c 37 11 80       	mov    0x8011373c,%eax
80103556:	8d 50 01             	lea    0x1(%eax),%edx
80103559:	89 d0                	mov    %edx,%eax
8010355b:	c1 e0 02             	shl    $0x2,%eax
8010355e:	01 d0                	add    %edx,%eax
80103560:	01 c0                	add    %eax,%eax
80103562:	01 c8                	add    %ecx,%eax
80103564:	83 f8 1e             	cmp    $0x1e,%eax
80103567:	7e 17                	jle    80103580 <begin_op+0x6b>
80103569:	83 ec 08             	sub    $0x8,%esp
8010356c:	68 00 37 11 80       	push   $0x80113700
80103571:	68 00 37 11 80       	push   $0x80113700
80103576:	e8 a2 1a 00 00       	call   8010501d <sleep>
8010357b:	83 c4 10             	add    $0x10,%esp
8010357e:	eb 1f                	jmp    8010359f <begin_op+0x8a>
80103580:	a1 3c 37 11 80       	mov    0x8011373c,%eax
80103585:	83 c0 01             	add    $0x1,%eax
80103588:	a3 3c 37 11 80       	mov    %eax,0x8011373c
8010358d:	83 ec 0c             	sub    $0xc,%esp
80103590:	68 00 37 11 80       	push   $0x80113700
80103595:	e8 29 1e 00 00       	call   801053c3 <release>
8010359a:	83 c4 10             	add    $0x10,%esp
8010359d:	eb 02                	jmp    801035a1 <begin_op+0x8c>
8010359f:	eb 8a                	jmp    8010352b <begin_op+0x16>
801035a1:	c9                   	leave  
801035a2:	c3                   	ret    

801035a3 <end_op>:
801035a3:	55                   	push   %ebp
801035a4:	89 e5                	mov    %esp,%ebp
801035a6:	83 ec 18             	sub    $0x18,%esp
801035a9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801035b0:	83 ec 0c             	sub    $0xc,%esp
801035b3:	68 00 37 11 80       	push   $0x80113700
801035b8:	e8 9f 1d 00 00       	call   8010535c <acquire>
801035bd:	83 c4 10             	add    $0x10,%esp
801035c0:	a1 3c 37 11 80       	mov    0x8011373c,%eax
801035c5:	83 e8 01             	sub    $0x1,%eax
801035c8:	a3 3c 37 11 80       	mov    %eax,0x8011373c
801035cd:	a1 40 37 11 80       	mov    0x80113740,%eax
801035d2:	85 c0                	test   %eax,%eax
801035d4:	74 0d                	je     801035e3 <end_op+0x40>
801035d6:	83 ec 0c             	sub    $0xc,%esp
801035d9:	68 04 8b 10 80       	push   $0x80108b04
801035de:	e8 7f cf ff ff       	call   80100562 <panic>
801035e3:	a1 3c 37 11 80       	mov    0x8011373c,%eax
801035e8:	85 c0                	test   %eax,%eax
801035ea:	75 13                	jne    801035ff <end_op+0x5c>
801035ec:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
801035f3:	c7 05 40 37 11 80 01 	movl   $0x1,0x80113740
801035fa:	00 00 00 
801035fd:	eb 10                	jmp    8010360f <end_op+0x6c>
801035ff:	83 ec 0c             	sub    $0xc,%esp
80103602:	68 00 37 11 80       	push   $0x80113700
80103607:	e8 0d 1b 00 00       	call   80105119 <wakeup>
8010360c:	83 c4 10             	add    $0x10,%esp
8010360f:	83 ec 0c             	sub    $0xc,%esp
80103612:	68 00 37 11 80       	push   $0x80113700
80103617:	e8 a7 1d 00 00       	call   801053c3 <release>
8010361c:	83 c4 10             	add    $0x10,%esp
8010361f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80103623:	74 3f                	je     80103664 <end_op+0xc1>
80103625:	e8 f3 00 00 00       	call   8010371d <commit>
8010362a:	83 ec 0c             	sub    $0xc,%esp
8010362d:	68 00 37 11 80       	push   $0x80113700
80103632:	e8 25 1d 00 00       	call   8010535c <acquire>
80103637:	83 c4 10             	add    $0x10,%esp
8010363a:	c7 05 40 37 11 80 00 	movl   $0x0,0x80113740
80103641:	00 00 00 
80103644:	83 ec 0c             	sub    $0xc,%esp
80103647:	68 00 37 11 80       	push   $0x80113700
8010364c:	e8 c8 1a 00 00       	call   80105119 <wakeup>
80103651:	83 c4 10             	add    $0x10,%esp
80103654:	83 ec 0c             	sub    $0xc,%esp
80103657:	68 00 37 11 80       	push   $0x80113700
8010365c:	e8 62 1d 00 00       	call   801053c3 <release>
80103661:	83 c4 10             	add    $0x10,%esp
80103664:	c9                   	leave  
80103665:	c3                   	ret    

80103666 <write_log>:
80103666:	55                   	push   %ebp
80103667:	89 e5                	mov    %esp,%ebp
80103669:	83 ec 18             	sub    $0x18,%esp
8010366c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103673:	e9 95 00 00 00       	jmp    8010370d <write_log+0xa7>
80103678:	8b 15 34 37 11 80    	mov    0x80113734,%edx
8010367e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103681:	01 d0                	add    %edx,%eax
80103683:	83 c0 01             	add    $0x1,%eax
80103686:	89 c2                	mov    %eax,%edx
80103688:	a1 44 37 11 80       	mov    0x80113744,%eax
8010368d:	83 ec 08             	sub    $0x8,%esp
80103690:	52                   	push   %edx
80103691:	50                   	push   %eax
80103692:	e8 1d cb ff ff       	call   801001b4 <bread>
80103697:	83 c4 10             	add    $0x10,%esp
8010369a:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010369d:	8b 45 f4             	mov    -0xc(%ebp),%eax
801036a0:	83 c0 10             	add    $0x10,%eax
801036a3:	8b 04 85 0c 37 11 80 	mov    -0x7feec8f4(,%eax,4),%eax
801036aa:	89 c2                	mov    %eax,%edx
801036ac:	a1 44 37 11 80       	mov    0x80113744,%eax
801036b1:	83 ec 08             	sub    $0x8,%esp
801036b4:	52                   	push   %edx
801036b5:	50                   	push   %eax
801036b6:	e8 f9 ca ff ff       	call   801001b4 <bread>
801036bb:	83 c4 10             	add    $0x10,%esp
801036be:	89 45 ec             	mov    %eax,-0x14(%ebp)
801036c1:	8b 45 ec             	mov    -0x14(%ebp),%eax
801036c4:	8d 50 18             	lea    0x18(%eax),%edx
801036c7:	8b 45 f0             	mov    -0x10(%ebp),%eax
801036ca:	83 c0 18             	add    $0x18,%eax
801036cd:	83 ec 04             	sub    $0x4,%esp
801036d0:	68 00 02 00 00       	push   $0x200
801036d5:	52                   	push   %edx
801036d6:	50                   	push   %eax
801036d7:	e8 a0 1f 00 00       	call   8010567c <memmove>
801036dc:	83 c4 10             	add    $0x10,%esp
801036df:	83 ec 0c             	sub    $0xc,%esp
801036e2:	ff 75 f0             	pushl  -0x10(%ebp)
801036e5:	e8 03 cb ff ff       	call   801001ed <bwrite>
801036ea:	83 c4 10             	add    $0x10,%esp
801036ed:	83 ec 0c             	sub    $0xc,%esp
801036f0:	ff 75 ec             	pushl  -0x14(%ebp)
801036f3:	e8 33 cb ff ff       	call   8010022b <brelse>
801036f8:	83 c4 10             	add    $0x10,%esp
801036fb:	83 ec 0c             	sub    $0xc,%esp
801036fe:	ff 75 f0             	pushl  -0x10(%ebp)
80103701:	e8 25 cb ff ff       	call   8010022b <brelse>
80103706:	83 c4 10             	add    $0x10,%esp
80103709:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010370d:	a1 48 37 11 80       	mov    0x80113748,%eax
80103712:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80103715:	0f 8f 5d ff ff ff    	jg     80103678 <write_log+0x12>
8010371b:	c9                   	leave  
8010371c:	c3                   	ret    

8010371d <commit>:
8010371d:	55                   	push   %ebp
8010371e:	89 e5                	mov    %esp,%ebp
80103720:	83 ec 08             	sub    $0x8,%esp
80103723:	a1 48 37 11 80       	mov    0x80113748,%eax
80103728:	85 c0                	test   %eax,%eax
8010372a:	7e 1e                	jle    8010374a <commit+0x2d>
8010372c:	e8 35 ff ff ff       	call   80103666 <write_log>
80103731:	e8 3c fd ff ff       	call   80103472 <write_head>
80103736:	e8 0d fc ff ff       	call   80103348 <install_trans>
8010373b:	c7 05 48 37 11 80 00 	movl   $0x0,0x80113748
80103742:	00 00 00 
80103745:	e8 28 fd ff ff       	call   80103472 <write_head>
8010374a:	c9                   	leave  
8010374b:	c3                   	ret    

8010374c <log_write>:
8010374c:	55                   	push   %ebp
8010374d:	89 e5                	mov    %esp,%ebp
8010374f:	83 ec 18             	sub    $0x18,%esp
80103752:	a1 48 37 11 80       	mov    0x80113748,%eax
80103757:	83 f8 1d             	cmp    $0x1d,%eax
8010375a:	7f 12                	jg     8010376e <log_write+0x22>
8010375c:	a1 48 37 11 80       	mov    0x80113748,%eax
80103761:	8b 15 38 37 11 80    	mov    0x80113738,%edx
80103767:	83 ea 01             	sub    $0x1,%edx
8010376a:	39 d0                	cmp    %edx,%eax
8010376c:	7c 0d                	jl     8010377b <log_write+0x2f>
8010376e:	83 ec 0c             	sub    $0xc,%esp
80103771:	68 13 8b 10 80       	push   $0x80108b13
80103776:	e8 e7 cd ff ff       	call   80100562 <panic>
8010377b:	a1 3c 37 11 80       	mov    0x8011373c,%eax
80103780:	85 c0                	test   %eax,%eax
80103782:	7f 0d                	jg     80103791 <log_write+0x45>
80103784:	83 ec 0c             	sub    $0xc,%esp
80103787:	68 29 8b 10 80       	push   $0x80108b29
8010378c:	e8 d1 cd ff ff       	call   80100562 <panic>
80103791:	83 ec 0c             	sub    $0xc,%esp
80103794:	68 00 37 11 80       	push   $0x80113700
80103799:	e8 be 1b 00 00       	call   8010535c <acquire>
8010379e:	83 c4 10             	add    $0x10,%esp
801037a1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801037a8:	eb 1f                	jmp    801037c9 <log_write+0x7d>
801037aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
801037ad:	83 c0 10             	add    $0x10,%eax
801037b0:	8b 04 85 0c 37 11 80 	mov    -0x7feec8f4(,%eax,4),%eax
801037b7:	89 c2                	mov    %eax,%edx
801037b9:	8b 45 08             	mov    0x8(%ebp),%eax
801037bc:	8b 40 08             	mov    0x8(%eax),%eax
801037bf:	39 c2                	cmp    %eax,%edx
801037c1:	75 02                	jne    801037c5 <log_write+0x79>
801037c3:	eb 0e                	jmp    801037d3 <log_write+0x87>
801037c5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801037c9:	a1 48 37 11 80       	mov    0x80113748,%eax
801037ce:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801037d1:	7f d7                	jg     801037aa <log_write+0x5e>
801037d3:	8b 45 08             	mov    0x8(%ebp),%eax
801037d6:	8b 40 08             	mov    0x8(%eax),%eax
801037d9:	89 c2                	mov    %eax,%edx
801037db:	8b 45 f4             	mov    -0xc(%ebp),%eax
801037de:	83 c0 10             	add    $0x10,%eax
801037e1:	89 14 85 0c 37 11 80 	mov    %edx,-0x7feec8f4(,%eax,4)
801037e8:	a1 48 37 11 80       	mov    0x80113748,%eax
801037ed:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801037f0:	75 0d                	jne    801037ff <log_write+0xb3>
801037f2:	a1 48 37 11 80       	mov    0x80113748,%eax
801037f7:	83 c0 01             	add    $0x1,%eax
801037fa:	a3 48 37 11 80       	mov    %eax,0x80113748
801037ff:	8b 45 08             	mov    0x8(%ebp),%eax
80103802:	8b 00                	mov    (%eax),%eax
80103804:	83 c8 04             	or     $0x4,%eax
80103807:	89 c2                	mov    %eax,%edx
80103809:	8b 45 08             	mov    0x8(%ebp),%eax
8010380c:	89 10                	mov    %edx,(%eax)
8010380e:	83 ec 0c             	sub    $0xc,%esp
80103811:	68 00 37 11 80       	push   $0x80113700
80103816:	e8 a8 1b 00 00       	call   801053c3 <release>
8010381b:	83 c4 10             	add    $0x10,%esp
8010381e:	c9                   	leave  
8010381f:	c3                   	ret    

80103820 <v2p>:
#define KERNBASE 0x80000000         // First kernel virtual address
#define KERNLINK (KERNBASE+EXTMEM)  // Address where kernel is linked

#ifndef __ASSEMBLER__

static inline uint v2p(void *a) { return ((uint) (a))  - KERNBASE; }
80103820:	55                   	push   %ebp
80103821:	89 e5                	mov    %esp,%ebp
80103823:	8b 45 08             	mov    0x8(%ebp),%eax
80103826:	05 00 00 00 80       	add    $0x80000000,%eax
8010382b:	5d                   	pop    %ebp
8010382c:	c3                   	ret    

8010382d <p2v>:
static inline void *p2v(uint a) { return (void *) ((a) + KERNBASE); }
8010382d:	55                   	push   %ebp
8010382e:	89 e5                	mov    %esp,%ebp
80103830:	8b 45 08             	mov    0x8(%ebp),%eax
80103833:	05 00 00 00 80       	add    $0x80000000,%eax
80103838:	5d                   	pop    %ebp
80103839:	c3                   	ret    

8010383a <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
8010383a:	55                   	push   %ebp
8010383b:	89 e5                	mov    %esp,%ebp
8010383d:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80103840:	8b 55 08             	mov    0x8(%ebp),%edx
80103843:	8b 45 0c             	mov    0xc(%ebp),%eax
80103846:	8b 4d 08             	mov    0x8(%ebp),%ecx
80103849:	f0 87 02             	lock xchg %eax,(%edx)
8010384c:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
8010384f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80103852:	c9                   	leave  
80103853:	c3                   	ret    

80103854 <main>:
// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
80103854:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80103858:	83 e4 f0             	and    $0xfffffff0,%esp
8010385b:	ff 71 fc             	pushl  -0x4(%ecx)
8010385e:	55                   	push   %ebp
8010385f:	89 e5                	mov    %esp,%ebp
80103861:	51                   	push   %ecx
80103862:	83 ec 04             	sub    $0x4,%esp
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80103865:	83 ec 08             	sub    $0x8,%esp
80103868:	68 00 00 40 80       	push   $0x80400000
8010386d:	68 dc 67 11 80       	push   $0x801167dc
80103872:	e8 92 f2 ff ff       	call   80102b09 <kinit1>
80103877:	83 c4 10             	add    $0x10,%esp
  kvmalloc();      // kernel page table
8010387a:	e8 a0 48 00 00       	call   8010811f <kvmalloc>
  mpinit();        // collect info about this machine
8010387f:	e8 43 04 00 00       	call   80103cc7 <mpinit>
  lapicinit();
80103884:	e8 f8 f5 ff ff       	call   80102e81 <lapicinit>
  seginit();       // set up segments
80103889:	e8 3a 42 00 00       	call   80107ac8 <seginit>
  cprintf("\ncpu%d: starting xv6\n\n", cpu->id);
8010388e:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80103894:	0f b6 00             	movzbl (%eax),%eax
80103897:	0f b6 c0             	movzbl %al,%eax
8010389a:	83 ec 08             	sub    $0x8,%esp
8010389d:	50                   	push   %eax
8010389e:	68 44 8b 10 80       	push   $0x80108b44
801038a3:	e8 1a cb ff ff       	call   801003c2 <cprintf>
801038a8:	83 c4 10             	add    $0x10,%esp
  picinit();       // interrupt controller
801038ab:	e8 6a 06 00 00       	call   80103f1a <picinit>
  ioapicinit();    // another interrupt controller
801038b0:	e8 4c f1 ff ff       	call   80102a01 <ioapicinit>
  consoleinit();   // I/O devices & their interrupts
801038b5:	e8 2b d2 ff ff       	call   80100ae5 <consoleinit>
  uartinit();      // serial port
801038ba:	e8 65 35 00 00       	call   80106e24 <uartinit>
  pinit();         // process table
801038bf:	e8 b4 0d 00 00       	call   80104678 <pinit>
  tvinit();        // trap vectors
801038c4:	e8 14 31 00 00       	call   801069dd <tvinit>
  binit();         // buffer cache
801038c9:	e8 66 c7 ff ff       	call   80100034 <binit>
  fileinit();      // file table
801038ce:	e8 83 d6 ff ff       	call   80100f56 <fileinit>
  ideinit();       // disk
801038d3:	e8 32 ed ff ff       	call   8010260a <ideinit>
  if(!ismp)
801038d8:	a1 e4 37 11 80       	mov    0x801137e4,%eax
801038dd:	85 c0                	test   %eax,%eax
801038df:	75 05                	jne    801038e6 <main+0x92>
    timerinit();   // uniprocessor timer
801038e1:	e8 55 30 00 00       	call   8010693b <timerinit>
  startothers();   // start other processors
801038e6:	e8 7f 00 00 00       	call   8010396a <startothers>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
801038eb:	83 ec 08             	sub    $0x8,%esp
801038ee:	68 00 00 00 8e       	push   $0x8e000000
801038f3:	68 00 00 40 80       	push   $0x80400000
801038f8:	e8 44 f2 ff ff       	call   80102b41 <kinit2>
801038fd:	83 c4 10             	add    $0x10,%esp
  userinit();      // first user process
80103900:	e8 d9 0e 00 00       	call   801047de <userinit>
  // Finish setting up this processor in mpmain.
  mpmain();
80103905:	e8 1a 00 00 00       	call   80103924 <mpmain>

8010390a <mpenter>:
}

// Other CPUs jump here from entryother.S.
static void
mpenter(void)
{
8010390a:	55                   	push   %ebp
8010390b:	89 e5                	mov    %esp,%ebp
8010390d:	83 ec 08             	sub    $0x8,%esp
  switchkvm(); 
80103910:	e8 22 48 00 00       	call   80108137 <switchkvm>
  seginit();
80103915:	e8 ae 41 00 00       	call   80107ac8 <seginit>
  lapicinit();
8010391a:	e8 62 f5 ff ff       	call   80102e81 <lapicinit>
  mpmain();
8010391f:	e8 00 00 00 00       	call   80103924 <mpmain>

80103924 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80103924:	55                   	push   %ebp
80103925:	89 e5                	mov    %esp,%ebp
80103927:	83 ec 08             	sub    $0x8,%esp
  cprintf("cpu%d: starting\n", cpu->id);
8010392a:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80103930:	0f b6 00             	movzbl (%eax),%eax
80103933:	0f b6 c0             	movzbl %al,%eax
80103936:	83 ec 08             	sub    $0x8,%esp
80103939:	50                   	push   %eax
8010393a:	68 5b 8b 10 80       	push   $0x80108b5b
8010393f:	e8 7e ca ff ff       	call   801003c2 <cprintf>
80103944:	83 c4 10             	add    $0x10,%esp
  idtinit();       // load idt register
80103947:	e8 07 32 00 00       	call   80106b53 <idtinit>
  xchg(&cpu->started, 1); // tell startothers() we're up
8010394c:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80103952:	05 a8 00 00 00       	add    $0xa8,%eax
80103957:	83 ec 08             	sub    $0x8,%esp
8010395a:	6a 01                	push   $0x1
8010395c:	50                   	push   %eax
8010395d:	e8 d8 fe ff ff       	call   8010383a <xchg>
80103962:	83 c4 10             	add    $0x10,%esp
  scheduler();     // start running processes
80103965:	e8 b1 14 00 00       	call   80104e1b <scheduler>

8010396a <startothers>:
pde_t entrypgdir[];  // For entry.S

// Start the non-boot (AP) processors.
static void
startothers(void)
{
8010396a:	55                   	push   %ebp
8010396b:	89 e5                	mov    %esp,%ebp
8010396d:	53                   	push   %ebx
8010396e:	83 ec 14             	sub    $0x14,%esp
  char *stack;

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = p2v(0x7000);
80103971:	68 00 70 00 00       	push   $0x7000
80103976:	e8 b2 fe ff ff       	call   8010382d <p2v>
8010397b:	83 c4 04             	add    $0x4,%esp
8010397e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80103981:	b8 8a 00 00 00       	mov    $0x8a,%eax
80103986:	83 ec 04             	sub    $0x4,%esp
80103989:	50                   	push   %eax
8010398a:	68 0c c5 10 80       	push   $0x8010c50c
8010398f:	ff 75 f0             	pushl  -0x10(%ebp)
80103992:	e8 e5 1c 00 00       	call   8010567c <memmove>
80103997:	83 c4 10             	add    $0x10,%esp

  for(c = cpus; c < cpus+ncpu; c++){
8010399a:	c7 45 f4 00 38 11 80 	movl   $0x80113800,-0xc(%ebp)
801039a1:	e9 90 00 00 00       	jmp    80103a36 <startothers+0xcc>
    if(c == cpus+cpunum())  // We've started already.
801039a6:	e8 f2 f5 ff ff       	call   80102f9d <cpunum>
801039ab:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
801039b1:	05 00 38 11 80       	add    $0x80113800,%eax
801039b6:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801039b9:	74 73                	je     80103a2e <startothers+0xc4>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what 
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
801039bb:	e8 7c f2 ff ff       	call   80102c3c <kalloc>
801039c0:	89 45 ec             	mov    %eax,-0x14(%ebp)
    *(void**)(code-4) = stack + KSTACKSIZE;
801039c3:	8b 45 f0             	mov    -0x10(%ebp),%eax
801039c6:	83 e8 04             	sub    $0x4,%eax
801039c9:	8b 55 ec             	mov    -0x14(%ebp),%edx
801039cc:	81 c2 00 10 00 00    	add    $0x1000,%edx
801039d2:	89 10                	mov    %edx,(%eax)
    *(void**)(code-8) = mpenter;
801039d4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801039d7:	83 e8 08             	sub    $0x8,%eax
801039da:	c7 00 0a 39 10 80    	movl   $0x8010390a,(%eax)
    *(int**)(code-12) = (void *) v2p(entrypgdir);
801039e0:	8b 45 f0             	mov    -0x10(%ebp),%eax
801039e3:	8d 58 f4             	lea    -0xc(%eax),%ebx
801039e6:	83 ec 0c             	sub    $0xc,%esp
801039e9:	68 00 b0 10 80       	push   $0x8010b000
801039ee:	e8 2d fe ff ff       	call   80103820 <v2p>
801039f3:	83 c4 10             	add    $0x10,%esp
801039f6:	89 03                	mov    %eax,(%ebx)

    lapicstartap(c->id, v2p(code));
801039f8:	83 ec 0c             	sub    $0xc,%esp
801039fb:	ff 75 f0             	pushl  -0x10(%ebp)
801039fe:	e8 1d fe ff ff       	call   80103820 <v2p>
80103a03:	83 c4 10             	add    $0x10,%esp
80103a06:	89 c2                	mov    %eax,%edx
80103a08:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103a0b:	0f b6 00             	movzbl (%eax),%eax
80103a0e:	0f b6 c0             	movzbl %al,%eax
80103a11:	83 ec 08             	sub    $0x8,%esp
80103a14:	52                   	push   %edx
80103a15:	50                   	push   %eax
80103a16:	e8 fa f5 ff ff       	call   80103015 <lapicstartap>
80103a1b:	83 c4 10             	add    $0x10,%esp

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103a1e:	90                   	nop
80103a1f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103a22:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
80103a28:	85 c0                	test   %eax,%eax
80103a2a:	74 f3                	je     80103a1f <startothers+0xb5>
80103a2c:	eb 01                	jmp    80103a2f <startothers+0xc5>
  code = p2v(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
    if(c == cpus+cpunum())  // We've started already.
      continue;
80103a2e:	90                   	nop
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = p2v(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
80103a2f:	81 45 f4 bc 00 00 00 	addl   $0xbc,-0xc(%ebp)
80103a36:	a1 e0 3d 11 80       	mov    0x80113de0,%eax
80103a3b:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80103a41:	05 00 38 11 80       	add    $0x80113800,%eax
80103a46:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80103a49:	0f 87 57 ff ff ff    	ja     801039a6 <startothers+0x3c>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
      ;
  }
}
80103a4f:	90                   	nop
80103a50:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103a53:	c9                   	leave  
80103a54:	c3                   	ret    

80103a55 <p2v>:
80103a55:	55                   	push   %ebp
80103a56:	89 e5                	mov    %esp,%ebp
80103a58:	8b 45 08             	mov    0x8(%ebp),%eax
80103a5b:	05 00 00 00 80       	add    $0x80000000,%eax
80103a60:	5d                   	pop    %ebp
80103a61:	c3                   	ret    

80103a62 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
80103a62:	55                   	push   %ebp
80103a63:	89 e5                	mov    %esp,%ebp
80103a65:	83 ec 14             	sub    $0x14,%esp
80103a68:	8b 45 08             	mov    0x8(%ebp),%eax
80103a6b:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103a6f:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80103a73:	89 c2                	mov    %eax,%edx
80103a75:	ec                   	in     (%dx),%al
80103a76:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80103a79:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80103a7d:	c9                   	leave  
80103a7e:	c3                   	ret    

80103a7f <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80103a7f:	55                   	push   %ebp
80103a80:	89 e5                	mov    %esp,%ebp
80103a82:	83 ec 08             	sub    $0x8,%esp
80103a85:	8b 55 08             	mov    0x8(%ebp),%edx
80103a88:	8b 45 0c             	mov    0xc(%ebp),%eax
80103a8b:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80103a8f:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103a92:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80103a96:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80103a9a:	ee                   	out    %al,(%dx)
}
80103a9b:	90                   	nop
80103a9c:	c9                   	leave  
80103a9d:	c3                   	ret    

80103a9e <mpbcpu>:
int ncpu;
uchar ioapicid;

int
mpbcpu(void)
{
80103a9e:	55                   	push   %ebp
80103a9f:	89 e5                	mov    %esp,%ebp
  return bcpu-cpus;
80103aa1:	a1 64 c6 10 80       	mov    0x8010c664,%eax
80103aa6:	89 c2                	mov    %eax,%edx
80103aa8:	b8 00 38 11 80       	mov    $0x80113800,%eax
80103aad:	29 c2                	sub    %eax,%edx
80103aaf:	89 d0                	mov    %edx,%eax
80103ab1:	c1 f8 02             	sar    $0x2,%eax
80103ab4:	69 c0 cf 46 7d 67    	imul   $0x677d46cf,%eax,%eax
}
80103aba:	5d                   	pop    %ebp
80103abb:	c3                   	ret    

80103abc <sum>:

static uchar
sum(uchar *addr, int len)
{
80103abc:	55                   	push   %ebp
80103abd:	89 e5                	mov    %esp,%ebp
80103abf:	83 ec 10             	sub    $0x10,%esp
  int i, sum;
  
  sum = 0;
80103ac2:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  for(i=0; i<len; i++)
80103ac9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
80103ad0:	eb 15                	jmp    80103ae7 <sum+0x2b>
    sum += addr[i];
80103ad2:	8b 55 fc             	mov    -0x4(%ebp),%edx
80103ad5:	8b 45 08             	mov    0x8(%ebp),%eax
80103ad8:	01 d0                	add    %edx,%eax
80103ada:	0f b6 00             	movzbl (%eax),%eax
80103add:	0f b6 c0             	movzbl %al,%eax
80103ae0:	01 45 f8             	add    %eax,-0x8(%ebp)
sum(uchar *addr, int len)
{
  int i, sum;
  
  sum = 0;
  for(i=0; i<len; i++)
80103ae3:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80103ae7:	8b 45 fc             	mov    -0x4(%ebp),%eax
80103aea:	3b 45 0c             	cmp    0xc(%ebp),%eax
80103aed:	7c e3                	jl     80103ad2 <sum+0x16>
    sum += addr[i];
  return sum;
80103aef:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
80103af2:	c9                   	leave  
80103af3:	c3                   	ret    

80103af4 <mpsearch1>:

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103af4:	55                   	push   %ebp
80103af5:	89 e5                	mov    %esp,%ebp
80103af7:	83 ec 18             	sub    $0x18,%esp
  uchar *e, *p, *addr;

  addr = p2v(a);
80103afa:	ff 75 08             	pushl  0x8(%ebp)
80103afd:	e8 53 ff ff ff       	call   80103a55 <p2v>
80103b02:	83 c4 04             	add    $0x4,%esp
80103b05:	89 45 f0             	mov    %eax,-0x10(%ebp)
  e = addr+len;
80103b08:	8b 55 0c             	mov    0xc(%ebp),%edx
80103b0b:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103b0e:	01 d0                	add    %edx,%eax
80103b10:	89 45 ec             	mov    %eax,-0x14(%ebp)
  for(p = addr; p < e; p += sizeof(struct mp))
80103b13:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103b16:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103b19:	eb 36                	jmp    80103b51 <mpsearch1+0x5d>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103b1b:	83 ec 04             	sub    $0x4,%esp
80103b1e:	6a 04                	push   $0x4
80103b20:	68 6c 8b 10 80       	push   $0x80108b6c
80103b25:	ff 75 f4             	pushl  -0xc(%ebp)
80103b28:	e8 f7 1a 00 00       	call   80105624 <memcmp>
80103b2d:	83 c4 10             	add    $0x10,%esp
80103b30:	85 c0                	test   %eax,%eax
80103b32:	75 19                	jne    80103b4d <mpsearch1+0x59>
80103b34:	83 ec 08             	sub    $0x8,%esp
80103b37:	6a 10                	push   $0x10
80103b39:	ff 75 f4             	pushl  -0xc(%ebp)
80103b3c:	e8 7b ff ff ff       	call   80103abc <sum>
80103b41:	83 c4 10             	add    $0x10,%esp
80103b44:	84 c0                	test   %al,%al
80103b46:	75 05                	jne    80103b4d <mpsearch1+0x59>
      return (struct mp*)p;
80103b48:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103b4b:	eb 11                	jmp    80103b5e <mpsearch1+0x6a>
{
  uchar *e, *p, *addr;

  addr = p2v(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
80103b4d:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
80103b51:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103b54:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80103b57:	72 c2                	jb     80103b1b <mpsearch1+0x27>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
80103b59:	b8 00 00 00 00       	mov    $0x0,%eax
}
80103b5e:	c9                   	leave  
80103b5f:	c3                   	ret    

80103b60 <mpsearch>:
// 1) in the first KB of the EBDA;
// 2) in the last KB of system base memory;
// 3) in the BIOS ROM between 0xE0000 and 0xFFFFF.
static struct mp*
mpsearch(void)
{
80103b60:	55                   	push   %ebp
80103b61:	89 e5                	mov    %esp,%ebp
80103b63:	83 ec 18             	sub    $0x18,%esp
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
80103b66:	c7 45 f4 00 04 00 80 	movl   $0x80000400,-0xc(%ebp)
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103b6d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103b70:	83 c0 0f             	add    $0xf,%eax
80103b73:	0f b6 00             	movzbl (%eax),%eax
80103b76:	0f b6 c0             	movzbl %al,%eax
80103b79:	c1 e0 08             	shl    $0x8,%eax
80103b7c:	89 c2                	mov    %eax,%edx
80103b7e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103b81:	83 c0 0e             	add    $0xe,%eax
80103b84:	0f b6 00             	movzbl (%eax),%eax
80103b87:	0f b6 c0             	movzbl %al,%eax
80103b8a:	09 d0                	or     %edx,%eax
80103b8c:	c1 e0 04             	shl    $0x4,%eax
80103b8f:	89 45 f0             	mov    %eax,-0x10(%ebp)
80103b92:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80103b96:	74 21                	je     80103bb9 <mpsearch+0x59>
    if((mp = mpsearch1(p, 1024)))
80103b98:	83 ec 08             	sub    $0x8,%esp
80103b9b:	68 00 04 00 00       	push   $0x400
80103ba0:	ff 75 f0             	pushl  -0x10(%ebp)
80103ba3:	e8 4c ff ff ff       	call   80103af4 <mpsearch1>
80103ba8:	83 c4 10             	add    $0x10,%esp
80103bab:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103bae:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80103bb2:	74 51                	je     80103c05 <mpsearch+0xa5>
      return mp;
80103bb4:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103bb7:	eb 61                	jmp    80103c1a <mpsearch+0xba>
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103bb9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103bbc:	83 c0 14             	add    $0x14,%eax
80103bbf:	0f b6 00             	movzbl (%eax),%eax
80103bc2:	0f b6 c0             	movzbl %al,%eax
80103bc5:	c1 e0 08             	shl    $0x8,%eax
80103bc8:	89 c2                	mov    %eax,%edx
80103bca:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103bcd:	83 c0 13             	add    $0x13,%eax
80103bd0:	0f b6 00             	movzbl (%eax),%eax
80103bd3:	0f b6 c0             	movzbl %al,%eax
80103bd6:	09 d0                	or     %edx,%eax
80103bd8:	c1 e0 0a             	shl    $0xa,%eax
80103bdb:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if((mp = mpsearch1(p-1024, 1024)))
80103bde:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103be1:	2d 00 04 00 00       	sub    $0x400,%eax
80103be6:	83 ec 08             	sub    $0x8,%esp
80103be9:	68 00 04 00 00       	push   $0x400
80103bee:	50                   	push   %eax
80103bef:	e8 00 ff ff ff       	call   80103af4 <mpsearch1>
80103bf4:	83 c4 10             	add    $0x10,%esp
80103bf7:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103bfa:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80103bfe:	74 05                	je     80103c05 <mpsearch+0xa5>
      return mp;
80103c00:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103c03:	eb 15                	jmp    80103c1a <mpsearch+0xba>
  }
  return mpsearch1(0xF0000, 0x10000);
80103c05:	83 ec 08             	sub    $0x8,%esp
80103c08:	68 00 00 01 00       	push   $0x10000
80103c0d:	68 00 00 0f 00       	push   $0xf0000
80103c12:	e8 dd fe ff ff       	call   80103af4 <mpsearch1>
80103c17:	83 c4 10             	add    $0x10,%esp
}
80103c1a:	c9                   	leave  
80103c1b:	c3                   	ret    

80103c1c <mpconfig>:
// Check for correct signature, calculate the checksum and,
// if correct, check the version.
// To do: check extended table checksum.
static struct mpconf*
mpconfig(struct mp **pmp)
{
80103c1c:	55                   	push   %ebp
80103c1d:	89 e5                	mov    %esp,%ebp
80103c1f:	83 ec 18             	sub    $0x18,%esp
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103c22:	e8 39 ff ff ff       	call   80103b60 <mpsearch>
80103c27:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103c2a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80103c2e:	74 0a                	je     80103c3a <mpconfig+0x1e>
80103c30:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103c33:	8b 40 04             	mov    0x4(%eax),%eax
80103c36:	85 c0                	test   %eax,%eax
80103c38:	75 0a                	jne    80103c44 <mpconfig+0x28>
    return 0;
80103c3a:	b8 00 00 00 00       	mov    $0x0,%eax
80103c3f:	e9 81 00 00 00       	jmp    80103cc5 <mpconfig+0xa9>
  conf = (struct mpconf*) p2v((uint) mp->physaddr);
80103c44:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103c47:	8b 40 04             	mov    0x4(%eax),%eax
80103c4a:	83 ec 0c             	sub    $0xc,%esp
80103c4d:	50                   	push   %eax
80103c4e:	e8 02 fe ff ff       	call   80103a55 <p2v>
80103c53:	83 c4 10             	add    $0x10,%esp
80103c56:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
80103c59:	83 ec 04             	sub    $0x4,%esp
80103c5c:	6a 04                	push   $0x4
80103c5e:	68 71 8b 10 80       	push   $0x80108b71
80103c63:	ff 75 f0             	pushl  -0x10(%ebp)
80103c66:	e8 b9 19 00 00       	call   80105624 <memcmp>
80103c6b:	83 c4 10             	add    $0x10,%esp
80103c6e:	85 c0                	test   %eax,%eax
80103c70:	74 07                	je     80103c79 <mpconfig+0x5d>
    return 0;
80103c72:	b8 00 00 00 00       	mov    $0x0,%eax
80103c77:	eb 4c                	jmp    80103cc5 <mpconfig+0xa9>
  if(conf->version != 1 && conf->version != 4)
80103c79:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103c7c:	0f b6 40 06          	movzbl 0x6(%eax),%eax
80103c80:	3c 01                	cmp    $0x1,%al
80103c82:	74 12                	je     80103c96 <mpconfig+0x7a>
80103c84:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103c87:	0f b6 40 06          	movzbl 0x6(%eax),%eax
80103c8b:	3c 04                	cmp    $0x4,%al
80103c8d:	74 07                	je     80103c96 <mpconfig+0x7a>
    return 0;
80103c8f:	b8 00 00 00 00       	mov    $0x0,%eax
80103c94:	eb 2f                	jmp    80103cc5 <mpconfig+0xa9>
  if(sum((uchar*)conf, conf->length) != 0)
80103c96:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103c99:	0f b7 40 04          	movzwl 0x4(%eax),%eax
80103c9d:	0f b7 c0             	movzwl %ax,%eax
80103ca0:	83 ec 08             	sub    $0x8,%esp
80103ca3:	50                   	push   %eax
80103ca4:	ff 75 f0             	pushl  -0x10(%ebp)
80103ca7:	e8 10 fe ff ff       	call   80103abc <sum>
80103cac:	83 c4 10             	add    $0x10,%esp
80103caf:	84 c0                	test   %al,%al
80103cb1:	74 07                	je     80103cba <mpconfig+0x9e>
    return 0;
80103cb3:	b8 00 00 00 00       	mov    $0x0,%eax
80103cb8:	eb 0b                	jmp    80103cc5 <mpconfig+0xa9>
  *pmp = mp;
80103cba:	8b 45 08             	mov    0x8(%ebp),%eax
80103cbd:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103cc0:	89 10                	mov    %edx,(%eax)
  return conf;
80103cc2:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80103cc5:	c9                   	leave  
80103cc6:	c3                   	ret    

80103cc7 <mpinit>:

void
mpinit(void)
{
80103cc7:	55                   	push   %ebp
80103cc8:	89 e5                	mov    %esp,%ebp
80103cca:	83 ec 28             	sub    $0x28,%esp
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  bcpu = &cpus[0];
80103ccd:	c7 05 64 c6 10 80 00 	movl   $0x80113800,0x8010c664
80103cd4:	38 11 80 
  if((conf = mpconfig(&mp)) == 0)
80103cd7:	83 ec 0c             	sub    $0xc,%esp
80103cda:	8d 45 e0             	lea    -0x20(%ebp),%eax
80103cdd:	50                   	push   %eax
80103cde:	e8 39 ff ff ff       	call   80103c1c <mpconfig>
80103ce3:	83 c4 10             	add    $0x10,%esp
80103ce6:	89 45 f0             	mov    %eax,-0x10(%ebp)
80103ce9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80103ced:	0f 84 96 01 00 00    	je     80103e89 <mpinit+0x1c2>
    return;
  ismp = 1;
80103cf3:	c7 05 e4 37 11 80 01 	movl   $0x1,0x801137e4
80103cfa:	00 00 00 
  lapic = (uint*)conf->lapicaddr;
80103cfd:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103d00:	8b 40 24             	mov    0x24(%eax),%eax
80103d03:	a3 dc 36 11 80       	mov    %eax,0x801136dc
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103d08:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103d0b:	83 c0 2c             	add    $0x2c,%eax
80103d0e:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103d11:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103d14:	0f b7 40 04          	movzwl 0x4(%eax),%eax
80103d18:	0f b7 d0             	movzwl %ax,%edx
80103d1b:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103d1e:	01 d0                	add    %edx,%eax
80103d20:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103d23:	e9 f2 00 00 00       	jmp    80103e1a <mpinit+0x153>
    switch(*p){
80103d28:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103d2b:	0f b6 00             	movzbl (%eax),%eax
80103d2e:	0f b6 c0             	movzbl %al,%eax
80103d31:	83 f8 04             	cmp    $0x4,%eax
80103d34:	0f 87 bc 00 00 00    	ja     80103df6 <mpinit+0x12f>
80103d3a:	8b 04 85 b4 8b 10 80 	mov    -0x7fef744c(,%eax,4),%eax
80103d41:	ff e0                	jmp    *%eax
    case MPPROC:
      proc = (struct mpproc*)p;
80103d43:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103d46:	89 45 e8             	mov    %eax,-0x18(%ebp)
      if(ncpu != proc->apicid){
80103d49:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103d4c:	0f b6 40 01          	movzbl 0x1(%eax),%eax
80103d50:	0f b6 d0             	movzbl %al,%edx
80103d53:	a1 e0 3d 11 80       	mov    0x80113de0,%eax
80103d58:	39 c2                	cmp    %eax,%edx
80103d5a:	74 2b                	je     80103d87 <mpinit+0xc0>
        cprintf("mpinit: ncpu=%d apicid=%d\n", ncpu, proc->apicid);
80103d5c:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103d5f:	0f b6 40 01          	movzbl 0x1(%eax),%eax
80103d63:	0f b6 d0             	movzbl %al,%edx
80103d66:	a1 e0 3d 11 80       	mov    0x80113de0,%eax
80103d6b:	83 ec 04             	sub    $0x4,%esp
80103d6e:	52                   	push   %edx
80103d6f:	50                   	push   %eax
80103d70:	68 76 8b 10 80       	push   $0x80108b76
80103d75:	e8 48 c6 ff ff       	call   801003c2 <cprintf>
80103d7a:	83 c4 10             	add    $0x10,%esp
        ismp = 0;
80103d7d:	c7 05 e4 37 11 80 00 	movl   $0x0,0x801137e4
80103d84:	00 00 00 
      }
      if(proc->flags & MPBOOT)
80103d87:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103d8a:	0f b6 40 03          	movzbl 0x3(%eax),%eax
80103d8e:	0f b6 c0             	movzbl %al,%eax
80103d91:	83 e0 02             	and    $0x2,%eax
80103d94:	85 c0                	test   %eax,%eax
80103d96:	74 15                	je     80103dad <mpinit+0xe6>
        bcpu = &cpus[ncpu];
80103d98:	a1 e0 3d 11 80       	mov    0x80113de0,%eax
80103d9d:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80103da3:	05 00 38 11 80       	add    $0x80113800,%eax
80103da8:	a3 64 c6 10 80       	mov    %eax,0x8010c664
      cpus[ncpu].id = ncpu;
80103dad:	a1 e0 3d 11 80       	mov    0x80113de0,%eax
80103db2:	8b 15 e0 3d 11 80    	mov    0x80113de0,%edx
80103db8:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80103dbe:	05 00 38 11 80       	add    $0x80113800,%eax
80103dc3:	88 10                	mov    %dl,(%eax)
      ncpu++;
80103dc5:	a1 e0 3d 11 80       	mov    0x80113de0,%eax
80103dca:	83 c0 01             	add    $0x1,%eax
80103dcd:	a3 e0 3d 11 80       	mov    %eax,0x80113de0
      p += sizeof(struct mpproc);
80103dd2:	83 45 f4 14          	addl   $0x14,-0xc(%ebp)
      continue;
80103dd6:	eb 42                	jmp    80103e1a <mpinit+0x153>
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
80103dd8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103ddb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      ioapicid = ioapic->apicno;
80103dde:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103de1:	0f b6 40 01          	movzbl 0x1(%eax),%eax
80103de5:	a2 e0 37 11 80       	mov    %al,0x801137e0
      p += sizeof(struct mpioapic);
80103dea:	83 45 f4 08          	addl   $0x8,-0xc(%ebp)
      continue;
80103dee:	eb 2a                	jmp    80103e1a <mpinit+0x153>
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103df0:	83 45 f4 08          	addl   $0x8,-0xc(%ebp)
      continue;
80103df4:	eb 24                	jmp    80103e1a <mpinit+0x153>
    default:
      cprintf("mpinit: unknown config type %x\n", *p);
80103df6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103df9:	0f b6 00             	movzbl (%eax),%eax
80103dfc:	0f b6 c0             	movzbl %al,%eax
80103dff:	83 ec 08             	sub    $0x8,%esp
80103e02:	50                   	push   %eax
80103e03:	68 94 8b 10 80       	push   $0x80108b94
80103e08:	e8 b5 c5 ff ff       	call   801003c2 <cprintf>
80103e0d:	83 c4 10             	add    $0x10,%esp
      ismp = 0;
80103e10:	c7 05 e4 37 11 80 00 	movl   $0x0,0x801137e4
80103e17:	00 00 00 
  bcpu = &cpus[0];
  if((conf = mpconfig(&mp)) == 0)
    return;
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103e1a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103e1d:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80103e20:	0f 82 02 ff ff ff    	jb     80103d28 <mpinit+0x61>
    default:
      cprintf("mpinit: unknown config type %x\n", *p);
      ismp = 0;
    }
  }
  if(!ismp){
80103e26:	a1 e4 37 11 80       	mov    0x801137e4,%eax
80103e2b:	85 c0                	test   %eax,%eax
80103e2d:	75 1d                	jne    80103e4c <mpinit+0x185>
    // Didn't like what we found; fall back to no MP.
    ncpu = 1;
80103e2f:	c7 05 e0 3d 11 80 01 	movl   $0x1,0x80113de0
80103e36:	00 00 00 
    lapic = 0;
80103e39:	c7 05 dc 36 11 80 00 	movl   $0x0,0x801136dc
80103e40:	00 00 00 
    ioapicid = 0;
80103e43:	c6 05 e0 37 11 80 00 	movb   $0x0,0x801137e0
    return;
80103e4a:	eb 3e                	jmp    80103e8a <mpinit+0x1c3>
  }

  if(mp->imcrp){
80103e4c:	8b 45 e0             	mov    -0x20(%ebp),%eax
80103e4f:	0f b6 40 0c          	movzbl 0xc(%eax),%eax
80103e53:	84 c0                	test   %al,%al
80103e55:	74 33                	je     80103e8a <mpinit+0x1c3>
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
80103e57:	83 ec 08             	sub    $0x8,%esp
80103e5a:	6a 70                	push   $0x70
80103e5c:	6a 22                	push   $0x22
80103e5e:	e8 1c fc ff ff       	call   80103a7f <outb>
80103e63:	83 c4 10             	add    $0x10,%esp
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80103e66:	83 ec 0c             	sub    $0xc,%esp
80103e69:	6a 23                	push   $0x23
80103e6b:	e8 f2 fb ff ff       	call   80103a62 <inb>
80103e70:	83 c4 10             	add    $0x10,%esp
80103e73:	83 c8 01             	or     $0x1,%eax
80103e76:	0f b6 c0             	movzbl %al,%eax
80103e79:	83 ec 08             	sub    $0x8,%esp
80103e7c:	50                   	push   %eax
80103e7d:	6a 23                	push   $0x23
80103e7f:	e8 fb fb ff ff       	call   80103a7f <outb>
80103e84:	83 c4 10             	add    $0x10,%esp
80103e87:	eb 01                	jmp    80103e8a <mpinit+0x1c3>
  struct mpproc *proc;
  struct mpioapic *ioapic;

  bcpu = &cpus[0];
  if((conf = mpconfig(&mp)) == 0)
    return;
80103e89:	90                   	nop
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
  }
}
80103e8a:	c9                   	leave  
80103e8b:	c3                   	ret    

80103e8c <outb>:
80103e8c:	55                   	push   %ebp
80103e8d:	89 e5                	mov    %esp,%ebp
80103e8f:	83 ec 08             	sub    $0x8,%esp
80103e92:	8b 55 08             	mov    0x8(%ebp),%edx
80103e95:	8b 45 0c             	mov    0xc(%ebp),%eax
80103e98:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80103e9c:	88 45 f8             	mov    %al,-0x8(%ebp)
80103e9f:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80103ea3:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80103ea7:	ee                   	out    %al,(%dx)
80103ea8:	c9                   	leave  
80103ea9:	c3                   	ret    

80103eaa <picsetmask>:
80103eaa:	55                   	push   %ebp
80103eab:	89 e5                	mov    %esp,%ebp
80103ead:	83 ec 04             	sub    $0x4,%esp
80103eb0:	8b 45 08             	mov    0x8(%ebp),%eax
80103eb3:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
80103eb7:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80103ebb:	66 a3 00 c0 10 80    	mov    %ax,0x8010c000
80103ec1:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80103ec5:	0f b6 c0             	movzbl %al,%eax
80103ec8:	50                   	push   %eax
80103ec9:	6a 21                	push   $0x21
80103ecb:	e8 bc ff ff ff       	call   80103e8c <outb>
80103ed0:	83 c4 08             	add    $0x8,%esp
80103ed3:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80103ed7:	66 c1 e8 08          	shr    $0x8,%ax
80103edb:	0f b6 c0             	movzbl %al,%eax
80103ede:	50                   	push   %eax
80103edf:	68 a1 00 00 00       	push   $0xa1
80103ee4:	e8 a3 ff ff ff       	call   80103e8c <outb>
80103ee9:	83 c4 08             	add    $0x8,%esp
80103eec:	c9                   	leave  
80103eed:	c3                   	ret    

80103eee <picenable>:
80103eee:	55                   	push   %ebp
80103eef:	89 e5                	mov    %esp,%ebp
80103ef1:	8b 45 08             	mov    0x8(%ebp),%eax
80103ef4:	ba 01 00 00 00       	mov    $0x1,%edx
80103ef9:	89 c1                	mov    %eax,%ecx
80103efb:	d3 e2                	shl    %cl,%edx
80103efd:	89 d0                	mov    %edx,%eax
80103eff:	f7 d0                	not    %eax
80103f01:	89 c2                	mov    %eax,%edx
80103f03:	0f b7 05 00 c0 10 80 	movzwl 0x8010c000,%eax
80103f0a:	21 d0                	and    %edx,%eax
80103f0c:	0f b7 c0             	movzwl %ax,%eax
80103f0f:	50                   	push   %eax
80103f10:	e8 95 ff ff ff       	call   80103eaa <picsetmask>
80103f15:	83 c4 04             	add    $0x4,%esp
80103f18:	c9                   	leave  
80103f19:	c3                   	ret    

80103f1a <picinit>:
80103f1a:	55                   	push   %ebp
80103f1b:	89 e5                	mov    %esp,%ebp
80103f1d:	68 ff 00 00 00       	push   $0xff
80103f22:	6a 21                	push   $0x21
80103f24:	e8 63 ff ff ff       	call   80103e8c <outb>
80103f29:	83 c4 08             	add    $0x8,%esp
80103f2c:	68 ff 00 00 00       	push   $0xff
80103f31:	68 a1 00 00 00       	push   $0xa1
80103f36:	e8 51 ff ff ff       	call   80103e8c <outb>
80103f3b:	83 c4 08             	add    $0x8,%esp
80103f3e:	6a 11                	push   $0x11
80103f40:	6a 20                	push   $0x20
80103f42:	e8 45 ff ff ff       	call   80103e8c <outb>
80103f47:	83 c4 08             	add    $0x8,%esp
80103f4a:	6a 20                	push   $0x20
80103f4c:	6a 21                	push   $0x21
80103f4e:	e8 39 ff ff ff       	call   80103e8c <outb>
80103f53:	83 c4 08             	add    $0x8,%esp
80103f56:	6a 04                	push   $0x4
80103f58:	6a 21                	push   $0x21
80103f5a:	e8 2d ff ff ff       	call   80103e8c <outb>
80103f5f:	83 c4 08             	add    $0x8,%esp
80103f62:	6a 03                	push   $0x3
80103f64:	6a 21                	push   $0x21
80103f66:	e8 21 ff ff ff       	call   80103e8c <outb>
80103f6b:	83 c4 08             	add    $0x8,%esp
80103f6e:	6a 11                	push   $0x11
80103f70:	68 a0 00 00 00       	push   $0xa0
80103f75:	e8 12 ff ff ff       	call   80103e8c <outb>
80103f7a:	83 c4 08             	add    $0x8,%esp
80103f7d:	6a 28                	push   $0x28
80103f7f:	68 a1 00 00 00       	push   $0xa1
80103f84:	e8 03 ff ff ff       	call   80103e8c <outb>
80103f89:	83 c4 08             	add    $0x8,%esp
80103f8c:	6a 02                	push   $0x2
80103f8e:	68 a1 00 00 00       	push   $0xa1
80103f93:	e8 f4 fe ff ff       	call   80103e8c <outb>
80103f98:	83 c4 08             	add    $0x8,%esp
80103f9b:	6a 03                	push   $0x3
80103f9d:	68 a1 00 00 00       	push   $0xa1
80103fa2:	e8 e5 fe ff ff       	call   80103e8c <outb>
80103fa7:	83 c4 08             	add    $0x8,%esp
80103faa:	6a 68                	push   $0x68
80103fac:	6a 20                	push   $0x20
80103fae:	e8 d9 fe ff ff       	call   80103e8c <outb>
80103fb3:	83 c4 08             	add    $0x8,%esp
80103fb6:	6a 0a                	push   $0xa
80103fb8:	6a 20                	push   $0x20
80103fba:	e8 cd fe ff ff       	call   80103e8c <outb>
80103fbf:	83 c4 08             	add    $0x8,%esp
80103fc2:	6a 68                	push   $0x68
80103fc4:	68 a0 00 00 00       	push   $0xa0
80103fc9:	e8 be fe ff ff       	call   80103e8c <outb>
80103fce:	83 c4 08             	add    $0x8,%esp
80103fd1:	6a 0a                	push   $0xa
80103fd3:	68 a0 00 00 00       	push   $0xa0
80103fd8:	e8 af fe ff ff       	call   80103e8c <outb>
80103fdd:	83 c4 08             	add    $0x8,%esp
80103fe0:	0f b7 05 00 c0 10 80 	movzwl 0x8010c000,%eax
80103fe7:	66 83 f8 ff          	cmp    $0xffff,%ax
80103feb:	74 13                	je     80104000 <picinit+0xe6>
80103fed:	0f b7 05 00 c0 10 80 	movzwl 0x8010c000,%eax
80103ff4:	0f b7 c0             	movzwl %ax,%eax
80103ff7:	50                   	push   %eax
80103ff8:	e8 ad fe ff ff       	call   80103eaa <picsetmask>
80103ffd:	83 c4 04             	add    $0x4,%esp
80104000:	c9                   	leave  
80104001:	c3                   	ret    

80104002 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80104002:	55                   	push   %ebp
80104003:	89 e5                	mov    %esp,%ebp
80104005:	83 ec 18             	sub    $0x18,%esp
  struct pipe *p;

  p = 0;
80104008:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  *f0 = *f1 = 0;
8010400f:	8b 45 0c             	mov    0xc(%ebp),%eax
80104012:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104018:	8b 45 0c             	mov    0xc(%ebp),%eax
8010401b:	8b 10                	mov    (%eax),%edx
8010401d:	8b 45 08             	mov    0x8(%ebp),%eax
80104020:	89 10                	mov    %edx,(%eax)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
80104022:	e8 4c cf ff ff       	call   80100f73 <filealloc>
80104027:	89 c2                	mov    %eax,%edx
80104029:	8b 45 08             	mov    0x8(%ebp),%eax
8010402c:	89 10                	mov    %edx,(%eax)
8010402e:	8b 45 08             	mov    0x8(%ebp),%eax
80104031:	8b 00                	mov    (%eax),%eax
80104033:	85 c0                	test   %eax,%eax
80104035:	0f 84 cb 00 00 00    	je     80104106 <pipealloc+0x104>
8010403b:	e8 33 cf ff ff       	call   80100f73 <filealloc>
80104040:	89 c2                	mov    %eax,%edx
80104042:	8b 45 0c             	mov    0xc(%ebp),%eax
80104045:	89 10                	mov    %edx,(%eax)
80104047:	8b 45 0c             	mov    0xc(%ebp),%eax
8010404a:	8b 00                	mov    (%eax),%eax
8010404c:	85 c0                	test   %eax,%eax
8010404e:	0f 84 b2 00 00 00    	je     80104106 <pipealloc+0x104>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80104054:	e8 e3 eb ff ff       	call   80102c3c <kalloc>
80104059:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010405c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80104060:	0f 84 9f 00 00 00    	je     80104105 <pipealloc+0x103>
    goto bad;
  p->readopen = 1;
80104066:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104069:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
80104070:	00 00 00 
  p->writeopen = 1;
80104073:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104076:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
8010407d:	00 00 00 
  p->nwrite = 0;
80104080:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104083:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
8010408a:	00 00 00 
  p->nread = 0;
8010408d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104090:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80104097:	00 00 00 
  initlock(&p->lock, "pipe");
8010409a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010409d:	83 ec 08             	sub    $0x8,%esp
801040a0:	68 c8 8b 10 80       	push   $0x80108bc8
801040a5:	50                   	push   %eax
801040a6:	e8 8f 12 00 00       	call   8010533a <initlock>
801040ab:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
801040ae:	8b 45 08             	mov    0x8(%ebp),%eax
801040b1:	8b 00                	mov    (%eax),%eax
801040b3:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
801040b9:	8b 45 08             	mov    0x8(%ebp),%eax
801040bc:	8b 00                	mov    (%eax),%eax
801040be:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
801040c2:	8b 45 08             	mov    0x8(%ebp),%eax
801040c5:	8b 00                	mov    (%eax),%eax
801040c7:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
801040cb:	8b 45 08             	mov    0x8(%ebp),%eax
801040ce:	8b 00                	mov    (%eax),%eax
801040d0:	8b 55 f4             	mov    -0xc(%ebp),%edx
801040d3:	89 50 0c             	mov    %edx,0xc(%eax)
  (*f1)->type = FD_PIPE;
801040d6:	8b 45 0c             	mov    0xc(%ebp),%eax
801040d9:	8b 00                	mov    (%eax),%eax
801040db:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
801040e1:	8b 45 0c             	mov    0xc(%ebp),%eax
801040e4:	8b 00                	mov    (%eax),%eax
801040e6:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
801040ea:	8b 45 0c             	mov    0xc(%ebp),%eax
801040ed:	8b 00                	mov    (%eax),%eax
801040ef:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
801040f3:	8b 45 0c             	mov    0xc(%ebp),%eax
801040f6:	8b 00                	mov    (%eax),%eax
801040f8:	8b 55 f4             	mov    -0xc(%ebp),%edx
801040fb:	89 50 0c             	mov    %edx,0xc(%eax)
  return 0;
801040fe:	b8 00 00 00 00       	mov    $0x0,%eax
80104103:	eb 4e                	jmp    80104153 <pipealloc+0x151>
  p = 0;
  *f0 = *f1 = 0;
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
    goto bad;
80104105:	90                   	nop
  (*f1)->pipe = p;
  return 0;

//PAGEBREAK: 20
 bad:
  if(p)
80104106:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010410a:	74 0e                	je     8010411a <pipealloc+0x118>
    kfree((char*)p);
8010410c:	83 ec 0c             	sub    $0xc,%esp
8010410f:	ff 75 f4             	pushl  -0xc(%ebp)
80104112:	e8 89 ea ff ff       	call   80102ba0 <kfree>
80104117:	83 c4 10             	add    $0x10,%esp
  if(*f0)
8010411a:	8b 45 08             	mov    0x8(%ebp),%eax
8010411d:	8b 00                	mov    (%eax),%eax
8010411f:	85 c0                	test   %eax,%eax
80104121:	74 11                	je     80104134 <pipealloc+0x132>
    fileclose(*f0);
80104123:	8b 45 08             	mov    0x8(%ebp),%eax
80104126:	8b 00                	mov    (%eax),%eax
80104128:	83 ec 0c             	sub    $0xc,%esp
8010412b:	50                   	push   %eax
8010412c:	e8 ff ce ff ff       	call   80101030 <fileclose>
80104131:	83 c4 10             	add    $0x10,%esp
  if(*f1)
80104134:	8b 45 0c             	mov    0xc(%ebp),%eax
80104137:	8b 00                	mov    (%eax),%eax
80104139:	85 c0                	test   %eax,%eax
8010413b:	74 11                	je     8010414e <pipealloc+0x14c>
    fileclose(*f1);
8010413d:	8b 45 0c             	mov    0xc(%ebp),%eax
80104140:	8b 00                	mov    (%eax),%eax
80104142:	83 ec 0c             	sub    $0xc,%esp
80104145:	50                   	push   %eax
80104146:	e8 e5 ce ff ff       	call   80101030 <fileclose>
8010414b:	83 c4 10             	add    $0x10,%esp
  return -1;
8010414e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104153:	c9                   	leave  
80104154:	c3                   	ret    

80104155 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80104155:	55                   	push   %ebp
80104156:	89 e5                	mov    %esp,%ebp
80104158:	83 ec 08             	sub    $0x8,%esp
  acquire(&p->lock);
8010415b:	8b 45 08             	mov    0x8(%ebp),%eax
8010415e:	83 ec 0c             	sub    $0xc,%esp
80104161:	50                   	push   %eax
80104162:	e8 f5 11 00 00       	call   8010535c <acquire>
80104167:	83 c4 10             	add    $0x10,%esp
  if(writable){
8010416a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
8010416e:	74 23                	je     80104193 <pipeclose+0x3e>
    p->writeopen = 0;
80104170:	8b 45 08             	mov    0x8(%ebp),%eax
80104173:	c7 80 40 02 00 00 00 	movl   $0x0,0x240(%eax)
8010417a:	00 00 00 
    wakeup(&p->nread);
8010417d:	8b 45 08             	mov    0x8(%ebp),%eax
80104180:	05 34 02 00 00       	add    $0x234,%eax
80104185:	83 ec 0c             	sub    $0xc,%esp
80104188:	50                   	push   %eax
80104189:	e8 8b 0f 00 00       	call   80105119 <wakeup>
8010418e:	83 c4 10             	add    $0x10,%esp
80104191:	eb 21                	jmp    801041b4 <pipeclose+0x5f>
  } else {
    p->readopen = 0;
80104193:	8b 45 08             	mov    0x8(%ebp),%eax
80104196:	c7 80 3c 02 00 00 00 	movl   $0x0,0x23c(%eax)
8010419d:	00 00 00 
    wakeup(&p->nwrite);
801041a0:	8b 45 08             	mov    0x8(%ebp),%eax
801041a3:	05 38 02 00 00       	add    $0x238,%eax
801041a8:	83 ec 0c             	sub    $0xc,%esp
801041ab:	50                   	push   %eax
801041ac:	e8 68 0f 00 00       	call   80105119 <wakeup>
801041b1:	83 c4 10             	add    $0x10,%esp
  }
  if(p->readopen == 0 && p->writeopen == 0){
801041b4:	8b 45 08             	mov    0x8(%ebp),%eax
801041b7:	8b 80 3c 02 00 00    	mov    0x23c(%eax),%eax
801041bd:	85 c0                	test   %eax,%eax
801041bf:	75 2c                	jne    801041ed <pipeclose+0x98>
801041c1:	8b 45 08             	mov    0x8(%ebp),%eax
801041c4:	8b 80 40 02 00 00    	mov    0x240(%eax),%eax
801041ca:	85 c0                	test   %eax,%eax
801041cc:	75 1f                	jne    801041ed <pipeclose+0x98>
    release(&p->lock);
801041ce:	8b 45 08             	mov    0x8(%ebp),%eax
801041d1:	83 ec 0c             	sub    $0xc,%esp
801041d4:	50                   	push   %eax
801041d5:	e8 e9 11 00 00       	call   801053c3 <release>
801041da:	83 c4 10             	add    $0x10,%esp
    kfree((char*)p);
801041dd:	83 ec 0c             	sub    $0xc,%esp
801041e0:	ff 75 08             	pushl  0x8(%ebp)
801041e3:	e8 b8 e9 ff ff       	call   80102ba0 <kfree>
801041e8:	83 c4 10             	add    $0x10,%esp
801041eb:	eb 0f                	jmp    801041fc <pipeclose+0xa7>
  } else
    release(&p->lock);
801041ed:	8b 45 08             	mov    0x8(%ebp),%eax
801041f0:	83 ec 0c             	sub    $0xc,%esp
801041f3:	50                   	push   %eax
801041f4:	e8 ca 11 00 00       	call   801053c3 <release>
801041f9:	83 c4 10             	add    $0x10,%esp
}
801041fc:	90                   	nop
801041fd:	c9                   	leave  
801041fe:	c3                   	ret    

801041ff <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
801041ff:	55                   	push   %ebp
80104200:	89 e5                	mov    %esp,%ebp
80104202:	83 ec 18             	sub    $0x18,%esp
  int i;

  acquire(&p->lock);
80104205:	8b 45 08             	mov    0x8(%ebp),%eax
80104208:	83 ec 0c             	sub    $0xc,%esp
8010420b:	50                   	push   %eax
8010420c:	e8 4b 11 00 00       	call   8010535c <acquire>
80104211:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < n; i++){
80104214:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010421b:	e9 ad 00 00 00       	jmp    801042cd <pipewrite+0xce>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || proc->killed){
80104220:	8b 45 08             	mov    0x8(%ebp),%eax
80104223:	8b 80 3c 02 00 00    	mov    0x23c(%eax),%eax
80104229:	85 c0                	test   %eax,%eax
8010422b:	74 0d                	je     8010423a <pipewrite+0x3b>
8010422d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104233:	8b 40 24             	mov    0x24(%eax),%eax
80104236:	85 c0                	test   %eax,%eax
80104238:	74 19                	je     80104253 <pipewrite+0x54>
        release(&p->lock);
8010423a:	8b 45 08             	mov    0x8(%ebp),%eax
8010423d:	83 ec 0c             	sub    $0xc,%esp
80104240:	50                   	push   %eax
80104241:	e8 7d 11 00 00       	call   801053c3 <release>
80104246:	83 c4 10             	add    $0x10,%esp
        return -1;
80104249:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010424e:	e9 a8 00 00 00       	jmp    801042fb <pipewrite+0xfc>
      }
      wakeup(&p->nread);
80104253:	8b 45 08             	mov    0x8(%ebp),%eax
80104256:	05 34 02 00 00       	add    $0x234,%eax
8010425b:	83 ec 0c             	sub    $0xc,%esp
8010425e:	50                   	push   %eax
8010425f:	e8 b5 0e 00 00       	call   80105119 <wakeup>
80104264:	83 c4 10             	add    $0x10,%esp
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80104267:	8b 45 08             	mov    0x8(%ebp),%eax
8010426a:	8b 55 08             	mov    0x8(%ebp),%edx
8010426d:	81 c2 38 02 00 00    	add    $0x238,%edx
80104273:	83 ec 08             	sub    $0x8,%esp
80104276:	50                   	push   %eax
80104277:	52                   	push   %edx
80104278:	e8 a0 0d 00 00       	call   8010501d <sleep>
8010427d:	83 c4 10             	add    $0x10,%esp
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80104280:	8b 45 08             	mov    0x8(%ebp),%eax
80104283:	8b 90 38 02 00 00    	mov    0x238(%eax),%edx
80104289:	8b 45 08             	mov    0x8(%ebp),%eax
8010428c:	8b 80 34 02 00 00    	mov    0x234(%eax),%eax
80104292:	05 00 02 00 00       	add    $0x200,%eax
80104297:	39 c2                	cmp    %eax,%edx
80104299:	74 85                	je     80104220 <pipewrite+0x21>
        return -1;
      }
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
8010429b:	8b 45 08             	mov    0x8(%ebp),%eax
8010429e:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
801042a4:	8d 48 01             	lea    0x1(%eax),%ecx
801042a7:	8b 55 08             	mov    0x8(%ebp),%edx
801042aa:	89 8a 38 02 00 00    	mov    %ecx,0x238(%edx)
801042b0:	25 ff 01 00 00       	and    $0x1ff,%eax
801042b5:	89 c1                	mov    %eax,%ecx
801042b7:	8b 55 f4             	mov    -0xc(%ebp),%edx
801042ba:	8b 45 0c             	mov    0xc(%ebp),%eax
801042bd:	01 d0                	add    %edx,%eax
801042bf:	0f b6 10             	movzbl (%eax),%edx
801042c2:	8b 45 08             	mov    0x8(%ebp),%eax
801042c5:	88 54 08 34          	mov    %dl,0x34(%eax,%ecx,1)
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
801042c9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801042cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801042d0:	3b 45 10             	cmp    0x10(%ebp),%eax
801042d3:	7c ab                	jl     80104280 <pipewrite+0x81>
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
801042d5:	8b 45 08             	mov    0x8(%ebp),%eax
801042d8:	05 34 02 00 00       	add    $0x234,%eax
801042dd:	83 ec 0c             	sub    $0xc,%esp
801042e0:	50                   	push   %eax
801042e1:	e8 33 0e 00 00       	call   80105119 <wakeup>
801042e6:	83 c4 10             	add    $0x10,%esp
  release(&p->lock);
801042e9:	8b 45 08             	mov    0x8(%ebp),%eax
801042ec:	83 ec 0c             	sub    $0xc,%esp
801042ef:	50                   	push   %eax
801042f0:	e8 ce 10 00 00       	call   801053c3 <release>
801042f5:	83 c4 10             	add    $0x10,%esp
  return n;
801042f8:	8b 45 10             	mov    0x10(%ebp),%eax
}
801042fb:	c9                   	leave  
801042fc:	c3                   	ret    

801042fd <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
801042fd:	55                   	push   %ebp
801042fe:	89 e5                	mov    %esp,%ebp
80104300:	53                   	push   %ebx
80104301:	83 ec 14             	sub    $0x14,%esp
  int i;

  acquire(&p->lock);
80104304:	8b 45 08             	mov    0x8(%ebp),%eax
80104307:	83 ec 0c             	sub    $0xc,%esp
8010430a:	50                   	push   %eax
8010430b:	e8 4c 10 00 00       	call   8010535c <acquire>
80104310:	83 c4 10             	add    $0x10,%esp
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80104313:	eb 3f                	jmp    80104354 <piperead+0x57>
    if(proc->killed){
80104315:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010431b:	8b 40 24             	mov    0x24(%eax),%eax
8010431e:	85 c0                	test   %eax,%eax
80104320:	74 19                	je     8010433b <piperead+0x3e>
      release(&p->lock);
80104322:	8b 45 08             	mov    0x8(%ebp),%eax
80104325:	83 ec 0c             	sub    $0xc,%esp
80104328:	50                   	push   %eax
80104329:	e8 95 10 00 00       	call   801053c3 <release>
8010432e:	83 c4 10             	add    $0x10,%esp
      return -1;
80104331:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104336:	e9 bf 00 00 00       	jmp    801043fa <piperead+0xfd>
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
8010433b:	8b 45 08             	mov    0x8(%ebp),%eax
8010433e:	8b 55 08             	mov    0x8(%ebp),%edx
80104341:	81 c2 34 02 00 00    	add    $0x234,%edx
80104347:	83 ec 08             	sub    $0x8,%esp
8010434a:	50                   	push   %eax
8010434b:	52                   	push   %edx
8010434c:	e8 cc 0c 00 00       	call   8010501d <sleep>
80104351:	83 c4 10             	add    $0x10,%esp
piperead(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80104354:	8b 45 08             	mov    0x8(%ebp),%eax
80104357:	8b 90 34 02 00 00    	mov    0x234(%eax),%edx
8010435d:	8b 45 08             	mov    0x8(%ebp),%eax
80104360:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
80104366:	39 c2                	cmp    %eax,%edx
80104368:	75 0d                	jne    80104377 <piperead+0x7a>
8010436a:	8b 45 08             	mov    0x8(%ebp),%eax
8010436d:	8b 80 40 02 00 00    	mov    0x240(%eax),%eax
80104373:	85 c0                	test   %eax,%eax
80104375:	75 9e                	jne    80104315 <piperead+0x18>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80104377:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010437e:	eb 49                	jmp    801043c9 <piperead+0xcc>
    if(p->nread == p->nwrite)
80104380:	8b 45 08             	mov    0x8(%ebp),%eax
80104383:	8b 90 34 02 00 00    	mov    0x234(%eax),%edx
80104389:	8b 45 08             	mov    0x8(%ebp),%eax
8010438c:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
80104392:	39 c2                	cmp    %eax,%edx
80104394:	74 3d                	je     801043d3 <piperead+0xd6>
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80104396:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104399:	8b 45 0c             	mov    0xc(%ebp),%eax
8010439c:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
8010439f:	8b 45 08             	mov    0x8(%ebp),%eax
801043a2:	8b 80 34 02 00 00    	mov    0x234(%eax),%eax
801043a8:	8d 48 01             	lea    0x1(%eax),%ecx
801043ab:	8b 55 08             	mov    0x8(%ebp),%edx
801043ae:	89 8a 34 02 00 00    	mov    %ecx,0x234(%edx)
801043b4:	25 ff 01 00 00       	and    $0x1ff,%eax
801043b9:	89 c2                	mov    %eax,%edx
801043bb:	8b 45 08             	mov    0x8(%ebp),%eax
801043be:	0f b6 44 10 34       	movzbl 0x34(%eax,%edx,1),%eax
801043c3:	88 03                	mov    %al,(%ebx)
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801043c5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801043c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801043cc:	3b 45 10             	cmp    0x10(%ebp),%eax
801043cf:	7c af                	jl     80104380 <piperead+0x83>
801043d1:	eb 01                	jmp    801043d4 <piperead+0xd7>
    if(p->nread == p->nwrite)
      break;
801043d3:	90                   	nop
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
801043d4:	8b 45 08             	mov    0x8(%ebp),%eax
801043d7:	05 38 02 00 00       	add    $0x238,%eax
801043dc:	83 ec 0c             	sub    $0xc,%esp
801043df:	50                   	push   %eax
801043e0:	e8 34 0d 00 00       	call   80105119 <wakeup>
801043e5:	83 c4 10             	add    $0x10,%esp
  release(&p->lock);
801043e8:	8b 45 08             	mov    0x8(%ebp),%eax
801043eb:	83 ec 0c             	sub    $0xc,%esp
801043ee:	50                   	push   %eax
801043ef:	e8 cf 0f 00 00       	call   801053c3 <release>
801043f4:	83 c4 10             	add    $0x10,%esp
  return i;
801043f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801043fa:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801043fd:	c9                   	leave  
801043fe:	c3                   	ret    

801043ff <readeflags>:
  asm volatile("ltr %0" : : "r" (sel));
}

static inline uint
readeflags(void)
{
801043ff:	55                   	push   %ebp
80104400:	89 e5                	mov    %esp,%ebp
80104402:	83 ec 10             	sub    $0x10,%esp
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104405:	9c                   	pushf  
80104406:	58                   	pop    %eax
80104407:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return eflags;
8010440a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
8010440d:	c9                   	leave  
8010440e:	c3                   	ret    

8010440f <sti>:
  asm volatile("cli");
}

static inline void
sti(void)
{
8010440f:	55                   	push   %ebp
80104410:	89 e5                	mov    %esp,%ebp
  asm volatile("sti");
80104412:	fb                   	sti    
}
80104413:	90                   	nop
80104414:	5d                   	pop    %ebp
80104415:	c3                   	ret    

80104416 <initFila>:
} fila;

static fila filaLow, filaMedium, filaHigh;

// Inicializa fila de processos
void initFila(fila* pfila, char* lockKey){
80104416:	55                   	push   %ebp
80104417:	89 e5                	mov    %esp,%ebp
80104419:	83 ec 08             	sub    $0x8,%esp
  initlock(&pfila->lock, lockKey);
8010441c:	8b 45 08             	mov    0x8(%ebp),%eax
8010441f:	83 ec 08             	sub    $0x8,%esp
80104422:	ff 75 0c             	pushl  0xc(%ebp)
80104425:	50                   	push   %eax
80104426:	e8 0f 0f 00 00       	call   8010533a <initlock>
8010442b:	83 c4 10             	add    $0x10,%esp
  pfila->inicio = 0;
8010442e:	8b 45 08             	mov    0x8(%ebp),%eax
80104431:	c7 80 34 01 00 00 00 	movl   $0x0,0x134(%eax)
80104438:	00 00 00 
  pfila->fim = NPROC-1;
8010443b:	8b 45 08             	mov    0x8(%ebp),%eax
8010443e:	c7 80 38 01 00 00 3f 	movl   $0x3f,0x138(%eax)
80104445:	00 00 00 
  pfila->num = 0;
80104448:	8b 45 08             	mov    0x8(%ebp),%eax
8010444b:	c7 80 3c 01 00 00 00 	movl   $0x0,0x13c(%eax)
80104452:	00 00 00 
}
80104455:	90                   	nop
80104456:	c9                   	leave  
80104457:	c3                   	ret    

80104458 <inserir>:

//Insere o processo sempre no final da fila escolhida.
void inserir(fila* pfila, struct proc * x){
80104458:	55                   	push   %ebp
80104459:	89 e5                	mov    %esp,%ebp
8010445b:	83 ec 08             	sub    $0x8,%esp
	acquire(&pfila->lock);
8010445e:	8b 45 08             	mov    0x8(%ebp),%eax
80104461:	83 ec 0c             	sub    $0xc,%esp
80104464:	50                   	push   %eax
80104465:	e8 f2 0e 00 00       	call   8010535c <acquire>
8010446a:	83 c4 10             	add    $0x10,%esp
	if (pfila->num < NPROC){
8010446d:	8b 45 08             	mov    0x8(%ebp),%eax
80104470:	8b 80 3c 01 00 00    	mov    0x13c(%eax),%eax
80104476:	83 f8 3f             	cmp    $0x3f,%eax
80104479:	7f 53                	jg     801044ce <inserir+0x76>
		pfila->fim = (pfila->fim+1) % NPROC;
8010447b:	8b 45 08             	mov    0x8(%ebp),%eax
8010447e:	8b 80 38 01 00 00    	mov    0x138(%eax),%eax
80104484:	8d 50 01             	lea    0x1(%eax),%edx
80104487:	89 d0                	mov    %edx,%eax
80104489:	c1 f8 1f             	sar    $0x1f,%eax
8010448c:	c1 e8 1a             	shr    $0x1a,%eax
8010448f:	01 c2                	add    %eax,%edx
80104491:	83 e2 3f             	and    $0x3f,%edx
80104494:	29 c2                	sub    %eax,%edx
80104496:	89 d0                	mov    %edx,%eax
80104498:	89 c2                	mov    %eax,%edx
8010449a:	8b 45 08             	mov    0x8(%ebp),%eax
8010449d:	89 90 38 01 00 00    	mov    %edx,0x138(%eax)
		pfila->vp[ pfila->fim ] = x;  
801044a3:	8b 45 08             	mov    0x8(%ebp),%eax
801044a6:	8b 90 38 01 00 00    	mov    0x138(%eax),%edx
801044ac:	8b 45 08             	mov    0x8(%ebp),%eax
801044af:	8d 4a 0c             	lea    0xc(%edx),%ecx
801044b2:	8b 55 0c             	mov    0xc(%ebp),%edx
801044b5:	89 54 88 04          	mov    %edx,0x4(%eax,%ecx,4)
		pfila->num = pfila->num + 1;
801044b9:	8b 45 08             	mov    0x8(%ebp),%eax
801044bc:	8b 80 3c 01 00 00    	mov    0x13c(%eax),%eax
801044c2:	8d 50 01             	lea    0x1(%eax),%edx
801044c5:	8b 45 08             	mov    0x8(%ebp),%eax
801044c8:	89 90 3c 01 00 00    	mov    %edx,0x13c(%eax)
	}
	release(&pfila->lock);
801044ce:	8b 45 08             	mov    0x8(%ebp),%eax
801044d1:	83 ec 0c             	sub    $0xc,%esp
801044d4:	50                   	push   %eax
801044d5:	e8 e9 0e 00 00       	call   801053c3 <release>
801044da:	83 c4 10             	add    $0x10,%esp
}
801044dd:	90                   	nop
801044de:	c9                   	leave  
801044df:	c3                   	ret    

801044e0 <remover>:

//Remove sempre o processo que esta no inicio da fila escolhida.
struct proc * remover(fila* pfila){
801044e0:	55                   	push   %ebp
801044e1:	89 e5                	mov    %esp,%ebp
801044e3:	83 ec 18             	sub    $0x18,%esp
	acquire(&pfila->lock);
801044e6:	8b 45 08             	mov    0x8(%ebp),%eax
801044e9:	83 ec 0c             	sub    $0xc,%esp
801044ec:	50                   	push   %eax
801044ed:	e8 6a 0e 00 00       	call   8010535c <acquire>
801044f2:	83 c4 10             	add    $0x10,%esp
	struct proc * x;

	if (pfila->num > 0){
801044f5:	8b 45 08             	mov    0x8(%ebp),%eax
801044f8:	8b 80 3c 01 00 00    	mov    0x13c(%eax),%eax
801044fe:	85 c0                	test   %eax,%eax
80104500:	7e 53                	jle    80104555 <remover+0x75>
		x = pfila->vp[ pfila->inicio ];
80104502:	8b 45 08             	mov    0x8(%ebp),%eax
80104505:	8b 90 34 01 00 00    	mov    0x134(%eax),%edx
8010450b:	8b 45 08             	mov    0x8(%ebp),%eax
8010450e:	83 c2 0c             	add    $0xc,%edx
80104511:	8b 44 90 04          	mov    0x4(%eax,%edx,4),%eax
80104515:	89 45 f4             	mov    %eax,-0xc(%ebp)
		pfila->inicio = (pfila->inicio+1) % NPROC;
80104518:	8b 45 08             	mov    0x8(%ebp),%eax
8010451b:	8b 80 34 01 00 00    	mov    0x134(%eax),%eax
80104521:	8d 50 01             	lea    0x1(%eax),%edx
80104524:	89 d0                	mov    %edx,%eax
80104526:	c1 f8 1f             	sar    $0x1f,%eax
80104529:	c1 e8 1a             	shr    $0x1a,%eax
8010452c:	01 c2                	add    %eax,%edx
8010452e:	83 e2 3f             	and    $0x3f,%edx
80104531:	29 c2                	sub    %eax,%edx
80104533:	89 d0                	mov    %edx,%eax
80104535:	89 c2                	mov    %eax,%edx
80104537:	8b 45 08             	mov    0x8(%ebp),%eax
8010453a:	89 90 34 01 00 00    	mov    %edx,0x134(%eax)
		pfila->num = pfila->num - 1;
80104540:	8b 45 08             	mov    0x8(%ebp),%eax
80104543:	8b 80 3c 01 00 00    	mov    0x13c(%eax),%eax
80104549:	8d 50 ff             	lea    -0x1(%eax),%edx
8010454c:	8b 45 08             	mov    0x8(%ebp),%eax
8010454f:	89 90 3c 01 00 00    	mov    %edx,0x13c(%eax)
	}
	release(&pfila->lock);
80104555:	8b 45 08             	mov    0x8(%ebp),%eax
80104558:	83 ec 0c             	sub    $0xc,%esp
8010455b:	50                   	push   %eax
8010455c:	e8 62 0e 00 00       	call   801053c3 <release>
80104561:	83 c4 10             	add    $0x10,%esp
	return(x);
80104564:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80104567:	c9                   	leave  
80104568:	c3                   	ret    

80104569 <escolheFila>:

//Escolhe o processo a ser removido seguindo a ordem de prioridade das filas.
struct proc* escolheFila(){
80104569:	55                   	push   %ebp
8010456a:	89 e5                	mov    %esp,%ebp
8010456c:	83 ec 08             	sub    $0x8,%esp
  if(filaHigh.num > 0) 				return remover(&filaHigh);
8010456f:	a1 5c ca 10 80       	mov    0x8010ca5c,%eax
80104574:	85 c0                	test   %eax,%eax
80104576:	7e 12                	jle    8010458a <escolheFila+0x21>
80104578:	83 ec 0c             	sub    $0xc,%esp
8010457b:	68 20 c9 10 80       	push   $0x8010c920
80104580:	e8 5b ff ff ff       	call   801044e0 <remover>
80104585:	83 c4 10             	add    $0x10,%esp
80104588:	eb 3b                	jmp    801045c5 <escolheFila+0x5c>
  else if(filaMedium.num > 0)		return remover(&filaMedium); 
8010458a:	a1 1c c9 10 80       	mov    0x8010c91c,%eax
8010458f:	85 c0                	test   %eax,%eax
80104591:	7e 12                	jle    801045a5 <escolheFila+0x3c>
80104593:	83 ec 0c             	sub    $0xc,%esp
80104596:	68 e0 c7 10 80       	push   $0x8010c7e0
8010459b:	e8 40 ff ff ff       	call   801044e0 <remover>
801045a0:	83 c4 10             	add    $0x10,%esp
801045a3:	eb 20                	jmp    801045c5 <escolheFila+0x5c>
  else if(filaLow.num > 0)			return remover(&filaLow); 
801045a5:	a1 dc c7 10 80       	mov    0x8010c7dc,%eax
801045aa:	85 c0                	test   %eax,%eax
801045ac:	7e 12                	jle    801045c0 <escolheFila+0x57>
801045ae:	83 ec 0c             	sub    $0xc,%esp
801045b1:	68 a0 c6 10 80       	push   $0x8010c6a0
801045b6:	e8 25 ff ff ff       	call   801044e0 <remover>
801045bb:	83 c4 10             	add    $0x10,%esp
801045be:	eb 05                	jmp    801045c5 <escolheFila+0x5c>
  else 									return 0;
801045c0:	b8 00 00 00 00       	mov    $0x0,%eax
}
801045c5:	c9                   	leave  
801045c6:	c3                   	ret    

801045c7 <promover>:

//O processo será inserido ao final da fila de prioridade superior a sua atual.
void promover(struct proc *p){
801045c7:	55                   	push   %ebp
801045c8:	89 e5                	mov    %esp,%ebp
801045ca:	83 ec 08             	sub    $0x8,%esp
	if(p->priority == LOW){
801045cd:	8b 45 08             	mov    0x8(%ebp),%eax
801045d0:	8b 80 80 00 00 00    	mov    0x80(%eax),%eax
801045d6:	83 f8 02             	cmp    $0x2,%eax
801045d9:	75 22                	jne    801045fd <promover+0x36>
		p->priority = MEDIUM;								//Altera a prioridade do processo
801045db:	8b 45 08             	mov    0x8(%ebp),%eax
801045de:	c7 80 80 00 00 00 01 	movl   $0x1,0x80(%eax)
801045e5:	00 00 00 
		inserir(&filaMedium ,p); 							//Adiciona na fila de prioridade intermediaria
801045e8:	83 ec 08             	sub    $0x8,%esp
801045eb:	ff 75 08             	pushl  0x8(%ebp)
801045ee:	68 e0 c7 10 80       	push   $0x8010c7e0
801045f3:	e8 60 fe ff ff       	call   80104458 <inserir>
801045f8:	83 c4 10             	add    $0x10,%esp
	}else{
	  p->priority = HIGH;									//Altera a prioridade do processo
	  inserir(&filaHigh ,p);   							//Adiciona na fila de alta prioridade
	}  
}
801045fb:	eb 20                	jmp    8010461d <promover+0x56>
void promover(struct proc *p){
	if(p->priority == LOW){
		p->priority = MEDIUM;								//Altera a prioridade do processo
		inserir(&filaMedium ,p); 							//Adiciona na fila de prioridade intermediaria
	}else{
	  p->priority = HIGH;									//Altera a prioridade do processo
801045fd:	8b 45 08             	mov    0x8(%ebp),%eax
80104600:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80104607:	00 00 00 
	  inserir(&filaHigh ,p);   							//Adiciona na fila de alta prioridade
8010460a:	83 ec 08             	sub    $0x8,%esp
8010460d:	ff 75 08             	pushl  0x8(%ebp)
80104610:	68 20 c9 10 80       	push   $0x8010c920
80104615:	e8 3e fe ff ff       	call   80104458 <inserir>
8010461a:	83 c4 10             	add    $0x10,%esp
	}  
}
8010461d:	90                   	nop
8010461e:	c9                   	leave  
8010461f:	c3                   	ret    

80104620 <rebaixar>:

//O processo será inserido ao final da fila de prioridade inferior a sua atual.
void rebaixar(struct proc *p){
80104620:	55                   	push   %ebp
80104621:	89 e5                	mov    %esp,%ebp
80104623:	83 ec 08             	sub    $0x8,%esp
	if(p->priority == HIGH){
80104626:	8b 45 08             	mov    0x8(%ebp),%eax
80104629:	8b 80 80 00 00 00    	mov    0x80(%eax),%eax
8010462f:	85 c0                	test   %eax,%eax
80104631:	75 22                	jne    80104655 <rebaixar+0x35>
		p->priority = MEDIUM;			 				 //Altera a prioridade do processo
80104633:	8b 45 08             	mov    0x8(%ebp),%eax
80104636:	c7 80 80 00 00 00 01 	movl   $0x1,0x80(%eax)
8010463d:	00 00 00 
		inserir(&filaMedium, p);            		 //Adiciona na fila de prioridade intermediaria
80104640:	83 ec 08             	sub    $0x8,%esp
80104643:	ff 75 08             	pushl  0x8(%ebp)
80104646:	68 e0 c7 10 80       	push   $0x8010c7e0
8010464b:	e8 08 fe ff ff       	call   80104458 <inserir>
80104650:	83 c4 10             	add    $0x10,%esp
   }else{
		p->priority = LOW;								//Altera a prioridade do processo
		inserir(&filaLow, p);          				//Adiciona na fila de baixa prioridade
	}
}
80104653:	eb 20                	jmp    80104675 <rebaixar+0x55>
void rebaixar(struct proc *p){
	if(p->priority == HIGH){
		p->priority = MEDIUM;			 				 //Altera a prioridade do processo
		inserir(&filaMedium, p);            		 //Adiciona na fila de prioridade intermediaria
   }else{
		p->priority = LOW;								//Altera a prioridade do processo
80104655:	8b 45 08             	mov    0x8(%ebp),%eax
80104658:	c7 80 80 00 00 00 02 	movl   $0x2,0x80(%eax)
8010465f:	00 00 00 
		inserir(&filaLow, p);          				//Adiciona na fila de baixa prioridade
80104662:	83 ec 08             	sub    $0x8,%esp
80104665:	ff 75 08             	pushl  0x8(%ebp)
80104668:	68 a0 c6 10 80       	push   $0x8010c6a0
8010466d:	e8 e6 fd ff ff       	call   80104458 <inserir>
80104672:	83 c4 10             	add    $0x10,%esp
	}
}
80104675:	90                   	nop
80104676:	c9                   	leave  
80104677:	c3                   	ret    

80104678 <pinit>:


void
pinit(void)
{
80104678:	55                   	push   %ebp
80104679:	89 e5                	mov    %esp,%ebp
8010467b:	83 ec 08             	sub    $0x8,%esp
  initlock(&ptable.lock, "ptable");
8010467e:	83 ec 08             	sub    $0x8,%esp
80104681:	68 d0 8b 10 80       	push   $0x80108bd0
80104686:	68 00 3e 11 80       	push   $0x80113e00
8010468b:	e8 aa 0c 00 00       	call   8010533a <initlock>
80104690:	83 c4 10             	add    $0x10,%esp

  //Inicializa as filas de prioridade
  initFila(&filaLow, "LOW");
80104693:	83 ec 08             	sub    $0x8,%esp
80104696:	68 d7 8b 10 80       	push   $0x80108bd7
8010469b:	68 a0 c6 10 80       	push   $0x8010c6a0
801046a0:	e8 71 fd ff ff       	call   80104416 <initFila>
801046a5:	83 c4 10             	add    $0x10,%esp
  initFila(&filaHigh, "HIGH");
801046a8:	83 ec 08             	sub    $0x8,%esp
801046ab:	68 db 8b 10 80       	push   $0x80108bdb
801046b0:	68 20 c9 10 80       	push   $0x8010c920
801046b5:	e8 5c fd ff ff       	call   80104416 <initFila>
801046ba:	83 c4 10             	add    $0x10,%esp
  initFila(&filaMedium, "MEDIUM");
801046bd:	83 ec 08             	sub    $0x8,%esp
801046c0:	68 e0 8b 10 80       	push   $0x80108be0
801046c5:	68 e0 c7 10 80       	push   $0x8010c7e0
801046ca:	e8 47 fd ff ff       	call   80104416 <initFila>
801046cf:	83 c4 10             	add    $0x10,%esp
}
801046d2:	90                   	nop
801046d3:	c9                   	leave  
801046d4:	c3                   	ret    

801046d5 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
801046d5:	55                   	push   %ebp
801046d6:	89 e5                	mov    %esp,%ebp
801046d8:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
801046db:	83 ec 0c             	sub    $0xc,%esp
801046de:	68 00 3e 11 80       	push   $0x80113e00
801046e3:	e8 74 0c 00 00       	call   8010535c <acquire>
801046e8:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801046eb:	c7 45 f4 34 3e 11 80 	movl   $0x80113e34,-0xc(%ebp)
801046f2:	eb 11                	jmp    80104705 <allocproc+0x30>
    if(p->state == UNUSED)
801046f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801046f7:	8b 40 0c             	mov    0xc(%eax),%eax
801046fa:	85 c0                	test   %eax,%eax
801046fc:	74 2a                	je     80104728 <allocproc+0x53>
{
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801046fe:	81 45 f4 84 00 00 00 	addl   $0x84,-0xc(%ebp)
80104705:	81 7d f4 34 5f 11 80 	cmpl   $0x80115f34,-0xc(%ebp)
8010470c:	72 e6                	jb     801046f4 <allocproc+0x1f>
    if(p->state == UNUSED)
      goto found;
  release(&ptable.lock);
8010470e:	83 ec 0c             	sub    $0xc,%esp
80104711:	68 00 3e 11 80       	push   $0x80113e00
80104716:	e8 a8 0c 00 00       	call   801053c3 <release>
8010471b:	83 c4 10             	add    $0x10,%esp
  return 0;
8010471e:	b8 00 00 00 00       	mov    $0x0,%eax
80104723:	e9 b4 00 00 00       	jmp    801047dc <allocproc+0x107>
  char *sp;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;
80104728:	90                   	nop
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
80104729:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010472c:	c7 40 0c 01 00 00 00 	movl   $0x1,0xc(%eax)
  p->pid = nextpid++; 
80104733:	a1 04 c0 10 80       	mov    0x8010c004,%eax
80104738:	8d 50 01             	lea    0x1(%eax),%edx
8010473b:	89 15 04 c0 10 80    	mov    %edx,0x8010c004
80104741:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104744:	89 42 10             	mov    %eax,0x10(%edx)
  release(&ptable.lock);
80104747:	83 ec 0c             	sub    $0xc,%esp
8010474a:	68 00 3e 11 80       	push   $0x80113e00
8010474f:	e8 6f 0c 00 00       	call   801053c3 <release>
80104754:	83 c4 10             	add    $0x10,%esp

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
80104757:	e8 e0 e4 ff ff       	call   80102c3c <kalloc>
8010475c:	89 c2                	mov    %eax,%edx
8010475e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104761:	89 50 08             	mov    %edx,0x8(%eax)
80104764:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104767:	8b 40 08             	mov    0x8(%eax),%eax
8010476a:	85 c0                	test   %eax,%eax
8010476c:	75 11                	jne    8010477f <allocproc+0xaa>
    p->state = UNUSED;
8010476e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104771:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    return 0;
80104778:	b8 00 00 00 00       	mov    $0x0,%eax
8010477d:	eb 5d                	jmp    801047dc <allocproc+0x107>
  }
  sp = p->kstack + KSTACKSIZE;
8010477f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104782:	8b 40 08             	mov    0x8(%eax),%eax
80104785:	05 00 10 00 00       	add    $0x1000,%eax
8010478a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  
  // Leave room for trap frame.
  sp -= sizeof *p->tf;
8010478d:	83 6d f0 4c          	subl   $0x4c,-0x10(%ebp)
  p->tf = (struct trapframe*)sp;
80104791:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104794:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104797:	89 50 18             	mov    %edx,0x18(%eax)
  
  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
8010479a:	83 6d f0 04          	subl   $0x4,-0x10(%ebp)
  *(uint*)sp = (uint)trapret;
8010479e:	ba 97 69 10 80       	mov    $0x80106997,%edx
801047a3:	8b 45 f0             	mov    -0x10(%ebp),%eax
801047a6:	89 10                	mov    %edx,(%eax)

  sp -= sizeof *p->context;
801047a8:	83 6d f0 14          	subl   $0x14,-0x10(%ebp)
  p->context = (struct context*)sp;
801047ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
801047af:	8b 55 f0             	mov    -0x10(%ebp),%edx
801047b2:	89 50 1c             	mov    %edx,0x1c(%eax)
  memset(p->context, 0, sizeof *p->context);
801047b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801047b8:	8b 40 1c             	mov    0x1c(%eax),%eax
801047bb:	83 ec 04             	sub    $0x4,%esp
801047be:	6a 14                	push   $0x14
801047c0:	6a 00                	push   $0x0
801047c2:	50                   	push   %eax
801047c3:	e8 f5 0d 00 00       	call   801055bd <memset>
801047c8:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
801047cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801047ce:	8b 40 1c             	mov    0x1c(%eax),%eax
801047d1:	ba d7 4f 10 80       	mov    $0x80104fd7,%edx
801047d6:	89 50 10             	mov    %edx,0x10(%eax)
  return p;
801047d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801047dc:	c9                   	leave  
801047dd:	c3                   	ret    

801047de <userinit>:

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
801047de:	55                   	push   %ebp
801047df:	89 e5                	mov    %esp,%ebp
801047e1:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];
  
  p = allocproc();
801047e4:	e8 ec fe ff ff       	call   801046d5 <allocproc>
801047e9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  initproc = p;
801047ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
801047ef:	a3 80 c6 10 80       	mov    %eax,0x8010c680
  if((p->pgdir = setupkvm()) == 0)
801047f4:	e8 74 38 00 00       	call   8010806d <setupkvm>
801047f9:	89 c2                	mov    %eax,%edx
801047fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801047fe:	89 50 04             	mov    %edx,0x4(%eax)
80104801:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104804:	8b 40 04             	mov    0x4(%eax),%eax
80104807:	85 c0                	test   %eax,%eax
80104809:	75 0d                	jne    80104818 <userinit+0x3a>
    panic("userinit: out of memory?");
8010480b:	83 ec 0c             	sub    $0xc,%esp
8010480e:	68 e7 8b 10 80       	push   $0x80108be7
80104813:	e8 4a bd ff ff       	call   80100562 <panic>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80104818:	ba 2c 00 00 00       	mov    $0x2c,%edx
8010481d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104820:	8b 40 04             	mov    0x4(%eax),%eax
80104823:	83 ec 04             	sub    $0x4,%esp
80104826:	52                   	push   %edx
80104827:	68 e0 c4 10 80       	push   $0x8010c4e0
8010482c:	50                   	push   %eax
8010482d:	e8 95 3a 00 00       	call   801082c7 <inituvm>
80104832:	83 c4 10             	add    $0x10,%esp
  p->sz = PGSIZE;
80104835:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104838:	c7 00 00 10 00 00    	movl   $0x1000,(%eax)
  memset(p->tf, 0, sizeof(*p->tf));
8010483e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104841:	8b 40 18             	mov    0x18(%eax),%eax
80104844:	83 ec 04             	sub    $0x4,%esp
80104847:	6a 4c                	push   $0x4c
80104849:	6a 00                	push   $0x0
8010484b:	50                   	push   %eax
8010484c:	e8 6c 0d 00 00       	call   801055bd <memset>
80104851:	83 c4 10             	add    $0x10,%esp
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80104854:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104857:	8b 40 18             	mov    0x18(%eax),%eax
8010485a:	66 c7 40 3c 23 00    	movw   $0x23,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80104860:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104863:	8b 40 18             	mov    0x18(%eax),%eax
80104866:	66 c7 40 2c 2b 00    	movw   $0x2b,0x2c(%eax)
  p->tf->es = p->tf->ds;
8010486c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010486f:	8b 40 18             	mov    0x18(%eax),%eax
80104872:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104875:	8b 52 18             	mov    0x18(%edx),%edx
80104878:	0f b7 52 2c          	movzwl 0x2c(%edx),%edx
8010487c:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80104880:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104883:	8b 40 18             	mov    0x18(%eax),%eax
80104886:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104889:	8b 52 18             	mov    0x18(%edx),%edx
8010488c:	0f b7 52 2c          	movzwl 0x2c(%edx),%edx
80104890:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80104894:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104897:	8b 40 18             	mov    0x18(%eax),%eax
8010489a:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
801048a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801048a4:	8b 40 18             	mov    0x18(%eax),%eax
801048a7:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
801048ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
801048b1:	8b 40 18             	mov    0x18(%eax),%eax
801048b4:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)

  safestrcpy(p->name, "initcode", sizeof(p->name));
801048bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801048be:	83 c0 6c             	add    $0x6c,%eax
801048c1:	83 ec 04             	sub    $0x4,%esp
801048c4:	6a 10                	push   $0x10
801048c6:	68 00 8c 10 80       	push   $0x80108c00
801048cb:	50                   	push   %eax
801048cc:	e8 f1 0e 00 00       	call   801057c2 <safestrcpy>
801048d1:	83 c4 10             	add    $0x10,%esp
  p->cwd = namei("/");
801048d4:	83 ec 0c             	sub    $0xc,%esp
801048d7:	68 09 8c 10 80       	push   $0x80108c09
801048dc:	e8 25 dc ff ff       	call   80102506 <namei>
801048e1:	83 c4 10             	add    $0x10,%esp
801048e4:	89 c2                	mov    %eax,%edx
801048e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801048e9:	89 50 68             	mov    %edx,0x68(%eax)
  p->state = RUNNABLE;
801048ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
801048ef:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  
  p->state = RUNNABLE;
801048f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801048f9:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  p->priority = HIGH;
80104900:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104903:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
8010490a:	00 00 00 
  inserir(&filaHigh,p);
8010490d:	83 ec 08             	sub    $0x8,%esp
80104910:	ff 75 f4             	pushl  -0xc(%ebp)
80104913:	68 20 c9 10 80       	push   $0x8010c920
80104918:	e8 3b fb ff ff       	call   80104458 <inserir>
8010491d:	83 c4 10             	add    $0x10,%esp
}
80104920:	90                   	nop
80104921:	c9                   	leave  
80104922:	c3                   	ret    

80104923 <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
80104923:	55                   	push   %ebp
80104924:	89 e5                	mov    %esp,%ebp
80104926:	83 ec 18             	sub    $0x18,%esp
  uint sz;
  
  sz = proc->sz;
80104929:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010492f:	8b 00                	mov    (%eax),%eax
80104931:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(n > 0){
80104934:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80104938:	7e 31                	jle    8010496b <growproc+0x48>
    if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0)
8010493a:	8b 55 08             	mov    0x8(%ebp),%edx
8010493d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104940:	01 c2                	add    %eax,%edx
80104942:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104948:	8b 40 04             	mov    0x4(%eax),%eax
8010494b:	83 ec 04             	sub    $0x4,%esp
8010494e:	52                   	push   %edx
8010494f:	ff 75 f4             	pushl  -0xc(%ebp)
80104952:	50                   	push   %eax
80104953:	e8 bc 3a 00 00       	call   80108414 <allocuvm>
80104958:	83 c4 10             	add    $0x10,%esp
8010495b:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010495e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80104962:	75 3e                	jne    801049a2 <growproc+0x7f>
      return -1;
80104964:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104969:	eb 59                	jmp    801049c4 <growproc+0xa1>
  } else if(n < 0){
8010496b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
8010496f:	79 31                	jns    801049a2 <growproc+0x7f>
    if((sz = deallocuvm(proc->pgdir, sz, sz + n)) == 0)
80104971:	8b 55 08             	mov    0x8(%ebp),%edx
80104974:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104977:	01 c2                	add    %eax,%edx
80104979:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010497f:	8b 40 04             	mov    0x4(%eax),%eax
80104982:	83 ec 04             	sub    $0x4,%esp
80104985:	52                   	push   %edx
80104986:	ff 75 f4             	pushl  -0xc(%ebp)
80104989:	50                   	push   %eax
8010498a:	e8 4e 3b 00 00       	call   801084dd <deallocuvm>
8010498f:	83 c4 10             	add    $0x10,%esp
80104992:	89 45 f4             	mov    %eax,-0xc(%ebp)
80104995:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80104999:	75 07                	jne    801049a2 <growproc+0x7f>
      return -1;
8010499b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801049a0:	eb 22                	jmp    801049c4 <growproc+0xa1>
  }
  proc->sz = sz;
801049a2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801049a8:	8b 55 f4             	mov    -0xc(%ebp),%edx
801049ab:	89 10                	mov    %edx,(%eax)
  switchuvm(proc);
801049ad:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801049b3:	83 ec 0c             	sub    $0xc,%esp
801049b6:	50                   	push   %eax
801049b7:	e8 98 37 00 00       	call   80108154 <switchuvm>
801049bc:	83 c4 10             	add    $0x10,%esp
  return 0;
801049bf:	b8 00 00 00 00       	mov    $0x0,%eax
}
801049c4:	c9                   	leave  
801049c5:	c3                   	ret    

801049c6 <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
801049c6:	55                   	push   %ebp
801049c7:	89 e5                	mov    %esp,%ebp
801049c9:	57                   	push   %edi
801049ca:	56                   	push   %esi
801049cb:	53                   	push   %ebx
801049cc:	83 ec 1c             	sub    $0x1c,%esp
  int i, pid;
  struct proc *np;

  // Allocate process.
  if((np = allocproc()) == 0)
801049cf:	e8 01 fd ff ff       	call   801046d5 <allocproc>
801049d4:	89 45 e0             	mov    %eax,-0x20(%ebp)
801049d7:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
801049db:	75 0a                	jne    801049e7 <fork+0x21>
    return -1;
801049dd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801049e2:	e9 97 01 00 00       	jmp    80104b7e <fork+0x1b8>

  // Copy process state from p.
  if((np->pgdir = copyuvm(proc->pgdir, proc->sz)) == 0){
801049e7:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801049ed:	8b 10                	mov    (%eax),%edx
801049ef:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801049f5:	8b 40 04             	mov    0x4(%eax),%eax
801049f8:	83 ec 08             	sub    $0x8,%esp
801049fb:	52                   	push   %edx
801049fc:	50                   	push   %eax
801049fd:	e8 79 3c 00 00       	call   8010867b <copyuvm>
80104a02:	83 c4 10             	add    $0x10,%esp
80104a05:	89 c2                	mov    %eax,%edx
80104a07:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104a0a:	89 50 04             	mov    %edx,0x4(%eax)
80104a0d:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104a10:	8b 40 04             	mov    0x4(%eax),%eax
80104a13:	85 c0                	test   %eax,%eax
80104a15:	75 30                	jne    80104a47 <fork+0x81>
    kfree(np->kstack);
80104a17:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104a1a:	8b 40 08             	mov    0x8(%eax),%eax
80104a1d:	83 ec 0c             	sub    $0xc,%esp
80104a20:	50                   	push   %eax
80104a21:	e8 7a e1 ff ff       	call   80102ba0 <kfree>
80104a26:	83 c4 10             	add    $0x10,%esp
    np->kstack = 0;
80104a29:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104a2c:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
    np->state = UNUSED;
80104a33:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104a36:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    return -1;
80104a3d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104a42:	e9 37 01 00 00       	jmp    80104b7e <fork+0x1b8>
  }
  np->sz = proc->sz;
80104a47:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104a4d:	8b 10                	mov    (%eax),%edx
80104a4f:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104a52:	89 10                	mov    %edx,(%eax)
  np->parent = proc;
80104a54:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104a5b:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104a5e:	89 50 14             	mov    %edx,0x14(%eax)
  *np->tf = *proc->tf;
80104a61:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104a64:	8b 50 18             	mov    0x18(%eax),%edx
80104a67:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104a6d:	8b 40 18             	mov    0x18(%eax),%eax
80104a70:	89 c3                	mov    %eax,%ebx
80104a72:	b8 13 00 00 00       	mov    $0x13,%eax
80104a77:	89 d7                	mov    %edx,%edi
80104a79:	89 de                	mov    %ebx,%esi
80104a7b:	89 c1                	mov    %eax,%ecx
80104a7d:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;
80104a7f:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104a82:	8b 40 18             	mov    0x18(%eax),%eax
80104a85:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)

  for(i = 0; i < NOFILE; i++)
80104a8c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80104a93:	eb 43                	jmp    80104ad8 <fork+0x112>
    if(proc->ofile[i])
80104a95:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104a9b:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80104a9e:	83 c2 08             	add    $0x8,%edx
80104aa1:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80104aa5:	85 c0                	test   %eax,%eax
80104aa7:	74 2b                	je     80104ad4 <fork+0x10e>
      np->ofile[i] = filedup(proc->ofile[i]);
80104aa9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104aaf:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80104ab2:	83 c2 08             	add    $0x8,%edx
80104ab5:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80104ab9:	83 ec 0c             	sub    $0xc,%esp
80104abc:	50                   	push   %eax
80104abd:	e8 1d c5 ff ff       	call   80100fdf <filedup>
80104ac2:	83 c4 10             	add    $0x10,%esp
80104ac5:	89 c1                	mov    %eax,%ecx
80104ac7:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104aca:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80104acd:	83 c2 08             	add    $0x8,%edx
80104ad0:	89 4c 90 08          	mov    %ecx,0x8(%eax,%edx,4)
  *np->tf = *proc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
80104ad4:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
80104ad8:	83 7d e4 0f          	cmpl   $0xf,-0x1c(%ebp)
80104adc:	7e b7                	jle    80104a95 <fork+0xcf>
    if(proc->ofile[i])
      np->ofile[i] = filedup(proc->ofile[i]);
  np->cwd = idup(proc->cwd);
80104ade:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104ae4:	8b 40 68             	mov    0x68(%eax),%eax
80104ae7:	83 ec 0c             	sub    $0xc,%esp
80104aea:	50                   	push   %eax
80104aeb:	e8 1e ce ff ff       	call   8010190e <idup>
80104af0:	83 c4 10             	add    $0x10,%esp
80104af3:	89 c2                	mov    %eax,%edx
80104af5:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104af8:	89 50 68             	mov    %edx,0x68(%eax)
 
  pid = np->pid;
80104afb:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104afe:	8b 40 10             	mov    0x10(%eax),%eax
80104b01:	89 45 dc             	mov    %eax,-0x24(%ebp)
  np->state = RUNNABLE;
80104b04:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104b07:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  
  np->priority = HIGH;
80104b0e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104b11:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80104b18:	00 00 00 
  inserir(&filaHigh, np);
80104b1b:	83 ec 08             	sub    $0x8,%esp
80104b1e:	ff 75 e0             	pushl  -0x20(%ebp)
80104b21:	68 20 c9 10 80       	push   $0x8010c920
80104b26:	e8 2d f9 ff ff       	call   80104458 <inserir>
80104b2b:	83 c4 10             	add    $0x10,%esp
  cprintf("CRIOU... Nome:%s Pid:%d Prioridade:%d \n",np->name, np->pid,np->priority);
80104b2e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104b31:	8b 90 80 00 00 00    	mov    0x80(%eax),%edx
80104b37:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104b3a:	8b 40 10             	mov    0x10(%eax),%eax
80104b3d:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80104b40:	83 c1 6c             	add    $0x6c,%ecx
80104b43:	52                   	push   %edx
80104b44:	50                   	push   %eax
80104b45:	51                   	push   %ecx
80104b46:	68 0c 8c 10 80       	push   $0x80108c0c
80104b4b:	e8 72 b8 ff ff       	call   801003c2 <cprintf>
80104b50:	83 c4 10             	add    $0x10,%esp
  
  np->cont = 0;
80104b53:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104b56:	c7 40 7c 00 00 00 00 	movl   $0x0,0x7c(%eax)
  safestrcpy(np->name, proc->name, sizeof(proc->name));
80104b5d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104b63:	8d 50 6c             	lea    0x6c(%eax),%edx
80104b66:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104b69:	83 c0 6c             	add    $0x6c,%eax
80104b6c:	83 ec 04             	sub    $0x4,%esp
80104b6f:	6a 10                	push   $0x10
80104b71:	52                   	push   %edx
80104b72:	50                   	push   %eax
80104b73:	e8 4a 0c 00 00       	call   801057c2 <safestrcpy>
80104b78:	83 c4 10             	add    $0x10,%esp

  return pid;
80104b7b:	8b 45 dc             	mov    -0x24(%ebp),%eax
}
80104b7e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104b81:	5b                   	pop    %ebx
80104b82:	5e                   	pop    %esi
80104b83:	5f                   	pop    %edi
80104b84:	5d                   	pop    %ebp
80104b85:	c3                   	ret    

80104b86 <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
80104b86:	55                   	push   %ebp
80104b87:	89 e5                	mov    %esp,%ebp
80104b89:	53                   	push   %ebx
80104b8a:	83 ec 14             	sub    $0x14,%esp
  struct proc *p;
  int fd;

  if(proc == initproc)
80104b8d:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104b94:	a1 80 c6 10 80       	mov    0x8010c680,%eax
80104b99:	39 c2                	cmp    %eax,%edx
80104b9b:	75 0d                	jne    80104baa <exit+0x24>
    panic("init exiting");
80104b9d:	83 ec 0c             	sub    $0xc,%esp
80104ba0:	68 34 8c 10 80       	push   $0x80108c34
80104ba5:	e8 b8 b9 ff ff       	call   80100562 <panic>

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
80104baa:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
80104bb1:	eb 48                	jmp    80104bfb <exit+0x75>
    if(proc->ofile[fd]){
80104bb3:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104bb9:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104bbc:	83 c2 08             	add    $0x8,%edx
80104bbf:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80104bc3:	85 c0                	test   %eax,%eax
80104bc5:	74 30                	je     80104bf7 <exit+0x71>
      fileclose(proc->ofile[fd]);
80104bc7:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104bcd:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104bd0:	83 c2 08             	add    $0x8,%edx
80104bd3:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80104bd7:	83 ec 0c             	sub    $0xc,%esp
80104bda:	50                   	push   %eax
80104bdb:	e8 50 c4 ff ff       	call   80101030 <fileclose>
80104be0:	83 c4 10             	add    $0x10,%esp
      proc->ofile[fd] = 0;
80104be3:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104be9:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104bec:	83 c2 08             	add    $0x8,%edx
80104bef:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
80104bf6:	00 

  if(proc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
80104bf7:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
80104bfb:	83 7d f0 0f          	cmpl   $0xf,-0x10(%ebp)
80104bff:	7e b2                	jle    80104bb3 <exit+0x2d>
      fileclose(proc->ofile[fd]);
      proc->ofile[fd] = 0;
    }
  }

  iput(proc->cwd);
80104c01:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104c07:	8b 40 68             	mov    0x68(%eax),%eax
80104c0a:	83 ec 0c             	sub    $0xc,%esp
80104c0d:	50                   	push   %eax
80104c0e:	e8 05 cf ff ff       	call   80101b18 <iput>
80104c13:	83 c4 10             	add    $0x10,%esp
  proc->cwd = 0;
80104c16:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104c1c:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%eax)

  acquire(&ptable.lock);
80104c23:	83 ec 0c             	sub    $0xc,%esp
80104c26:	68 00 3e 11 80       	push   $0x80113e00
80104c2b:	e8 2c 07 00 00       	call   8010535c <acquire>
80104c30:	83 c4 10             	add    $0x10,%esp

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);
80104c33:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104c39:	8b 40 14             	mov    0x14(%eax),%eax
80104c3c:	83 ec 0c             	sub    $0xc,%esp
80104c3f:	50                   	push   %eax
80104c40:	e8 84 04 00 00       	call   801050c9 <wakeup1>
80104c45:	83 c4 10             	add    $0x10,%esp

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104c48:	c7 45 f4 34 3e 11 80 	movl   $0x80113e34,-0xc(%ebp)
80104c4f:	eb 3f                	jmp    80104c90 <exit+0x10a>
    if(p->parent == proc){
80104c51:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104c54:	8b 50 14             	mov    0x14(%eax),%edx
80104c57:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104c5d:	39 c2                	cmp    %eax,%edx
80104c5f:	75 28                	jne    80104c89 <exit+0x103>
      p->parent = initproc;
80104c61:	8b 15 80 c6 10 80    	mov    0x8010c680,%edx
80104c67:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104c6a:	89 50 14             	mov    %edx,0x14(%eax)
      if(p->state == ZOMBIE)
80104c6d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104c70:	8b 40 0c             	mov    0xc(%eax),%eax
80104c73:	83 f8 05             	cmp    $0x5,%eax
80104c76:	75 11                	jne    80104c89 <exit+0x103>
        wakeup1(initproc);
80104c78:	a1 80 c6 10 80       	mov    0x8010c680,%eax
80104c7d:	83 ec 0c             	sub    $0xc,%esp
80104c80:	50                   	push   %eax
80104c81:	e8 43 04 00 00       	call   801050c9 <wakeup1>
80104c86:	83 c4 10             	add    $0x10,%esp

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104c89:	81 45 f4 84 00 00 00 	addl   $0x84,-0xc(%ebp)
80104c90:	81 7d f4 34 5f 11 80 	cmpl   $0x80115f34,-0xc(%ebp)
80104c97:	72 b8                	jb     80104c51 <exit+0xcb>
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  proc->state = ZOMBIE;
80104c99:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104c9f:	c7 40 0c 05 00 00 00 	movl   $0x5,0xc(%eax)
  
	//MOSTRAR QUE O PROCESSO TERMINOU
   cprintf("TERMINOU... Nome:%s Pid:%d Prioridade:%d TimesOnCpu:%d\n", proc->name, proc->pid, proc->priority, proc->cont);
80104ca6:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104cac:	8b 48 7c             	mov    0x7c(%eax),%ecx
80104caf:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104cb5:	8b 90 80 00 00 00    	mov    0x80(%eax),%edx
80104cbb:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104cc1:	8b 40 10             	mov    0x10(%eax),%eax
80104cc4:	65 8b 1d 04 00 00 00 	mov    %gs:0x4,%ebx
80104ccb:	83 c3 6c             	add    $0x6c,%ebx
80104cce:	83 ec 0c             	sub    $0xc,%esp
80104cd1:	51                   	push   %ecx
80104cd2:	52                   	push   %edx
80104cd3:	50                   	push   %eax
80104cd4:	53                   	push   %ebx
80104cd5:	68 44 8c 10 80       	push   $0x80108c44
80104cda:	e8 e3 b6 ff ff       	call   801003c2 <cprintf>
80104cdf:	83 c4 20             	add    $0x20,%esp
  
  sched();
80104ce2:	e8 e7 01 00 00       	call   80104ece <sched>
  panic("zombie exit");
80104ce7:	83 ec 0c             	sub    $0xc,%esp
80104cea:	68 7c 8c 10 80       	push   $0x80108c7c
80104cef:	e8 6e b8 ff ff       	call   80100562 <panic>

80104cf4 <wait>:
// Return -1 if this process has no children.
// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
80104cf4:	55                   	push   %ebp
80104cf5:	89 e5                	mov    %esp,%ebp
80104cf7:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  int havekids, pid;

  acquire(&ptable.lock);
80104cfa:	83 ec 0c             	sub    $0xc,%esp
80104cfd:	68 00 3e 11 80       	push   $0x80113e00
80104d02:	e8 55 06 00 00       	call   8010535c <acquire>
80104d07:	83 c4 10             	add    $0x10,%esp
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
80104d0a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104d11:	c7 45 f4 34 3e 11 80 	movl   $0x80113e34,-0xc(%ebp)
80104d18:	e9 a9 00 00 00       	jmp    80104dc6 <wait+0xd2>
      if(p->parent != proc)
80104d1d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104d20:	8b 50 14             	mov    0x14(%eax),%edx
80104d23:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104d29:	39 c2                	cmp    %eax,%edx
80104d2b:	0f 85 8d 00 00 00    	jne    80104dbe <wait+0xca>
        continue;
      havekids = 1;
80104d31:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
      if(p->state == ZOMBIE){
80104d38:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104d3b:	8b 40 0c             	mov    0xc(%eax),%eax
80104d3e:	83 f8 05             	cmp    $0x5,%eax
80104d41:	75 7c                	jne    80104dbf <wait+0xcb>
			
        // Found one.
        pid = p->pid;
80104d43:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104d46:	8b 40 10             	mov    0x10(%eax),%eax
80104d49:	89 45 ec             	mov    %eax,-0x14(%ebp)
        kfree(p->kstack);
80104d4c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104d4f:	8b 40 08             	mov    0x8(%eax),%eax
80104d52:	83 ec 0c             	sub    $0xc,%esp
80104d55:	50                   	push   %eax
80104d56:	e8 45 de ff ff       	call   80102ba0 <kfree>
80104d5b:	83 c4 10             	add    $0x10,%esp
        p->kstack = 0;
80104d5e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104d61:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
        freevm(p->pgdir);
80104d68:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104d6b:	8b 40 04             	mov    0x4(%eax),%eax
80104d6e:	83 ec 0c             	sub    $0xc,%esp
80104d71:	50                   	push   %eax
80104d72:	e8 23 38 00 00       	call   8010859a <freevm>
80104d77:	83 c4 10             	add    $0x10,%esp
        p->state = UNUSED;
80104d7a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104d7d:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
        p->pid = 0;
80104d84:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104d87:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
        p->parent = 0;
80104d8e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104d91:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        p->name[0] = 0;
80104d98:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104d9b:	c6 40 6c 00          	movb   $0x0,0x6c(%eax)
        p->killed = 0;        
80104d9f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104da2:	c7 40 24 00 00 00 00 	movl   $0x0,0x24(%eax)
        release(&ptable.lock);
80104da9:	83 ec 0c             	sub    $0xc,%esp
80104dac:	68 00 3e 11 80       	push   $0x80113e00
80104db1:	e8 0d 06 00 00       	call   801053c3 <release>
80104db6:	83 c4 10             	add    $0x10,%esp
        return pid;
80104db9:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104dbc:	eb 5b                	jmp    80104e19 <wait+0x125>
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->parent != proc)
        continue;
80104dbe:	90                   	nop

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104dbf:	81 45 f4 84 00 00 00 	addl   $0x84,-0xc(%ebp)
80104dc6:	81 7d f4 34 5f 11 80 	cmpl   $0x80115f34,-0xc(%ebp)
80104dcd:	0f 82 4a ff ff ff    	jb     80104d1d <wait+0x29>
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
80104dd3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80104dd7:	74 0d                	je     80104de6 <wait+0xf2>
80104dd9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104ddf:	8b 40 24             	mov    0x24(%eax),%eax
80104de2:	85 c0                	test   %eax,%eax
80104de4:	74 17                	je     80104dfd <wait+0x109>
      release(&ptable.lock);
80104de6:	83 ec 0c             	sub    $0xc,%esp
80104de9:	68 00 3e 11 80       	push   $0x80113e00
80104dee:	e8 d0 05 00 00       	call   801053c3 <release>
80104df3:	83 c4 10             	add    $0x10,%esp
      return -1;
80104df6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104dfb:	eb 1c                	jmp    80104e19 <wait+0x125>
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
80104dfd:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104e03:	83 ec 08             	sub    $0x8,%esp
80104e06:	68 00 3e 11 80       	push   $0x80113e00
80104e0b:	50                   	push   %eax
80104e0c:	e8 0c 02 00 00       	call   8010501d <sleep>
80104e11:	83 c4 10             	add    $0x10,%esp
  }
80104e14:	e9 f1 fe ff ff       	jmp    80104d0a <wait+0x16>
}
80104e19:	c9                   	leave  
80104e1a:	c3                   	ret    

80104e1b <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
80104e1b:	55                   	push   %ebp
80104e1c:	89 e5                	mov    %esp,%ebp
80104e1e:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;

  for(;;){
    // Enable interrupts on this processor.
    sti();
80104e21:	e8 e9 f5 ff ff       	call   8010440f <sti>

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80104e26:	83 ec 0c             	sub    $0xc,%esp
80104e29:	68 00 3e 11 80       	push   $0x80113e00
80104e2e:	e8 29 05 00 00       	call   8010535c <acquire>
80104e33:	83 c4 10             	add    $0x10,%esp
    
    //Escolhe sempre o primeiro processo da fila escolhida, seguindo a ordem de prioridade (High -> Medium -> Low)
    p = escolheFila();
80104e36:	e8 2e f7 ff ff       	call   80104569 <escolheFila>
80104e3b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    
    while( p!= 0 ){
80104e3e:	eb 73                	jmp    80104eb3 <scheduler+0x98>
      if(p->state == RUNNABLE){
80104e40:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104e43:	8b 40 0c             	mov    0xc(%eax),%eax
80104e46:	83 f8 03             	cmp    $0x3,%eax
80104e49:	75 60                	jne    80104eab <scheduler+0x90>
        // Switch to chosen process.  It is the process's job
        // to release ptable.lock and then reacquire it
        // before jumping back to us.
        proc = p;
80104e4b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104e4e:	65 a3 04 00 00 00    	mov    %eax,%gs:0x4
        switchuvm(p);
80104e54:	83 ec 0c             	sub    $0xc,%esp
80104e57:	ff 75 f4             	pushl  -0xc(%ebp)
80104e5a:	e8 f5 32 00 00       	call   80108154 <switchuvm>
80104e5f:	83 c4 10             	add    $0x10,%esp
        p->state = RUNNING;
80104e62:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104e65:	c7 40 0c 04 00 00 00 	movl   $0x4,0xc(%eax)
        p->cont++;
80104e6c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104e6f:	8b 40 7c             	mov    0x7c(%eax),%eax
80104e72:	8d 50 01             	lea    0x1(%eax),%edx
80104e75:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104e78:	89 50 7c             	mov    %edx,0x7c(%eax)
        swtch(&cpu->scheduler, proc->context);
80104e7b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104e81:	8b 40 1c             	mov    0x1c(%eax),%eax
80104e84:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80104e8b:	83 c2 04             	add    $0x4,%edx
80104e8e:	83 ec 08             	sub    $0x8,%esp
80104e91:	50                   	push   %eax
80104e92:	52                   	push   %edx
80104e93:	e8 9b 09 00 00       	call   80105833 <swtch>
80104e98:	83 c4 10             	add    $0x10,%esp
        switchkvm();
80104e9b:	e8 97 32 00 00       	call   80108137 <switchkvm>

        // Process is done running for now.
        // It should have changed its p->state before coming back.
        proc = 0;
80104ea0:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
80104ea7:	00 00 00 00 
      }
      p = escolheFila();
80104eab:	e8 b9 f6 ff ff       	call   80104569 <escolheFila>
80104eb0:	89 45 f4             	mov    %eax,-0xc(%ebp)
    acquire(&ptable.lock);
    
    //Escolhe sempre o primeiro processo da fila escolhida, seguindo a ordem de prioridade (High -> Medium -> Low)
    p = escolheFila();
    
    while( p!= 0 ){
80104eb3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80104eb7:	75 87                	jne    80104e40 <scheduler+0x25>
        // It should have changed its p->state before coming back.
        proc = 0;
      }
      p = escolheFila();
    }
    release(&ptable.lock);
80104eb9:	83 ec 0c             	sub    $0xc,%esp
80104ebc:	68 00 3e 11 80       	push   $0x80113e00
80104ec1:	e8 fd 04 00 00       	call   801053c3 <release>
80104ec6:	83 c4 10             	add    $0x10,%esp

  }
80104ec9:	e9 53 ff ff ff       	jmp    80104e21 <scheduler+0x6>

80104ece <sched>:

// Enter scheduler.  Must hold only ptable.lock
// and have changed proc->state.
void
sched(void)
{
80104ece:	55                   	push   %ebp
80104ecf:	89 e5                	mov    %esp,%ebp
80104ed1:	83 ec 18             	sub    $0x18,%esp
  int intena;

  if(!holding(&ptable.lock))
80104ed4:	83 ec 0c             	sub    $0xc,%esp
80104ed7:	68 00 3e 11 80       	push   $0x80113e00
80104edc:	e8 ae 05 00 00       	call   8010548f <holding>
80104ee1:	83 c4 10             	add    $0x10,%esp
80104ee4:	85 c0                	test   %eax,%eax
80104ee6:	75 0d                	jne    80104ef5 <sched+0x27>
    panic("sched ptable.lock");
80104ee8:	83 ec 0c             	sub    $0xc,%esp
80104eeb:	68 88 8c 10 80       	push   $0x80108c88
80104ef0:	e8 6d b6 ff ff       	call   80100562 <panic>
  if(cpu->ncli != 1)
80104ef5:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104efb:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
80104f01:	83 f8 01             	cmp    $0x1,%eax
80104f04:	74 0d                	je     80104f13 <sched+0x45>
    panic("sched locks");
80104f06:	83 ec 0c             	sub    $0xc,%esp
80104f09:	68 9a 8c 10 80       	push   $0x80108c9a
80104f0e:	e8 4f b6 ff ff       	call   80100562 <panic>
  if(proc->state == RUNNING)
80104f13:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104f19:	8b 40 0c             	mov    0xc(%eax),%eax
80104f1c:	83 f8 04             	cmp    $0x4,%eax
80104f1f:	75 0d                	jne    80104f2e <sched+0x60>
    panic("sched running");
80104f21:	83 ec 0c             	sub    $0xc,%esp
80104f24:	68 a6 8c 10 80       	push   $0x80108ca6
80104f29:	e8 34 b6 ff ff       	call   80100562 <panic>
  if(readeflags()&FL_IF)
80104f2e:	e8 cc f4 ff ff       	call   801043ff <readeflags>
80104f33:	25 00 02 00 00       	and    $0x200,%eax
80104f38:	85 c0                	test   %eax,%eax
80104f3a:	74 0d                	je     80104f49 <sched+0x7b>
    panic("sched interruptible");
80104f3c:	83 ec 0c             	sub    $0xc,%esp
80104f3f:	68 b4 8c 10 80       	push   $0x80108cb4
80104f44:	e8 19 b6 ff ff       	call   80100562 <panic>
  intena = cpu->intena;
80104f49:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104f4f:	8b 80 b0 00 00 00    	mov    0xb0(%eax),%eax
80104f55:	89 45 f4             	mov    %eax,-0xc(%ebp)
  swtch(&proc->context, cpu->scheduler);
80104f58:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104f5e:	8b 40 04             	mov    0x4(%eax),%eax
80104f61:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104f68:	83 c2 1c             	add    $0x1c,%edx
80104f6b:	83 ec 08             	sub    $0x8,%esp
80104f6e:	50                   	push   %eax
80104f6f:	52                   	push   %edx
80104f70:	e8 be 08 00 00       	call   80105833 <swtch>
80104f75:	83 c4 10             	add    $0x10,%esp
  cpu->intena = intena;
80104f78:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104f7e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104f81:	89 90 b0 00 00 00    	mov    %edx,0xb0(%eax)
}
80104f87:	90                   	nop
80104f88:	c9                   	leave  
80104f89:	c3                   	ret    

80104f8a <yield>:

// Give up the CPU for one scheduling round.
void
yield(void)
{
80104f8a:	55                   	push   %ebp
80104f8b:	89 e5                	mov    %esp,%ebp
80104f8d:	83 ec 08             	sub    $0x8,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80104f90:	83 ec 0c             	sub    $0xc,%esp
80104f93:	68 00 3e 11 80       	push   $0x80113e00
80104f98:	e8 bf 03 00 00       	call   8010535c <acquire>
80104f9d:	83 c4 10             	add    $0x10,%esp
  proc->state = RUNNABLE; 
80104fa0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104fa6:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)

	//Rebaixa o processo para fila de prioridade inferior
	rebaixar(proc);
80104fad:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104fb3:	83 ec 0c             	sub    $0xc,%esp
80104fb6:	50                   	push   %eax
80104fb7:	e8 64 f6 ff ff       	call   80104620 <rebaixar>
80104fbc:	83 c4 10             	add    $0x10,%esp
	
  sched();
80104fbf:	e8 0a ff ff ff       	call   80104ece <sched>
  release(&ptable.lock);
80104fc4:	83 ec 0c             	sub    $0xc,%esp
80104fc7:	68 00 3e 11 80       	push   $0x80113e00
80104fcc:	e8 f2 03 00 00       	call   801053c3 <release>
80104fd1:	83 c4 10             	add    $0x10,%esp
}
80104fd4:	90                   	nop
80104fd5:	c9                   	leave  
80104fd6:	c3                   	ret    

80104fd7 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80104fd7:	55                   	push   %ebp
80104fd8:	89 e5                	mov    %esp,%ebp
80104fda:	83 ec 08             	sub    $0x8,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80104fdd:	83 ec 0c             	sub    $0xc,%esp
80104fe0:	68 00 3e 11 80       	push   $0x80113e00
80104fe5:	e8 d9 03 00 00       	call   801053c3 <release>
80104fea:	83 c4 10             	add    $0x10,%esp

  if (first) {
80104fed:	a1 08 c0 10 80       	mov    0x8010c008,%eax
80104ff2:	85 c0                	test   %eax,%eax
80104ff4:	74 24                	je     8010501a <forkret+0x43>
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot 
    // be run from main().
    first = 0;
80104ff6:	c7 05 08 c0 10 80 00 	movl   $0x0,0x8010c008
80104ffd:	00 00 00 
    iinit(ROOTDEV);
80105000:	83 ec 0c             	sub    $0xc,%esp
80105003:	6a 01                	push   $0x1
80105005:	e8 12 c6 ff ff       	call   8010161c <iinit>
8010500a:	83 c4 10             	add    $0x10,%esp
    initlog(ROOTDEV);
8010500d:	83 ec 0c             	sub    $0xc,%esp
80105010:	6a 01                	push   $0x1
80105012:	e8 e5 e2 ff ff       	call   801032fc <initlog>
80105017:	83 c4 10             	add    $0x10,%esp
  }
  
  // Return to "caller", actually trapret (see allocproc).
}
8010501a:	90                   	nop
8010501b:	c9                   	leave  
8010501c:	c3                   	ret    

8010501d <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
8010501d:	55                   	push   %ebp
8010501e:	89 e5                	mov    %esp,%ebp
80105020:	83 ec 08             	sub    $0x8,%esp
  if(proc == 0)
80105023:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105029:	85 c0                	test   %eax,%eax
8010502b:	75 0d                	jne    8010503a <sleep+0x1d>
    panic("sleep");
8010502d:	83 ec 0c             	sub    $0xc,%esp
80105030:	68 c8 8c 10 80       	push   $0x80108cc8
80105035:	e8 28 b5 ff ff       	call   80100562 <panic>

  if(lk == 0)
8010503a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
8010503e:	75 0d                	jne    8010504d <sleep+0x30>
    panic("sleep without lk");
80105040:	83 ec 0c             	sub    $0xc,%esp
80105043:	68 ce 8c 10 80       	push   $0x80108cce
80105048:	e8 15 b5 ff ff       	call   80100562 <panic>
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
8010504d:	81 7d 0c 00 3e 11 80 	cmpl   $0x80113e00,0xc(%ebp)
80105054:	74 1e                	je     80105074 <sleep+0x57>
    acquire(&ptable.lock);  //DOC: sleeplock1
80105056:	83 ec 0c             	sub    $0xc,%esp
80105059:	68 00 3e 11 80       	push   $0x80113e00
8010505e:	e8 f9 02 00 00       	call   8010535c <acquire>
80105063:	83 c4 10             	add    $0x10,%esp
    release(lk);
80105066:	83 ec 0c             	sub    $0xc,%esp
80105069:	ff 75 0c             	pushl  0xc(%ebp)
8010506c:	e8 52 03 00 00       	call   801053c3 <release>
80105071:	83 c4 10             	add    $0x10,%esp
  }

  // Go to sleep.
  proc->chan = chan;
80105074:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010507a:	8b 55 08             	mov    0x8(%ebp),%edx
8010507d:	89 50 20             	mov    %edx,0x20(%eax)
  proc->state = SLEEPING;
80105080:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105086:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
  sched();
8010508d:	e8 3c fe ff ff       	call   80104ece <sched>

  // Tidy up.
  proc->chan = 0;
80105092:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105098:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
8010509f:	81 7d 0c 00 3e 11 80 	cmpl   $0x80113e00,0xc(%ebp)
801050a6:	74 1e                	je     801050c6 <sleep+0xa9>
    release(&ptable.lock);
801050a8:	83 ec 0c             	sub    $0xc,%esp
801050ab:	68 00 3e 11 80       	push   $0x80113e00
801050b0:	e8 0e 03 00 00       	call   801053c3 <release>
801050b5:	83 c4 10             	add    $0x10,%esp
    acquire(lk);
801050b8:	83 ec 0c             	sub    $0xc,%esp
801050bb:	ff 75 0c             	pushl  0xc(%ebp)
801050be:	e8 99 02 00 00       	call   8010535c <acquire>
801050c3:	83 c4 10             	add    $0x10,%esp
  }
}
801050c6:	90                   	nop
801050c7:	c9                   	leave  
801050c8:	c3                   	ret    

801050c9 <wakeup1>:
//PAGEBREAK!
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
801050c9:	55                   	push   %ebp
801050ca:	89 e5                	mov    %esp,%ebp
801050cc:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801050cf:	c7 45 f4 34 3e 11 80 	movl   $0x80113e34,-0xc(%ebp)
801050d6:	eb 35                	jmp    8010510d <wakeup1+0x44>
    if(p->state == SLEEPING && p->chan == chan){
801050d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801050db:	8b 40 0c             	mov    0xc(%eax),%eax
801050de:	83 f8 02             	cmp    $0x2,%eax
801050e1:	75 23                	jne    80105106 <wakeup1+0x3d>
801050e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801050e6:	8b 40 20             	mov    0x20(%eax),%eax
801050e9:	3b 45 08             	cmp    0x8(%ebp),%eax
801050ec:	75 18                	jne    80105106 <wakeup1+0x3d>
      p->state = RUNNABLE;
801050ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
801050f1:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      
      //Promove o processo para fila de prioridade superior
      promover(p);
801050f8:	83 ec 0c             	sub    $0xc,%esp
801050fb:	ff 75 f4             	pushl  -0xc(%ebp)
801050fe:	e8 c4 f4 ff ff       	call   801045c7 <promover>
80105103:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80105106:	81 45 f4 84 00 00 00 	addl   $0x84,-0xc(%ebp)
8010510d:	81 7d f4 34 5f 11 80 	cmpl   $0x80115f34,-0xc(%ebp)
80105114:	72 c2                	jb     801050d8 <wakeup1+0xf>
      p->state = RUNNABLE;
      
      //Promove o processo para fila de prioridade superior
      promover(p);
    }
}
80105116:	90                   	nop
80105117:	c9                   	leave  
80105118:	c3                   	ret    

80105119 <wakeup>:

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80105119:	55                   	push   %ebp
8010511a:	89 e5                	mov    %esp,%ebp
8010511c:	83 ec 08             	sub    $0x8,%esp
  acquire(&ptable.lock);
8010511f:	83 ec 0c             	sub    $0xc,%esp
80105122:	68 00 3e 11 80       	push   $0x80113e00
80105127:	e8 30 02 00 00       	call   8010535c <acquire>
8010512c:	83 c4 10             	add    $0x10,%esp
  wakeup1(chan);
8010512f:	83 ec 0c             	sub    $0xc,%esp
80105132:	ff 75 08             	pushl  0x8(%ebp)
80105135:	e8 8f ff ff ff       	call   801050c9 <wakeup1>
8010513a:	83 c4 10             	add    $0x10,%esp
  release(&ptable.lock);
8010513d:	83 ec 0c             	sub    $0xc,%esp
80105140:	68 00 3e 11 80       	push   $0x80113e00
80105145:	e8 79 02 00 00       	call   801053c3 <release>
8010514a:	83 c4 10             	add    $0x10,%esp
}
8010514d:	90                   	nop
8010514e:	c9                   	leave  
8010514f:	c3                   	ret    

80105150 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80105150:	55                   	push   %ebp
80105151:	89 e5                	mov    %esp,%ebp
80105153:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;

  acquire(&ptable.lock);
80105156:	83 ec 0c             	sub    $0xc,%esp
80105159:	68 00 3e 11 80       	push   $0x80113e00
8010515e:	e8 f9 01 00 00       	call   8010535c <acquire>
80105163:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80105166:	c7 45 f4 34 3e 11 80 	movl   $0x80113e34,-0xc(%ebp)
8010516d:	eb 56                	jmp    801051c5 <kill+0x75>
    if(p->pid == pid){
8010516f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105172:	8b 40 10             	mov    0x10(%eax),%eax
80105175:	3b 45 08             	cmp    0x8(%ebp),%eax
80105178:	75 44                	jne    801051be <kill+0x6e>
      p->killed = 1;
8010517a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010517d:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING){
80105184:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105187:	8b 40 0c             	mov    0xc(%eax),%eax
8010518a:	83 f8 02             	cmp    $0x2,%eax
8010518d:	75 18                	jne    801051a7 <kill+0x57>
        p->state = RUNNABLE;
8010518f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105192:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
        
        //Promove o processo para fila de prioridade superior
        promover(p);
80105199:	83 ec 0c             	sub    $0xc,%esp
8010519c:	ff 75 f4             	pushl  -0xc(%ebp)
8010519f:	e8 23 f4 ff ff       	call   801045c7 <promover>
801051a4:	83 c4 10             	add    $0x10,%esp
      }
      release(&ptable.lock);
801051a7:	83 ec 0c             	sub    $0xc,%esp
801051aa:	68 00 3e 11 80       	push   $0x80113e00
801051af:	e8 0f 02 00 00       	call   801053c3 <release>
801051b4:	83 c4 10             	add    $0x10,%esp
      return 0;
801051b7:	b8 00 00 00 00       	mov    $0x0,%eax
801051bc:	eb 25                	jmp    801051e3 <kill+0x93>
kill(int pid)
{
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801051be:	81 45 f4 84 00 00 00 	addl   $0x84,-0xc(%ebp)
801051c5:	81 7d f4 34 5f 11 80 	cmpl   $0x80115f34,-0xc(%ebp)
801051cc:	72 a1                	jb     8010516f <kill+0x1f>
      }
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
801051ce:	83 ec 0c             	sub    $0xc,%esp
801051d1:	68 00 3e 11 80       	push   $0x80113e00
801051d6:	e8 e8 01 00 00       	call   801053c3 <release>
801051db:	83 c4 10             	add    $0x10,%esp
  return -1;
801051de:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801051e3:	c9                   	leave  
801051e4:	c3                   	ret    

801051e5 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
801051e5:	55                   	push   %ebp
801051e6:	89 e5                	mov    %esp,%ebp
801051e8:	83 ec 48             	sub    $0x48,%esp
  int i;
  struct proc *p;
  char *state;
  uint pc[10];
  
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801051eb:	c7 45 f0 34 3e 11 80 	movl   $0x80113e34,-0x10(%ebp)
801051f2:	e9 fb 00 00 00       	jmp    801052f2 <procdump+0x10d>
    if(p->state == UNUSED)
801051f7:	8b 45 f0             	mov    -0x10(%ebp),%eax
801051fa:	8b 40 0c             	mov    0xc(%eax),%eax
801051fd:	85 c0                	test   %eax,%eax
801051ff:	0f 84 e5 00 00 00    	je     801052ea <procdump+0x105>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80105205:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105208:	8b 40 0c             	mov    0xc(%eax),%eax
8010520b:	83 f8 05             	cmp    $0x5,%eax
8010520e:	77 23                	ja     80105233 <procdump+0x4e>
80105210:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105213:	8b 40 0c             	mov    0xc(%eax),%eax
80105216:	8b 04 85 0c c0 10 80 	mov    -0x7fef3ff4(,%eax,4),%eax
8010521d:	85 c0                	test   %eax,%eax
8010521f:	74 12                	je     80105233 <procdump+0x4e>
      state = states[p->state];
80105221:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105224:	8b 40 0c             	mov    0xc(%eax),%eax
80105227:	8b 04 85 0c c0 10 80 	mov    -0x7fef3ff4(,%eax,4),%eax
8010522e:	89 45 ec             	mov    %eax,-0x14(%ebp)
80105231:	eb 07                	jmp    8010523a <procdump+0x55>
    else
      state = "???";
80105233:	c7 45 ec df 8c 10 80 	movl   $0x80108cdf,-0x14(%ebp)
    cprintf("%d %s %s", p->pid, state, p->name);
8010523a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010523d:	8d 50 6c             	lea    0x6c(%eax),%edx
80105240:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105243:	8b 40 10             	mov    0x10(%eax),%eax
80105246:	52                   	push   %edx
80105247:	ff 75 ec             	pushl  -0x14(%ebp)
8010524a:	50                   	push   %eax
8010524b:	68 e3 8c 10 80       	push   $0x80108ce3
80105250:	e8 6d b1 ff ff       	call   801003c2 <cprintf>
80105255:	83 c4 10             	add    $0x10,%esp
    cprintf("Prioridade: %d TimesOnCpu: %d\n", p->priority, p->cont);
80105258:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010525b:	8b 50 7c             	mov    0x7c(%eax),%edx
8010525e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105261:	8b 80 80 00 00 00    	mov    0x80(%eax),%eax
80105267:	83 ec 04             	sub    $0x4,%esp
8010526a:	52                   	push   %edx
8010526b:	50                   	push   %eax
8010526c:	68 ec 8c 10 80       	push   $0x80108cec
80105271:	e8 4c b1 ff ff       	call   801003c2 <cprintf>
80105276:	83 c4 10             	add    $0x10,%esp
    if(p->state == SLEEPING){
80105279:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010527c:	8b 40 0c             	mov    0xc(%eax),%eax
8010527f:	83 f8 02             	cmp    $0x2,%eax
80105282:	75 54                	jne    801052d8 <procdump+0xf3>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80105284:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105287:	8b 40 1c             	mov    0x1c(%eax),%eax
8010528a:	8b 40 0c             	mov    0xc(%eax),%eax
8010528d:	83 c0 08             	add    $0x8,%eax
80105290:	89 c2                	mov    %eax,%edx
80105292:	83 ec 08             	sub    $0x8,%esp
80105295:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105298:	50                   	push   %eax
80105299:	52                   	push   %edx
8010529a:	e8 76 01 00 00       	call   80105415 <getcallerpcs>
8010529f:	83 c4 10             	add    $0x10,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
801052a2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801052a9:	eb 1c                	jmp    801052c7 <procdump+0xe2>
        cprintf(" %p", pc[i]);
801052ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
801052ae:	8b 44 85 c4          	mov    -0x3c(%ebp,%eax,4),%eax
801052b2:	83 ec 08             	sub    $0x8,%esp
801052b5:	50                   	push   %eax
801052b6:	68 0b 8d 10 80       	push   $0x80108d0b
801052bb:	e8 02 b1 ff ff       	call   801003c2 <cprintf>
801052c0:	83 c4 10             	add    $0x10,%esp
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    cprintf("Prioridade: %d TimesOnCpu: %d\n", p->priority, p->cont);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
801052c3:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801052c7:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
801052cb:	7f 0b                	jg     801052d8 <procdump+0xf3>
801052cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801052d0:	8b 44 85 c4          	mov    -0x3c(%ebp,%eax,4),%eax
801052d4:	85 c0                	test   %eax,%eax
801052d6:	75 d3                	jne    801052ab <procdump+0xc6>
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
801052d8:	83 ec 0c             	sub    $0xc,%esp
801052db:	68 0f 8d 10 80       	push   $0x80108d0f
801052e0:	e8 dd b0 ff ff       	call   801003c2 <cprintf>
801052e5:	83 c4 10             	add    $0x10,%esp
801052e8:	eb 01                	jmp    801052eb <procdump+0x106>
  char *state;
  uint pc[10];
  
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
801052ea:	90                   	nop
  int i;
  struct proc *p;
  char *state;
  uint pc[10];
  
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801052eb:	81 45 f0 84 00 00 00 	addl   $0x84,-0x10(%ebp)
801052f2:	81 7d f0 34 5f 11 80 	cmpl   $0x80115f34,-0x10(%ebp)
801052f9:	0f 82 f8 fe ff ff    	jb     801051f7 <procdump+0x12>
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}
801052ff:	90                   	nop
80105300:	c9                   	leave  
80105301:	c3                   	ret    

80105302 <readeflags>:
  asm volatile("ltr %0" : : "r" (sel));
}

static inline uint
readeflags(void)
{
80105302:	55                   	push   %ebp
80105303:	89 e5                	mov    %esp,%ebp
80105305:	83 ec 10             	sub    $0x10,%esp
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80105308:	9c                   	pushf  
80105309:	58                   	pop    %eax
8010530a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return eflags;
8010530d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80105310:	c9                   	leave  
80105311:	c3                   	ret    

80105312 <cli>:
  asm volatile("movw %0, %%gs" : : "r" (v));
}

static inline void
cli(void)
{
80105312:	55                   	push   %ebp
80105313:	89 e5                	mov    %esp,%ebp
  asm volatile("cli");
80105315:	fa                   	cli    
}
80105316:	90                   	nop
80105317:	5d                   	pop    %ebp
80105318:	c3                   	ret    

80105319 <sti>:

static inline void
sti(void)
{
80105319:	55                   	push   %ebp
8010531a:	89 e5                	mov    %esp,%ebp
  asm volatile("sti");
8010531c:	fb                   	sti    
}
8010531d:	90                   	nop
8010531e:	5d                   	pop    %ebp
8010531f:	c3                   	ret    

80105320 <xchg>:

static inline uint
xchg(volatile uint *addr, uint newval)
{
80105320:	55                   	push   %ebp
80105321:	89 e5                	mov    %esp,%ebp
80105323:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80105326:	8b 55 08             	mov    0x8(%ebp),%edx
80105329:	8b 45 0c             	mov    0xc(%ebp),%eax
8010532c:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010532f:	f0 87 02             	lock xchg %eax,(%edx)
80105332:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
80105335:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80105338:	c9                   	leave  
80105339:	c3                   	ret    

8010533a <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
8010533a:	55                   	push   %ebp
8010533b:	89 e5                	mov    %esp,%ebp
  lk->name = name;
8010533d:	8b 45 08             	mov    0x8(%ebp),%eax
80105340:	8b 55 0c             	mov    0xc(%ebp),%edx
80105343:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
80105346:	8b 45 08             	mov    0x8(%ebp),%eax
80105349:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->cpu = 0;
8010534f:	8b 45 08             	mov    0x8(%ebp),%eax
80105352:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80105359:	90                   	nop
8010535a:	5d                   	pop    %ebp
8010535b:	c3                   	ret    

8010535c <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
8010535c:	55                   	push   %ebp
8010535d:	89 e5                	mov    %esp,%ebp
8010535f:	83 ec 08             	sub    $0x8,%esp
  pushcli(); // disable interrupts to avoid deadlock.
80105362:	e8 52 01 00 00       	call   801054b9 <pushcli>
  if(holding(lk))
80105367:	8b 45 08             	mov    0x8(%ebp),%eax
8010536a:	83 ec 0c             	sub    $0xc,%esp
8010536d:	50                   	push   %eax
8010536e:	e8 1c 01 00 00       	call   8010548f <holding>
80105373:	83 c4 10             	add    $0x10,%esp
80105376:	85 c0                	test   %eax,%eax
80105378:	74 0d                	je     80105387 <acquire+0x2b>
    panic("acquire");
8010537a:	83 ec 0c             	sub    $0xc,%esp
8010537d:	68 3b 8d 10 80       	push   $0x80108d3b
80105382:	e8 db b1 ff ff       	call   80100562 <panic>

  // The xchg is atomic.
  // It also serializes, so that reads after acquire are not
  // reordered before it. 
  while(xchg(&lk->locked, 1) != 0)
80105387:	90                   	nop
80105388:	8b 45 08             	mov    0x8(%ebp),%eax
8010538b:	83 ec 08             	sub    $0x8,%esp
8010538e:	6a 01                	push   $0x1
80105390:	50                   	push   %eax
80105391:	e8 8a ff ff ff       	call   80105320 <xchg>
80105396:	83 c4 10             	add    $0x10,%esp
80105399:	85 c0                	test   %eax,%eax
8010539b:	75 eb                	jne    80105388 <acquire+0x2c>
    ;

  // Record info about lock acquisition for debugging.
  lk->cpu = cpu;
8010539d:	8b 45 08             	mov    0x8(%ebp),%eax
801053a0:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
801053a7:	89 50 08             	mov    %edx,0x8(%eax)
  getcallerpcs(&lk, lk->pcs);
801053aa:	8b 45 08             	mov    0x8(%ebp),%eax
801053ad:	83 c0 0c             	add    $0xc,%eax
801053b0:	83 ec 08             	sub    $0x8,%esp
801053b3:	50                   	push   %eax
801053b4:	8d 45 08             	lea    0x8(%ebp),%eax
801053b7:	50                   	push   %eax
801053b8:	e8 58 00 00 00       	call   80105415 <getcallerpcs>
801053bd:	83 c4 10             	add    $0x10,%esp
}
801053c0:	90                   	nop
801053c1:	c9                   	leave  
801053c2:	c3                   	ret    

801053c3 <release>:

// Release the lock.
void
release(struct spinlock *lk)
{
801053c3:	55                   	push   %ebp
801053c4:	89 e5                	mov    %esp,%ebp
801053c6:	83 ec 08             	sub    $0x8,%esp
  if(!holding(lk))
801053c9:	83 ec 0c             	sub    $0xc,%esp
801053cc:	ff 75 08             	pushl  0x8(%ebp)
801053cf:	e8 bb 00 00 00       	call   8010548f <holding>
801053d4:	83 c4 10             	add    $0x10,%esp
801053d7:	85 c0                	test   %eax,%eax
801053d9:	75 0d                	jne    801053e8 <release+0x25>
    panic("release");
801053db:	83 ec 0c             	sub    $0xc,%esp
801053de:	68 43 8d 10 80       	push   $0x80108d43
801053e3:	e8 7a b1 ff ff       	call   80100562 <panic>

  lk->pcs[0] = 0;
801053e8:	8b 45 08             	mov    0x8(%ebp),%eax
801053eb:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  lk->cpu = 0;
801053f2:	8b 45 08             	mov    0x8(%ebp),%eax
801053f5:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  // But the 2007 Intel 64 Architecture Memory Ordering White
  // Paper says that Intel 64 and IA-32 will not move a load
  // after a store. So lock->locked = 0 would work here.
  // The xchg being asm volatile ensures gcc emits it after
  // the above assignments (and after the critical section).
  xchg(&lk->locked, 0);
801053fc:	8b 45 08             	mov    0x8(%ebp),%eax
801053ff:	83 ec 08             	sub    $0x8,%esp
80105402:	6a 00                	push   $0x0
80105404:	50                   	push   %eax
80105405:	e8 16 ff ff ff       	call   80105320 <xchg>
8010540a:	83 c4 10             	add    $0x10,%esp

  popcli();
8010540d:	e8 ec 00 00 00       	call   801054fe <popcli>
}
80105412:	90                   	nop
80105413:	c9                   	leave  
80105414:	c3                   	ret    

80105415 <getcallerpcs>:

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80105415:	55                   	push   %ebp
80105416:	89 e5                	mov    %esp,%ebp
80105418:	83 ec 10             	sub    $0x10,%esp
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
8010541b:	8b 45 08             	mov    0x8(%ebp),%eax
8010541e:	83 e8 08             	sub    $0x8,%eax
80105421:	89 45 fc             	mov    %eax,-0x4(%ebp)
  for(i = 0; i < 10; i++){
80105424:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
8010542b:	eb 38                	jmp    80105465 <getcallerpcs+0x50>
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
8010542d:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
80105431:	74 53                	je     80105486 <getcallerpcs+0x71>
80105433:	81 7d fc ff ff ff 7f 	cmpl   $0x7fffffff,-0x4(%ebp)
8010543a:	76 4a                	jbe    80105486 <getcallerpcs+0x71>
8010543c:	83 7d fc ff          	cmpl   $0xffffffff,-0x4(%ebp)
80105440:	74 44                	je     80105486 <getcallerpcs+0x71>
      break;
    pcs[i] = ebp[1];     // saved %eip
80105442:	8b 45 f8             	mov    -0x8(%ebp),%eax
80105445:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
8010544c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010544f:	01 c2                	add    %eax,%edx
80105451:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105454:	8b 40 04             	mov    0x4(%eax),%eax
80105457:	89 02                	mov    %eax,(%edx)
    ebp = (uint*)ebp[0]; // saved %ebp
80105459:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010545c:	8b 00                	mov    (%eax),%eax
8010545e:	89 45 fc             	mov    %eax,-0x4(%ebp)
{
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80105461:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
80105465:	83 7d f8 09          	cmpl   $0x9,-0x8(%ebp)
80105469:	7e c2                	jle    8010542d <getcallerpcs+0x18>
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
8010546b:	eb 19                	jmp    80105486 <getcallerpcs+0x71>
    pcs[i] = 0;
8010546d:	8b 45 f8             	mov    -0x8(%ebp),%eax
80105470:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80105477:	8b 45 0c             	mov    0xc(%ebp),%eax
8010547a:	01 d0                	add    %edx,%eax
8010547c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
80105482:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
80105486:	83 7d f8 09          	cmpl   $0x9,-0x8(%ebp)
8010548a:	7e e1                	jle    8010546d <getcallerpcs+0x58>
    pcs[i] = 0;
}
8010548c:	90                   	nop
8010548d:	c9                   	leave  
8010548e:	c3                   	ret    

8010548f <holding>:

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
8010548f:	55                   	push   %ebp
80105490:	89 e5                	mov    %esp,%ebp
  return lock->locked && lock->cpu == cpu;
80105492:	8b 45 08             	mov    0x8(%ebp),%eax
80105495:	8b 00                	mov    (%eax),%eax
80105497:	85 c0                	test   %eax,%eax
80105499:	74 17                	je     801054b2 <holding+0x23>
8010549b:	8b 45 08             	mov    0x8(%ebp),%eax
8010549e:	8b 50 08             	mov    0x8(%eax),%edx
801054a1:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801054a7:	39 c2                	cmp    %eax,%edx
801054a9:	75 07                	jne    801054b2 <holding+0x23>
801054ab:	b8 01 00 00 00       	mov    $0x1,%eax
801054b0:	eb 05                	jmp    801054b7 <holding+0x28>
801054b2:	b8 00 00 00 00       	mov    $0x0,%eax
}
801054b7:	5d                   	pop    %ebp
801054b8:	c3                   	ret    

801054b9 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
801054b9:	55                   	push   %ebp
801054ba:	89 e5                	mov    %esp,%ebp
801054bc:	83 ec 10             	sub    $0x10,%esp
  int eflags;
  
  eflags = readeflags();
801054bf:	e8 3e fe ff ff       	call   80105302 <readeflags>
801054c4:	89 45 fc             	mov    %eax,-0x4(%ebp)
  cli();
801054c7:	e8 46 fe ff ff       	call   80105312 <cli>
  if(cpu->ncli++ == 0)
801054cc:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
801054d3:	8b 82 ac 00 00 00    	mov    0xac(%edx),%eax
801054d9:	8d 48 01             	lea    0x1(%eax),%ecx
801054dc:	89 8a ac 00 00 00    	mov    %ecx,0xac(%edx)
801054e2:	85 c0                	test   %eax,%eax
801054e4:	75 15                	jne    801054fb <pushcli+0x42>
    cpu->intena = eflags & FL_IF;
801054e6:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801054ec:	8b 55 fc             	mov    -0x4(%ebp),%edx
801054ef:	81 e2 00 02 00 00    	and    $0x200,%edx
801054f5:	89 90 b0 00 00 00    	mov    %edx,0xb0(%eax)
}
801054fb:	90                   	nop
801054fc:	c9                   	leave  
801054fd:	c3                   	ret    

801054fe <popcli>:

void
popcli(void)
{
801054fe:	55                   	push   %ebp
801054ff:	89 e5                	mov    %esp,%ebp
80105501:	83 ec 08             	sub    $0x8,%esp
  if(readeflags()&FL_IF)
80105504:	e8 f9 fd ff ff       	call   80105302 <readeflags>
80105509:	25 00 02 00 00       	and    $0x200,%eax
8010550e:	85 c0                	test   %eax,%eax
80105510:	74 0d                	je     8010551f <popcli+0x21>
    panic("popcli - interruptible");
80105512:	83 ec 0c             	sub    $0xc,%esp
80105515:	68 4b 8d 10 80       	push   $0x80108d4b
8010551a:	e8 43 b0 ff ff       	call   80100562 <panic>
  if(--cpu->ncli < 0)
8010551f:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80105525:	8b 90 ac 00 00 00    	mov    0xac(%eax),%edx
8010552b:	83 ea 01             	sub    $0x1,%edx
8010552e:	89 90 ac 00 00 00    	mov    %edx,0xac(%eax)
80105534:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
8010553a:	85 c0                	test   %eax,%eax
8010553c:	79 0d                	jns    8010554b <popcli+0x4d>
    panic("popcli");
8010553e:	83 ec 0c             	sub    $0xc,%esp
80105541:	68 62 8d 10 80       	push   $0x80108d62
80105546:	e8 17 b0 ff ff       	call   80100562 <panic>
  if(cpu->ncli == 0 && cpu->intena)
8010554b:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80105551:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
80105557:	85 c0                	test   %eax,%eax
80105559:	75 15                	jne    80105570 <popcli+0x72>
8010555b:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80105561:	8b 80 b0 00 00 00    	mov    0xb0(%eax),%eax
80105567:	85 c0                	test   %eax,%eax
80105569:	74 05                	je     80105570 <popcli+0x72>
    sti();
8010556b:	e8 a9 fd ff ff       	call   80105319 <sti>
}
80105570:	90                   	nop
80105571:	c9                   	leave  
80105572:	c3                   	ret    

80105573 <stosb>:
80105573:	55                   	push   %ebp
80105574:	89 e5                	mov    %esp,%ebp
80105576:	57                   	push   %edi
80105577:	53                   	push   %ebx
80105578:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010557b:	8b 55 10             	mov    0x10(%ebp),%edx
8010557e:	8b 45 0c             	mov    0xc(%ebp),%eax
80105581:	89 cb                	mov    %ecx,%ebx
80105583:	89 df                	mov    %ebx,%edi
80105585:	89 d1                	mov    %edx,%ecx
80105587:	fc                   	cld    
80105588:	f3 aa                	rep stos %al,%es:(%edi)
8010558a:	89 ca                	mov    %ecx,%edx
8010558c:	89 fb                	mov    %edi,%ebx
8010558e:	89 5d 08             	mov    %ebx,0x8(%ebp)
80105591:	89 55 10             	mov    %edx,0x10(%ebp)
80105594:	5b                   	pop    %ebx
80105595:	5f                   	pop    %edi
80105596:	5d                   	pop    %ebp
80105597:	c3                   	ret    

80105598 <stosl>:
80105598:	55                   	push   %ebp
80105599:	89 e5                	mov    %esp,%ebp
8010559b:	57                   	push   %edi
8010559c:	53                   	push   %ebx
8010559d:	8b 4d 08             	mov    0x8(%ebp),%ecx
801055a0:	8b 55 10             	mov    0x10(%ebp),%edx
801055a3:	8b 45 0c             	mov    0xc(%ebp),%eax
801055a6:	89 cb                	mov    %ecx,%ebx
801055a8:	89 df                	mov    %ebx,%edi
801055aa:	89 d1                	mov    %edx,%ecx
801055ac:	fc                   	cld    
801055ad:	f3 ab                	rep stos %eax,%es:(%edi)
801055af:	89 ca                	mov    %ecx,%edx
801055b1:	89 fb                	mov    %edi,%ebx
801055b3:	89 5d 08             	mov    %ebx,0x8(%ebp)
801055b6:	89 55 10             	mov    %edx,0x10(%ebp)
801055b9:	5b                   	pop    %ebx
801055ba:	5f                   	pop    %edi
801055bb:	5d                   	pop    %ebp
801055bc:	c3                   	ret    

801055bd <memset>:
801055bd:	55                   	push   %ebp
801055be:	89 e5                	mov    %esp,%ebp
801055c0:	8b 45 08             	mov    0x8(%ebp),%eax
801055c3:	83 e0 03             	and    $0x3,%eax
801055c6:	85 c0                	test   %eax,%eax
801055c8:	75 43                	jne    8010560d <memset+0x50>
801055ca:	8b 45 10             	mov    0x10(%ebp),%eax
801055cd:	83 e0 03             	and    $0x3,%eax
801055d0:	85 c0                	test   %eax,%eax
801055d2:	75 39                	jne    8010560d <memset+0x50>
801055d4:	81 65 0c ff 00 00 00 	andl   $0xff,0xc(%ebp)
801055db:	8b 45 10             	mov    0x10(%ebp),%eax
801055de:	c1 e8 02             	shr    $0x2,%eax
801055e1:	89 c1                	mov    %eax,%ecx
801055e3:	8b 45 0c             	mov    0xc(%ebp),%eax
801055e6:	c1 e0 18             	shl    $0x18,%eax
801055e9:	89 c2                	mov    %eax,%edx
801055eb:	8b 45 0c             	mov    0xc(%ebp),%eax
801055ee:	c1 e0 10             	shl    $0x10,%eax
801055f1:	09 c2                	or     %eax,%edx
801055f3:	8b 45 0c             	mov    0xc(%ebp),%eax
801055f6:	c1 e0 08             	shl    $0x8,%eax
801055f9:	09 d0                	or     %edx,%eax
801055fb:	0b 45 0c             	or     0xc(%ebp),%eax
801055fe:	51                   	push   %ecx
801055ff:	50                   	push   %eax
80105600:	ff 75 08             	pushl  0x8(%ebp)
80105603:	e8 90 ff ff ff       	call   80105598 <stosl>
80105608:	83 c4 0c             	add    $0xc,%esp
8010560b:	eb 12                	jmp    8010561f <memset+0x62>
8010560d:	8b 45 10             	mov    0x10(%ebp),%eax
80105610:	50                   	push   %eax
80105611:	ff 75 0c             	pushl  0xc(%ebp)
80105614:	ff 75 08             	pushl  0x8(%ebp)
80105617:	e8 57 ff ff ff       	call   80105573 <stosb>
8010561c:	83 c4 0c             	add    $0xc,%esp
8010561f:	8b 45 08             	mov    0x8(%ebp),%eax
80105622:	c9                   	leave  
80105623:	c3                   	ret    

80105624 <memcmp>:
80105624:	55                   	push   %ebp
80105625:	89 e5                	mov    %esp,%ebp
80105627:	83 ec 10             	sub    $0x10,%esp
8010562a:	8b 45 08             	mov    0x8(%ebp),%eax
8010562d:	89 45 fc             	mov    %eax,-0x4(%ebp)
80105630:	8b 45 0c             	mov    0xc(%ebp),%eax
80105633:	89 45 f8             	mov    %eax,-0x8(%ebp)
80105636:	eb 30                	jmp    80105668 <memcmp+0x44>
80105638:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010563b:	0f b6 10             	movzbl (%eax),%edx
8010563e:	8b 45 f8             	mov    -0x8(%ebp),%eax
80105641:	0f b6 00             	movzbl (%eax),%eax
80105644:	38 c2                	cmp    %al,%dl
80105646:	74 18                	je     80105660 <memcmp+0x3c>
80105648:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010564b:	0f b6 00             	movzbl (%eax),%eax
8010564e:	0f b6 d0             	movzbl %al,%edx
80105651:	8b 45 f8             	mov    -0x8(%ebp),%eax
80105654:	0f b6 00             	movzbl (%eax),%eax
80105657:	0f b6 c0             	movzbl %al,%eax
8010565a:	29 c2                	sub    %eax,%edx
8010565c:	89 d0                	mov    %edx,%eax
8010565e:	eb 1a                	jmp    8010567a <memcmp+0x56>
80105660:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80105664:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
80105668:	8b 45 10             	mov    0x10(%ebp),%eax
8010566b:	8d 50 ff             	lea    -0x1(%eax),%edx
8010566e:	89 55 10             	mov    %edx,0x10(%ebp)
80105671:	85 c0                	test   %eax,%eax
80105673:	75 c3                	jne    80105638 <memcmp+0x14>
80105675:	b8 00 00 00 00       	mov    $0x0,%eax
8010567a:	c9                   	leave  
8010567b:	c3                   	ret    

8010567c <memmove>:
8010567c:	55                   	push   %ebp
8010567d:	89 e5                	mov    %esp,%ebp
8010567f:	83 ec 10             	sub    $0x10,%esp
80105682:	8b 45 0c             	mov    0xc(%ebp),%eax
80105685:	89 45 fc             	mov    %eax,-0x4(%ebp)
80105688:	8b 45 08             	mov    0x8(%ebp),%eax
8010568b:	89 45 f8             	mov    %eax,-0x8(%ebp)
8010568e:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105691:	3b 45 f8             	cmp    -0x8(%ebp),%eax
80105694:	73 3d                	jae    801056d3 <memmove+0x57>
80105696:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105699:	8b 45 10             	mov    0x10(%ebp),%eax
8010569c:	01 d0                	add    %edx,%eax
8010569e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
801056a1:	76 30                	jbe    801056d3 <memmove+0x57>
801056a3:	8b 45 10             	mov    0x10(%ebp),%eax
801056a6:	01 45 fc             	add    %eax,-0x4(%ebp)
801056a9:	8b 45 10             	mov    0x10(%ebp),%eax
801056ac:	01 45 f8             	add    %eax,-0x8(%ebp)
801056af:	eb 13                	jmp    801056c4 <memmove+0x48>
801056b1:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
801056b5:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
801056b9:	8b 45 fc             	mov    -0x4(%ebp),%eax
801056bc:	0f b6 10             	movzbl (%eax),%edx
801056bf:	8b 45 f8             	mov    -0x8(%ebp),%eax
801056c2:	88 10                	mov    %dl,(%eax)
801056c4:	8b 45 10             	mov    0x10(%ebp),%eax
801056c7:	8d 50 ff             	lea    -0x1(%eax),%edx
801056ca:	89 55 10             	mov    %edx,0x10(%ebp)
801056cd:	85 c0                	test   %eax,%eax
801056cf:	75 e0                	jne    801056b1 <memmove+0x35>
801056d1:	eb 26                	jmp    801056f9 <memmove+0x7d>
801056d3:	eb 17                	jmp    801056ec <memmove+0x70>
801056d5:	8b 45 f8             	mov    -0x8(%ebp),%eax
801056d8:	8d 50 01             	lea    0x1(%eax),%edx
801056db:	89 55 f8             	mov    %edx,-0x8(%ebp)
801056de:	8b 55 fc             	mov    -0x4(%ebp),%edx
801056e1:	8d 4a 01             	lea    0x1(%edx),%ecx
801056e4:	89 4d fc             	mov    %ecx,-0x4(%ebp)
801056e7:	0f b6 12             	movzbl (%edx),%edx
801056ea:	88 10                	mov    %dl,(%eax)
801056ec:	8b 45 10             	mov    0x10(%ebp),%eax
801056ef:	8d 50 ff             	lea    -0x1(%eax),%edx
801056f2:	89 55 10             	mov    %edx,0x10(%ebp)
801056f5:	85 c0                	test   %eax,%eax
801056f7:	75 dc                	jne    801056d5 <memmove+0x59>
801056f9:	8b 45 08             	mov    0x8(%ebp),%eax
801056fc:	c9                   	leave  
801056fd:	c3                   	ret    

801056fe <memcpy>:
801056fe:	55                   	push   %ebp
801056ff:	89 e5                	mov    %esp,%ebp
80105701:	ff 75 10             	pushl  0x10(%ebp)
80105704:	ff 75 0c             	pushl  0xc(%ebp)
80105707:	ff 75 08             	pushl  0x8(%ebp)
8010570a:	e8 6d ff ff ff       	call   8010567c <memmove>
8010570f:	83 c4 0c             	add    $0xc,%esp
80105712:	c9                   	leave  
80105713:	c3                   	ret    

80105714 <strncmp>:
80105714:	55                   	push   %ebp
80105715:	89 e5                	mov    %esp,%ebp
80105717:	eb 0c                	jmp    80105725 <strncmp+0x11>
80105719:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
8010571d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
80105721:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
80105725:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80105729:	74 1a                	je     80105745 <strncmp+0x31>
8010572b:	8b 45 08             	mov    0x8(%ebp),%eax
8010572e:	0f b6 00             	movzbl (%eax),%eax
80105731:	84 c0                	test   %al,%al
80105733:	74 10                	je     80105745 <strncmp+0x31>
80105735:	8b 45 08             	mov    0x8(%ebp),%eax
80105738:	0f b6 10             	movzbl (%eax),%edx
8010573b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010573e:	0f b6 00             	movzbl (%eax),%eax
80105741:	38 c2                	cmp    %al,%dl
80105743:	74 d4                	je     80105719 <strncmp+0x5>
80105745:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80105749:	75 07                	jne    80105752 <strncmp+0x3e>
8010574b:	b8 00 00 00 00       	mov    $0x0,%eax
80105750:	eb 16                	jmp    80105768 <strncmp+0x54>
80105752:	8b 45 08             	mov    0x8(%ebp),%eax
80105755:	0f b6 00             	movzbl (%eax),%eax
80105758:	0f b6 d0             	movzbl %al,%edx
8010575b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010575e:	0f b6 00             	movzbl (%eax),%eax
80105761:	0f b6 c0             	movzbl %al,%eax
80105764:	29 c2                	sub    %eax,%edx
80105766:	89 d0                	mov    %edx,%eax
80105768:	5d                   	pop    %ebp
80105769:	c3                   	ret    

8010576a <strncpy>:
8010576a:	55                   	push   %ebp
8010576b:	89 e5                	mov    %esp,%ebp
8010576d:	83 ec 10             	sub    $0x10,%esp
80105770:	8b 45 08             	mov    0x8(%ebp),%eax
80105773:	89 45 fc             	mov    %eax,-0x4(%ebp)
80105776:	90                   	nop
80105777:	8b 45 10             	mov    0x10(%ebp),%eax
8010577a:	8d 50 ff             	lea    -0x1(%eax),%edx
8010577d:	89 55 10             	mov    %edx,0x10(%ebp)
80105780:	85 c0                	test   %eax,%eax
80105782:	7e 1e                	jle    801057a2 <strncpy+0x38>
80105784:	8b 45 08             	mov    0x8(%ebp),%eax
80105787:	8d 50 01             	lea    0x1(%eax),%edx
8010578a:	89 55 08             	mov    %edx,0x8(%ebp)
8010578d:	8b 55 0c             	mov    0xc(%ebp),%edx
80105790:	8d 4a 01             	lea    0x1(%edx),%ecx
80105793:	89 4d 0c             	mov    %ecx,0xc(%ebp)
80105796:	0f b6 12             	movzbl (%edx),%edx
80105799:	88 10                	mov    %dl,(%eax)
8010579b:	0f b6 00             	movzbl (%eax),%eax
8010579e:	84 c0                	test   %al,%al
801057a0:	75 d5                	jne    80105777 <strncpy+0xd>
801057a2:	eb 0c                	jmp    801057b0 <strncpy+0x46>
801057a4:	8b 45 08             	mov    0x8(%ebp),%eax
801057a7:	8d 50 01             	lea    0x1(%eax),%edx
801057aa:	89 55 08             	mov    %edx,0x8(%ebp)
801057ad:	c6 00 00             	movb   $0x0,(%eax)
801057b0:	8b 45 10             	mov    0x10(%ebp),%eax
801057b3:	8d 50 ff             	lea    -0x1(%eax),%edx
801057b6:	89 55 10             	mov    %edx,0x10(%ebp)
801057b9:	85 c0                	test   %eax,%eax
801057bb:	7f e7                	jg     801057a4 <strncpy+0x3a>
801057bd:	8b 45 fc             	mov    -0x4(%ebp),%eax
801057c0:	c9                   	leave  
801057c1:	c3                   	ret    

801057c2 <safestrcpy>:
801057c2:	55                   	push   %ebp
801057c3:	89 e5                	mov    %esp,%ebp
801057c5:	83 ec 10             	sub    $0x10,%esp
801057c8:	8b 45 08             	mov    0x8(%ebp),%eax
801057cb:	89 45 fc             	mov    %eax,-0x4(%ebp)
801057ce:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801057d2:	7f 05                	jg     801057d9 <safestrcpy+0x17>
801057d4:	8b 45 fc             	mov    -0x4(%ebp),%eax
801057d7:	eb 31                	jmp    8010580a <safestrcpy+0x48>
801057d9:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
801057dd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801057e1:	7e 1e                	jle    80105801 <safestrcpy+0x3f>
801057e3:	8b 45 08             	mov    0x8(%ebp),%eax
801057e6:	8d 50 01             	lea    0x1(%eax),%edx
801057e9:	89 55 08             	mov    %edx,0x8(%ebp)
801057ec:	8b 55 0c             	mov    0xc(%ebp),%edx
801057ef:	8d 4a 01             	lea    0x1(%edx),%ecx
801057f2:	89 4d 0c             	mov    %ecx,0xc(%ebp)
801057f5:	0f b6 12             	movzbl (%edx),%edx
801057f8:	88 10                	mov    %dl,(%eax)
801057fa:	0f b6 00             	movzbl (%eax),%eax
801057fd:	84 c0                	test   %al,%al
801057ff:	75 d8                	jne    801057d9 <safestrcpy+0x17>
80105801:	8b 45 08             	mov    0x8(%ebp),%eax
80105804:	c6 00 00             	movb   $0x0,(%eax)
80105807:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010580a:	c9                   	leave  
8010580b:	c3                   	ret    

8010580c <strlen>:
8010580c:	55                   	push   %ebp
8010580d:	89 e5                	mov    %esp,%ebp
8010580f:	83 ec 10             	sub    $0x10,%esp
80105812:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
80105819:	eb 04                	jmp    8010581f <strlen+0x13>
8010581b:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
8010581f:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105822:	8b 45 08             	mov    0x8(%ebp),%eax
80105825:	01 d0                	add    %edx,%eax
80105827:	0f b6 00             	movzbl (%eax),%eax
8010582a:	84 c0                	test   %al,%al
8010582c:	75 ed                	jne    8010581b <strlen+0xf>
8010582e:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105831:	c9                   	leave  
80105832:	c3                   	ret    

80105833 <swtch>:
80105833:	8b 44 24 04          	mov    0x4(%esp),%eax
80105837:	8b 54 24 08          	mov    0x8(%esp),%edx
8010583b:	55                   	push   %ebp
8010583c:	53                   	push   %ebx
8010583d:	56                   	push   %esi
8010583e:	57                   	push   %edi
8010583f:	89 20                	mov    %esp,(%eax)
80105841:	89 d4                	mov    %edx,%esp
80105843:	5f                   	pop    %edi
80105844:	5e                   	pop    %esi
80105845:	5b                   	pop    %ebx
80105846:	5d                   	pop    %ebp
80105847:	c3                   	ret    

80105848 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80105848:	55                   	push   %ebp
80105849:	89 e5                	mov    %esp,%ebp
  if(addr >= proc->sz || addr+4 > proc->sz)
8010584b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105851:	8b 00                	mov    (%eax),%eax
80105853:	3b 45 08             	cmp    0x8(%ebp),%eax
80105856:	76 12                	jbe    8010586a <fetchint+0x22>
80105858:	8b 45 08             	mov    0x8(%ebp),%eax
8010585b:	8d 50 04             	lea    0x4(%eax),%edx
8010585e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105864:	8b 00                	mov    (%eax),%eax
80105866:	39 c2                	cmp    %eax,%edx
80105868:	76 07                	jbe    80105871 <fetchint+0x29>
    return -1;
8010586a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010586f:	eb 0f                	jmp    80105880 <fetchint+0x38>
  *ip = *(int*)(addr);
80105871:	8b 45 08             	mov    0x8(%ebp),%eax
80105874:	8b 10                	mov    (%eax),%edx
80105876:	8b 45 0c             	mov    0xc(%ebp),%eax
80105879:	89 10                	mov    %edx,(%eax)
  return 0;
8010587b:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105880:	5d                   	pop    %ebp
80105881:	c3                   	ret    

80105882 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80105882:	55                   	push   %ebp
80105883:	89 e5                	mov    %esp,%ebp
80105885:	83 ec 10             	sub    $0x10,%esp
  char *s, *ep;

  if(addr >= proc->sz)
80105888:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010588e:	8b 00                	mov    (%eax),%eax
80105890:	3b 45 08             	cmp    0x8(%ebp),%eax
80105893:	77 07                	ja     8010589c <fetchstr+0x1a>
    return -1;
80105895:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010589a:	eb 46                	jmp    801058e2 <fetchstr+0x60>
  *pp = (char*)addr;
8010589c:	8b 55 08             	mov    0x8(%ebp),%edx
8010589f:	8b 45 0c             	mov    0xc(%ebp),%eax
801058a2:	89 10                	mov    %edx,(%eax)
  ep = (char*)proc->sz;
801058a4:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801058aa:	8b 00                	mov    (%eax),%eax
801058ac:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(s = *pp; s < ep; s++)
801058af:	8b 45 0c             	mov    0xc(%ebp),%eax
801058b2:	8b 00                	mov    (%eax),%eax
801058b4:	89 45 fc             	mov    %eax,-0x4(%ebp)
801058b7:	eb 1c                	jmp    801058d5 <fetchstr+0x53>
    if(*s == 0)
801058b9:	8b 45 fc             	mov    -0x4(%ebp),%eax
801058bc:	0f b6 00             	movzbl (%eax),%eax
801058bf:	84 c0                	test   %al,%al
801058c1:	75 0e                	jne    801058d1 <fetchstr+0x4f>
      return s - *pp;
801058c3:	8b 55 fc             	mov    -0x4(%ebp),%edx
801058c6:	8b 45 0c             	mov    0xc(%ebp),%eax
801058c9:	8b 00                	mov    (%eax),%eax
801058cb:	29 c2                	sub    %eax,%edx
801058cd:	89 d0                	mov    %edx,%eax
801058cf:	eb 11                	jmp    801058e2 <fetchstr+0x60>

  if(addr >= proc->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)proc->sz;
  for(s = *pp; s < ep; s++)
801058d1:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
801058d5:	8b 45 fc             	mov    -0x4(%ebp),%eax
801058d8:	3b 45 f8             	cmp    -0x8(%ebp),%eax
801058db:	72 dc                	jb     801058b9 <fetchstr+0x37>
    if(*s == 0)
      return s - *pp;
  return -1;
801058dd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801058e2:	c9                   	leave  
801058e3:	c3                   	ret    

801058e4 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
801058e4:	55                   	push   %ebp
801058e5:	89 e5                	mov    %esp,%ebp
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
801058e7:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801058ed:	8b 40 18             	mov    0x18(%eax),%eax
801058f0:	8b 40 44             	mov    0x44(%eax),%eax
801058f3:	8b 55 08             	mov    0x8(%ebp),%edx
801058f6:	c1 e2 02             	shl    $0x2,%edx
801058f9:	01 d0                	add    %edx,%eax
801058fb:	83 c0 04             	add    $0x4,%eax
801058fe:	ff 75 0c             	pushl  0xc(%ebp)
80105901:	50                   	push   %eax
80105902:	e8 41 ff ff ff       	call   80105848 <fetchint>
80105907:	83 c4 08             	add    $0x8,%esp
}
8010590a:	c9                   	leave  
8010590b:	c3                   	ret    

8010590c <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size n bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
8010590c:	55                   	push   %ebp
8010590d:	89 e5                	mov    %esp,%ebp
8010590f:	83 ec 10             	sub    $0x10,%esp
  int i;
  
  if(argint(n, &i) < 0)
80105912:	8d 45 fc             	lea    -0x4(%ebp),%eax
80105915:	50                   	push   %eax
80105916:	ff 75 08             	pushl  0x8(%ebp)
80105919:	e8 c6 ff ff ff       	call   801058e4 <argint>
8010591e:	83 c4 08             	add    $0x8,%esp
80105921:	85 c0                	test   %eax,%eax
80105923:	79 07                	jns    8010592c <argptr+0x20>
    return -1;
80105925:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010592a:	eb 3b                	jmp    80105967 <argptr+0x5b>
  if((uint)i >= proc->sz || (uint)i+size > proc->sz)
8010592c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105932:	8b 00                	mov    (%eax),%eax
80105934:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105937:	39 d0                	cmp    %edx,%eax
80105939:	76 16                	jbe    80105951 <argptr+0x45>
8010593b:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010593e:	89 c2                	mov    %eax,%edx
80105940:	8b 45 10             	mov    0x10(%ebp),%eax
80105943:	01 c2                	add    %eax,%edx
80105945:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010594b:	8b 00                	mov    (%eax),%eax
8010594d:	39 c2                	cmp    %eax,%edx
8010594f:	76 07                	jbe    80105958 <argptr+0x4c>
    return -1;
80105951:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105956:	eb 0f                	jmp    80105967 <argptr+0x5b>
  *pp = (char*)i;
80105958:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010595b:	89 c2                	mov    %eax,%edx
8010595d:	8b 45 0c             	mov    0xc(%ebp),%eax
80105960:	89 10                	mov    %edx,(%eax)
  return 0;
80105962:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105967:	c9                   	leave  
80105968:	c3                   	ret    

80105969 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80105969:	55                   	push   %ebp
8010596a:	89 e5                	mov    %esp,%ebp
8010596c:	83 ec 10             	sub    $0x10,%esp
  int addr;
  if(argint(n, &addr) < 0)
8010596f:	8d 45 fc             	lea    -0x4(%ebp),%eax
80105972:	50                   	push   %eax
80105973:	ff 75 08             	pushl  0x8(%ebp)
80105976:	e8 69 ff ff ff       	call   801058e4 <argint>
8010597b:	83 c4 08             	add    $0x8,%esp
8010597e:	85 c0                	test   %eax,%eax
80105980:	79 07                	jns    80105989 <argstr+0x20>
    return -1;
80105982:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105987:	eb 0f                	jmp    80105998 <argstr+0x2f>
  return fetchstr(addr, pp);
80105989:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010598c:	ff 75 0c             	pushl  0xc(%ebp)
8010598f:	50                   	push   %eax
80105990:	e8 ed fe ff ff       	call   80105882 <fetchstr>
80105995:	83 c4 08             	add    $0x8,%esp
}
80105998:	c9                   	leave  
80105999:	c3                   	ret    

8010599a <syscall>:
[SYS_close]   sys_close,
};

void
syscall(void)
{
8010599a:	55                   	push   %ebp
8010599b:	89 e5                	mov    %esp,%ebp
8010599d:	53                   	push   %ebx
8010599e:	83 ec 14             	sub    $0x14,%esp
  int num;

  num = proc->tf->eax;
801059a1:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801059a7:	8b 40 18             	mov    0x18(%eax),%eax
801059aa:	8b 40 1c             	mov    0x1c(%eax),%eax
801059ad:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
801059b0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801059b4:	7e 30                	jle    801059e6 <syscall+0x4c>
801059b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801059b9:	83 f8 15             	cmp    $0x15,%eax
801059bc:	77 28                	ja     801059e6 <syscall+0x4c>
801059be:	8b 45 f4             	mov    -0xc(%ebp),%eax
801059c1:	8b 04 85 40 c0 10 80 	mov    -0x7fef3fc0(,%eax,4),%eax
801059c8:	85 c0                	test   %eax,%eax
801059ca:	74 1a                	je     801059e6 <syscall+0x4c>
    proc->tf->eax = syscalls[num]();
801059cc:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801059d2:	8b 58 18             	mov    0x18(%eax),%ebx
801059d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801059d8:	8b 04 85 40 c0 10 80 	mov    -0x7fef3fc0(,%eax,4),%eax
801059df:	ff d0                	call   *%eax
801059e1:	89 43 1c             	mov    %eax,0x1c(%ebx)
801059e4:	eb 34                	jmp    80105a1a <syscall+0x80>
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            proc->pid, proc->name, num);
801059e6:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801059ec:	8d 50 6c             	lea    0x6c(%eax),%edx
801059ef:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax

  num = proc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    proc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
801059f5:	8b 40 10             	mov    0x10(%eax),%eax
801059f8:	ff 75 f4             	pushl  -0xc(%ebp)
801059fb:	52                   	push   %edx
801059fc:	50                   	push   %eax
801059fd:	68 69 8d 10 80       	push   $0x80108d69
80105a02:	e8 bb a9 ff ff       	call   801003c2 <cprintf>
80105a07:	83 c4 10             	add    $0x10,%esp
            proc->pid, proc->name, num);
    proc->tf->eax = -1;
80105a0a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105a10:	8b 40 18             	mov    0x18(%eax),%eax
80105a13:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
  }
}
80105a1a:	90                   	nop
80105a1b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105a1e:	c9                   	leave  
80105a1f:	c3                   	ret    

80105a20 <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
80105a20:	55                   	push   %ebp
80105a21:	89 e5                	mov    %esp,%ebp
80105a23:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
80105a26:	83 ec 08             	sub    $0x8,%esp
80105a29:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105a2c:	50                   	push   %eax
80105a2d:	ff 75 08             	pushl  0x8(%ebp)
80105a30:	e8 af fe ff ff       	call   801058e4 <argint>
80105a35:	83 c4 10             	add    $0x10,%esp
80105a38:	85 c0                	test   %eax,%eax
80105a3a:	79 07                	jns    80105a43 <argfd+0x23>
    return -1;
80105a3c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105a41:	eb 50                	jmp    80105a93 <argfd+0x73>
  if(fd < 0 || fd >= NOFILE || (f=proc->ofile[fd]) == 0)
80105a43:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105a46:	85 c0                	test   %eax,%eax
80105a48:	78 21                	js     80105a6b <argfd+0x4b>
80105a4a:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105a4d:	83 f8 0f             	cmp    $0xf,%eax
80105a50:	7f 19                	jg     80105a6b <argfd+0x4b>
80105a52:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105a58:	8b 55 f0             	mov    -0x10(%ebp),%edx
80105a5b:	83 c2 08             	add    $0x8,%edx
80105a5e:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80105a62:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105a65:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105a69:	75 07                	jne    80105a72 <argfd+0x52>
    return -1;
80105a6b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105a70:	eb 21                	jmp    80105a93 <argfd+0x73>
  if(pfd)
80105a72:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80105a76:	74 08                	je     80105a80 <argfd+0x60>
    *pfd = fd;
80105a78:	8b 55 f0             	mov    -0x10(%ebp),%edx
80105a7b:	8b 45 0c             	mov    0xc(%ebp),%eax
80105a7e:	89 10                	mov    %edx,(%eax)
  if(pf)
80105a80:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80105a84:	74 08                	je     80105a8e <argfd+0x6e>
    *pf = f;
80105a86:	8b 45 10             	mov    0x10(%ebp),%eax
80105a89:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105a8c:	89 10                	mov    %edx,(%eax)
  return 0;
80105a8e:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105a93:	c9                   	leave  
80105a94:	c3                   	ret    

80105a95 <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
80105a95:	55                   	push   %ebp
80105a96:	89 e5                	mov    %esp,%ebp
80105a98:	83 ec 10             	sub    $0x10,%esp
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
80105a9b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
80105aa2:	eb 30                	jmp    80105ad4 <fdalloc+0x3f>
    if(proc->ofile[fd] == 0){
80105aa4:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105aaa:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105aad:	83 c2 08             	add    $0x8,%edx
80105ab0:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80105ab4:	85 c0                	test   %eax,%eax
80105ab6:	75 18                	jne    80105ad0 <fdalloc+0x3b>
      proc->ofile[fd] = f;
80105ab8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105abe:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105ac1:	8d 4a 08             	lea    0x8(%edx),%ecx
80105ac4:	8b 55 08             	mov    0x8(%ebp),%edx
80105ac7:	89 54 88 08          	mov    %edx,0x8(%eax,%ecx,4)
      return fd;
80105acb:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105ace:	eb 0f                	jmp    80105adf <fdalloc+0x4a>
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
80105ad0:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80105ad4:	83 7d fc 0f          	cmpl   $0xf,-0x4(%ebp)
80105ad8:	7e ca                	jle    80105aa4 <fdalloc+0xf>
    if(proc->ofile[fd] == 0){
      proc->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
80105ada:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105adf:	c9                   	leave  
80105ae0:	c3                   	ret    

80105ae1 <sys_dup>:

int
sys_dup(void)
{
80105ae1:	55                   	push   %ebp
80105ae2:	89 e5                	mov    %esp,%ebp
80105ae4:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int fd;
  
  if(argfd(0, 0, &f) < 0)
80105ae7:	83 ec 04             	sub    $0x4,%esp
80105aea:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105aed:	50                   	push   %eax
80105aee:	6a 00                	push   $0x0
80105af0:	6a 00                	push   $0x0
80105af2:	e8 29 ff ff ff       	call   80105a20 <argfd>
80105af7:	83 c4 10             	add    $0x10,%esp
80105afa:	85 c0                	test   %eax,%eax
80105afc:	79 07                	jns    80105b05 <sys_dup+0x24>
    return -1;
80105afe:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b03:	eb 31                	jmp    80105b36 <sys_dup+0x55>
  if((fd=fdalloc(f)) < 0)
80105b05:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105b08:	83 ec 0c             	sub    $0xc,%esp
80105b0b:	50                   	push   %eax
80105b0c:	e8 84 ff ff ff       	call   80105a95 <fdalloc>
80105b11:	83 c4 10             	add    $0x10,%esp
80105b14:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105b17:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105b1b:	79 07                	jns    80105b24 <sys_dup+0x43>
    return -1;
80105b1d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b22:	eb 12                	jmp    80105b36 <sys_dup+0x55>
  filedup(f);
80105b24:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105b27:	83 ec 0c             	sub    $0xc,%esp
80105b2a:	50                   	push   %eax
80105b2b:	e8 af b4 ff ff       	call   80100fdf <filedup>
80105b30:	83 c4 10             	add    $0x10,%esp
  return fd;
80105b33:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80105b36:	c9                   	leave  
80105b37:	c3                   	ret    

80105b38 <sys_read>:

int
sys_read(void)
{
80105b38:	55                   	push   %ebp
80105b39:	89 e5                	mov    %esp,%ebp
80105b3b:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105b3e:	83 ec 04             	sub    $0x4,%esp
80105b41:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105b44:	50                   	push   %eax
80105b45:	6a 00                	push   $0x0
80105b47:	6a 00                	push   $0x0
80105b49:	e8 d2 fe ff ff       	call   80105a20 <argfd>
80105b4e:	83 c4 10             	add    $0x10,%esp
80105b51:	85 c0                	test   %eax,%eax
80105b53:	78 2e                	js     80105b83 <sys_read+0x4b>
80105b55:	83 ec 08             	sub    $0x8,%esp
80105b58:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105b5b:	50                   	push   %eax
80105b5c:	6a 02                	push   $0x2
80105b5e:	e8 81 fd ff ff       	call   801058e4 <argint>
80105b63:	83 c4 10             	add    $0x10,%esp
80105b66:	85 c0                	test   %eax,%eax
80105b68:	78 19                	js     80105b83 <sys_read+0x4b>
80105b6a:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105b6d:	83 ec 04             	sub    $0x4,%esp
80105b70:	50                   	push   %eax
80105b71:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105b74:	50                   	push   %eax
80105b75:	6a 01                	push   $0x1
80105b77:	e8 90 fd ff ff       	call   8010590c <argptr>
80105b7c:	83 c4 10             	add    $0x10,%esp
80105b7f:	85 c0                	test   %eax,%eax
80105b81:	79 07                	jns    80105b8a <sys_read+0x52>
    return -1;
80105b83:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b88:	eb 17                	jmp    80105ba1 <sys_read+0x69>
  return fileread(f, p, n);
80105b8a:	8b 4d f0             	mov    -0x10(%ebp),%ecx
80105b8d:	8b 55 ec             	mov    -0x14(%ebp),%edx
80105b90:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105b93:	83 ec 04             	sub    $0x4,%esp
80105b96:	51                   	push   %ecx
80105b97:	52                   	push   %edx
80105b98:	50                   	push   %eax
80105b99:	e8 d1 b5 ff ff       	call   8010116f <fileread>
80105b9e:	83 c4 10             	add    $0x10,%esp
}
80105ba1:	c9                   	leave  
80105ba2:	c3                   	ret    

80105ba3 <sys_write>:

int
sys_write(void)
{
80105ba3:	55                   	push   %ebp
80105ba4:	89 e5                	mov    %esp,%ebp
80105ba6:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105ba9:	83 ec 04             	sub    $0x4,%esp
80105bac:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105baf:	50                   	push   %eax
80105bb0:	6a 00                	push   $0x0
80105bb2:	6a 00                	push   $0x0
80105bb4:	e8 67 fe ff ff       	call   80105a20 <argfd>
80105bb9:	83 c4 10             	add    $0x10,%esp
80105bbc:	85 c0                	test   %eax,%eax
80105bbe:	78 2e                	js     80105bee <sys_write+0x4b>
80105bc0:	83 ec 08             	sub    $0x8,%esp
80105bc3:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105bc6:	50                   	push   %eax
80105bc7:	6a 02                	push   $0x2
80105bc9:	e8 16 fd ff ff       	call   801058e4 <argint>
80105bce:	83 c4 10             	add    $0x10,%esp
80105bd1:	85 c0                	test   %eax,%eax
80105bd3:	78 19                	js     80105bee <sys_write+0x4b>
80105bd5:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105bd8:	83 ec 04             	sub    $0x4,%esp
80105bdb:	50                   	push   %eax
80105bdc:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105bdf:	50                   	push   %eax
80105be0:	6a 01                	push   $0x1
80105be2:	e8 25 fd ff ff       	call   8010590c <argptr>
80105be7:	83 c4 10             	add    $0x10,%esp
80105bea:	85 c0                	test   %eax,%eax
80105bec:	79 07                	jns    80105bf5 <sys_write+0x52>
    return -1;
80105bee:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105bf3:	eb 17                	jmp    80105c0c <sys_write+0x69>
  return filewrite(f, p, n);
80105bf5:	8b 4d f0             	mov    -0x10(%ebp),%ecx
80105bf8:	8b 55 ec             	mov    -0x14(%ebp),%edx
80105bfb:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105bfe:	83 ec 04             	sub    $0x4,%esp
80105c01:	51                   	push   %ecx
80105c02:	52                   	push   %edx
80105c03:	50                   	push   %eax
80105c04:	e8 1e b6 ff ff       	call   80101227 <filewrite>
80105c09:	83 c4 10             	add    $0x10,%esp
}
80105c0c:	c9                   	leave  
80105c0d:	c3                   	ret    

80105c0e <sys_close>:

int
sys_close(void)
{
80105c0e:	55                   	push   %ebp
80105c0f:	89 e5                	mov    %esp,%ebp
80105c11:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;
  
  if(argfd(0, &fd, &f) < 0)
80105c14:	83 ec 04             	sub    $0x4,%esp
80105c17:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105c1a:	50                   	push   %eax
80105c1b:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105c1e:	50                   	push   %eax
80105c1f:	6a 00                	push   $0x0
80105c21:	e8 fa fd ff ff       	call   80105a20 <argfd>
80105c26:	83 c4 10             	add    $0x10,%esp
80105c29:	85 c0                	test   %eax,%eax
80105c2b:	79 07                	jns    80105c34 <sys_close+0x26>
    return -1;
80105c2d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105c32:	eb 28                	jmp    80105c5c <sys_close+0x4e>
  proc->ofile[fd] = 0;
80105c34:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105c3a:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105c3d:	83 c2 08             	add    $0x8,%edx
80105c40:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
80105c47:	00 
  fileclose(f);
80105c48:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105c4b:	83 ec 0c             	sub    $0xc,%esp
80105c4e:	50                   	push   %eax
80105c4f:	e8 dc b3 ff ff       	call   80101030 <fileclose>
80105c54:	83 c4 10             	add    $0x10,%esp
  return 0;
80105c57:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105c5c:	c9                   	leave  
80105c5d:	c3                   	ret    

80105c5e <sys_fstat>:

int
sys_fstat(void)
{
80105c5e:	55                   	push   %ebp
80105c5f:	89 e5                	mov    %esp,%ebp
80105c61:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  struct stat *st;
  
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105c64:	83 ec 04             	sub    $0x4,%esp
80105c67:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105c6a:	50                   	push   %eax
80105c6b:	6a 00                	push   $0x0
80105c6d:	6a 00                	push   $0x0
80105c6f:	e8 ac fd ff ff       	call   80105a20 <argfd>
80105c74:	83 c4 10             	add    $0x10,%esp
80105c77:	85 c0                	test   %eax,%eax
80105c79:	78 17                	js     80105c92 <sys_fstat+0x34>
80105c7b:	83 ec 04             	sub    $0x4,%esp
80105c7e:	6a 14                	push   $0x14
80105c80:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105c83:	50                   	push   %eax
80105c84:	6a 01                	push   $0x1
80105c86:	e8 81 fc ff ff       	call   8010590c <argptr>
80105c8b:	83 c4 10             	add    $0x10,%esp
80105c8e:	85 c0                	test   %eax,%eax
80105c90:	79 07                	jns    80105c99 <sys_fstat+0x3b>
    return -1;
80105c92:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105c97:	eb 13                	jmp    80105cac <sys_fstat+0x4e>
  return filestat(f, st);
80105c99:	8b 55 f0             	mov    -0x10(%ebp),%edx
80105c9c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105c9f:	83 ec 08             	sub    $0x8,%esp
80105ca2:	52                   	push   %edx
80105ca3:	50                   	push   %eax
80105ca4:	e8 6f b4 ff ff       	call   80101118 <filestat>
80105ca9:	83 c4 10             	add    $0x10,%esp
}
80105cac:	c9                   	leave  
80105cad:	c3                   	ret    

80105cae <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80105cae:	55                   	push   %ebp
80105caf:	89 e5                	mov    %esp,%ebp
80105cb1:	83 ec 28             	sub    $0x28,%esp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105cb4:	83 ec 08             	sub    $0x8,%esp
80105cb7:	8d 45 d8             	lea    -0x28(%ebp),%eax
80105cba:	50                   	push   %eax
80105cbb:	6a 00                	push   $0x0
80105cbd:	e8 a7 fc ff ff       	call   80105969 <argstr>
80105cc2:	83 c4 10             	add    $0x10,%esp
80105cc5:	85 c0                	test   %eax,%eax
80105cc7:	78 15                	js     80105cde <sys_link+0x30>
80105cc9:	83 ec 08             	sub    $0x8,%esp
80105ccc:	8d 45 dc             	lea    -0x24(%ebp),%eax
80105ccf:	50                   	push   %eax
80105cd0:	6a 01                	push   $0x1
80105cd2:	e8 92 fc ff ff       	call   80105969 <argstr>
80105cd7:	83 c4 10             	add    $0x10,%esp
80105cda:	85 c0                	test   %eax,%eax
80105cdc:	79 0a                	jns    80105ce8 <sys_link+0x3a>
    return -1;
80105cde:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105ce3:	e9 68 01 00 00       	jmp    80105e50 <sys_link+0x1a2>

  begin_op();
80105ce8:	e8 28 d8 ff ff       	call   80103515 <begin_op>
  if((ip = namei(old)) == 0){
80105ced:	8b 45 d8             	mov    -0x28(%ebp),%eax
80105cf0:	83 ec 0c             	sub    $0xc,%esp
80105cf3:	50                   	push   %eax
80105cf4:	e8 0d c8 ff ff       	call   80102506 <namei>
80105cf9:	83 c4 10             	add    $0x10,%esp
80105cfc:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105cff:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105d03:	75 0f                	jne    80105d14 <sys_link+0x66>
    end_op();
80105d05:	e8 99 d8 ff ff       	call   801035a3 <end_op>
    return -1;
80105d0a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105d0f:	e9 3c 01 00 00       	jmp    80105e50 <sys_link+0x1a2>
  }

  ilock(ip);
80105d14:	83 ec 0c             	sub    $0xc,%esp
80105d17:	ff 75 f4             	pushl  -0xc(%ebp)
80105d1a:	e8 29 bc ff ff       	call   80101948 <ilock>
80105d1f:	83 c4 10             	add    $0x10,%esp
  if(ip->type == T_DIR){
80105d22:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105d25:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105d29:	66 83 f8 01          	cmp    $0x1,%ax
80105d2d:	75 1d                	jne    80105d4c <sys_link+0x9e>
    iunlockput(ip);
80105d2f:	83 ec 0c             	sub    $0xc,%esp
80105d32:	ff 75 f4             	pushl  -0xc(%ebp)
80105d35:	e8 ce be ff ff       	call   80101c08 <iunlockput>
80105d3a:	83 c4 10             	add    $0x10,%esp
    end_op();
80105d3d:	e8 61 d8 ff ff       	call   801035a3 <end_op>
    return -1;
80105d42:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105d47:	e9 04 01 00 00       	jmp    80105e50 <sys_link+0x1a2>
  }

  ip->nlink++;
80105d4c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105d4f:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105d53:	83 c0 01             	add    $0x1,%eax
80105d56:	89 c2                	mov    %eax,%edx
80105d58:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105d5b:	66 89 50 16          	mov    %dx,0x16(%eax)
  iupdate(ip);
80105d5f:	83 ec 0c             	sub    $0xc,%esp
80105d62:	ff 75 f4             	pushl  -0xc(%ebp)
80105d65:	e8 04 ba ff ff       	call   8010176e <iupdate>
80105d6a:	83 c4 10             	add    $0x10,%esp
  iunlock(ip);
80105d6d:	83 ec 0c             	sub    $0xc,%esp
80105d70:	ff 75 f4             	pushl  -0xc(%ebp)
80105d73:	e8 2e bd ff ff       	call   80101aa6 <iunlock>
80105d78:	83 c4 10             	add    $0x10,%esp

  if((dp = nameiparent(new, name)) == 0)
80105d7b:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105d7e:	83 ec 08             	sub    $0x8,%esp
80105d81:	8d 55 e2             	lea    -0x1e(%ebp),%edx
80105d84:	52                   	push   %edx
80105d85:	50                   	push   %eax
80105d86:	e8 97 c7 ff ff       	call   80102522 <nameiparent>
80105d8b:	83 c4 10             	add    $0x10,%esp
80105d8e:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105d91:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105d95:	74 71                	je     80105e08 <sys_link+0x15a>
    goto bad;
  ilock(dp);
80105d97:	83 ec 0c             	sub    $0xc,%esp
80105d9a:	ff 75 f0             	pushl  -0x10(%ebp)
80105d9d:	e8 a6 bb ff ff       	call   80101948 <ilock>
80105da2:	83 c4 10             	add    $0x10,%esp
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105da5:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105da8:	8b 10                	mov    (%eax),%edx
80105daa:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105dad:	8b 00                	mov    (%eax),%eax
80105daf:	39 c2                	cmp    %eax,%edx
80105db1:	75 1d                	jne    80105dd0 <sys_link+0x122>
80105db3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105db6:	8b 40 04             	mov    0x4(%eax),%eax
80105db9:	83 ec 04             	sub    $0x4,%esp
80105dbc:	50                   	push   %eax
80105dbd:	8d 45 e2             	lea    -0x1e(%ebp),%eax
80105dc0:	50                   	push   %eax
80105dc1:	ff 75 f0             	pushl  -0x10(%ebp)
80105dc4:	e8 a1 c4 ff ff       	call   8010226a <dirlink>
80105dc9:	83 c4 10             	add    $0x10,%esp
80105dcc:	85 c0                	test   %eax,%eax
80105dce:	79 10                	jns    80105de0 <sys_link+0x132>
    iunlockput(dp);
80105dd0:	83 ec 0c             	sub    $0xc,%esp
80105dd3:	ff 75 f0             	pushl  -0x10(%ebp)
80105dd6:	e8 2d be ff ff       	call   80101c08 <iunlockput>
80105ddb:	83 c4 10             	add    $0x10,%esp
    goto bad;
80105dde:	eb 29                	jmp    80105e09 <sys_link+0x15b>
  }
  iunlockput(dp);
80105de0:	83 ec 0c             	sub    $0xc,%esp
80105de3:	ff 75 f0             	pushl  -0x10(%ebp)
80105de6:	e8 1d be ff ff       	call   80101c08 <iunlockput>
80105deb:	83 c4 10             	add    $0x10,%esp
  iput(ip);
80105dee:	83 ec 0c             	sub    $0xc,%esp
80105df1:	ff 75 f4             	pushl  -0xc(%ebp)
80105df4:	e8 1f bd ff ff       	call   80101b18 <iput>
80105df9:	83 c4 10             	add    $0x10,%esp

  end_op();
80105dfc:	e8 a2 d7 ff ff       	call   801035a3 <end_op>

  return 0;
80105e01:	b8 00 00 00 00       	mov    $0x0,%eax
80105e06:	eb 48                	jmp    80105e50 <sys_link+0x1a2>
  ip->nlink++;
  iupdate(ip);
  iunlock(ip);

  if((dp = nameiparent(new, name)) == 0)
    goto bad;
80105e08:	90                   	nop
  end_op();

  return 0;

bad:
  ilock(ip);
80105e09:	83 ec 0c             	sub    $0xc,%esp
80105e0c:	ff 75 f4             	pushl  -0xc(%ebp)
80105e0f:	e8 34 bb ff ff       	call   80101948 <ilock>
80105e14:	83 c4 10             	add    $0x10,%esp
  ip->nlink--;
80105e17:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105e1a:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105e1e:	83 e8 01             	sub    $0x1,%eax
80105e21:	89 c2                	mov    %eax,%edx
80105e23:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105e26:	66 89 50 16          	mov    %dx,0x16(%eax)
  iupdate(ip);
80105e2a:	83 ec 0c             	sub    $0xc,%esp
80105e2d:	ff 75 f4             	pushl  -0xc(%ebp)
80105e30:	e8 39 b9 ff ff       	call   8010176e <iupdate>
80105e35:	83 c4 10             	add    $0x10,%esp
  iunlockput(ip);
80105e38:	83 ec 0c             	sub    $0xc,%esp
80105e3b:	ff 75 f4             	pushl  -0xc(%ebp)
80105e3e:	e8 c5 bd ff ff       	call   80101c08 <iunlockput>
80105e43:	83 c4 10             	add    $0x10,%esp
  end_op();
80105e46:	e8 58 d7 ff ff       	call   801035a3 <end_op>
  return -1;
80105e4b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105e50:	c9                   	leave  
80105e51:	c3                   	ret    

80105e52 <isdirempty>:

// Is the directory dp empty except for "." and ".." ?
static int
isdirempty(struct inode *dp)
{
80105e52:	55                   	push   %ebp
80105e53:	89 e5                	mov    %esp,%ebp
80105e55:	83 ec 28             	sub    $0x28,%esp
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105e58:	c7 45 f4 20 00 00 00 	movl   $0x20,-0xc(%ebp)
80105e5f:	eb 40                	jmp    80105ea1 <isdirempty+0x4f>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105e61:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105e64:	6a 10                	push   $0x10
80105e66:	50                   	push   %eax
80105e67:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105e6a:	50                   	push   %eax
80105e6b:	ff 75 08             	pushl  0x8(%ebp)
80105e6e:	e8 43 c0 ff ff       	call   80101eb6 <readi>
80105e73:	83 c4 10             	add    $0x10,%esp
80105e76:	83 f8 10             	cmp    $0x10,%eax
80105e79:	74 0d                	je     80105e88 <isdirempty+0x36>
      panic("isdirempty: readi");
80105e7b:	83 ec 0c             	sub    $0xc,%esp
80105e7e:	68 85 8d 10 80       	push   $0x80108d85
80105e83:	e8 da a6 ff ff       	call   80100562 <panic>
    if(de.inum != 0)
80105e88:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80105e8c:	66 85 c0             	test   %ax,%ax
80105e8f:	74 07                	je     80105e98 <isdirempty+0x46>
      return 0;
80105e91:	b8 00 00 00 00       	mov    $0x0,%eax
80105e96:	eb 1b                	jmp    80105eb3 <isdirempty+0x61>
isdirempty(struct inode *dp)
{
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105e98:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105e9b:	83 c0 10             	add    $0x10,%eax
80105e9e:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105ea1:	8b 45 08             	mov    0x8(%ebp),%eax
80105ea4:	8b 50 18             	mov    0x18(%eax),%edx
80105ea7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105eaa:	39 c2                	cmp    %eax,%edx
80105eac:	77 b3                	ja     80105e61 <isdirempty+0xf>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("isdirempty: readi");
    if(de.inum != 0)
      return 0;
  }
  return 1;
80105eae:	b8 01 00 00 00       	mov    $0x1,%eax
}
80105eb3:	c9                   	leave  
80105eb4:	c3                   	ret    

80105eb5 <sys_unlink>:

//PAGEBREAK!
int
sys_unlink(void)
{
80105eb5:	55                   	push   %ebp
80105eb6:	89 e5                	mov    %esp,%ebp
80105eb8:	83 ec 38             	sub    $0x38,%esp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
80105ebb:	83 ec 08             	sub    $0x8,%esp
80105ebe:	8d 45 cc             	lea    -0x34(%ebp),%eax
80105ec1:	50                   	push   %eax
80105ec2:	6a 00                	push   $0x0
80105ec4:	e8 a0 fa ff ff       	call   80105969 <argstr>
80105ec9:	83 c4 10             	add    $0x10,%esp
80105ecc:	85 c0                	test   %eax,%eax
80105ece:	79 0a                	jns    80105eda <sys_unlink+0x25>
    return -1;
80105ed0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105ed5:	e9 bc 01 00 00       	jmp    80106096 <sys_unlink+0x1e1>

  begin_op();
80105eda:	e8 36 d6 ff ff       	call   80103515 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105edf:	8b 45 cc             	mov    -0x34(%ebp),%eax
80105ee2:	83 ec 08             	sub    $0x8,%esp
80105ee5:	8d 55 d2             	lea    -0x2e(%ebp),%edx
80105ee8:	52                   	push   %edx
80105ee9:	50                   	push   %eax
80105eea:	e8 33 c6 ff ff       	call   80102522 <nameiparent>
80105eef:	83 c4 10             	add    $0x10,%esp
80105ef2:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105ef5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105ef9:	75 0f                	jne    80105f0a <sys_unlink+0x55>
    end_op();
80105efb:	e8 a3 d6 ff ff       	call   801035a3 <end_op>
    return -1;
80105f00:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105f05:	e9 8c 01 00 00       	jmp    80106096 <sys_unlink+0x1e1>
  }

  ilock(dp);
80105f0a:	83 ec 0c             	sub    $0xc,%esp
80105f0d:	ff 75 f4             	pushl  -0xc(%ebp)
80105f10:	e8 33 ba ff ff       	call   80101948 <ilock>
80105f15:	83 c4 10             	add    $0x10,%esp

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80105f18:	83 ec 08             	sub    $0x8,%esp
80105f1b:	68 97 8d 10 80       	push   $0x80108d97
80105f20:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80105f23:	50                   	push   %eax
80105f24:	e8 6c c2 ff ff       	call   80102195 <namecmp>
80105f29:	83 c4 10             	add    $0x10,%esp
80105f2c:	85 c0                	test   %eax,%eax
80105f2e:	0f 84 4a 01 00 00    	je     8010607e <sys_unlink+0x1c9>
80105f34:	83 ec 08             	sub    $0x8,%esp
80105f37:	68 99 8d 10 80       	push   $0x80108d99
80105f3c:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80105f3f:	50                   	push   %eax
80105f40:	e8 50 c2 ff ff       	call   80102195 <namecmp>
80105f45:	83 c4 10             	add    $0x10,%esp
80105f48:	85 c0                	test   %eax,%eax
80105f4a:	0f 84 2e 01 00 00    	je     8010607e <sys_unlink+0x1c9>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
80105f50:	83 ec 04             	sub    $0x4,%esp
80105f53:	8d 45 c8             	lea    -0x38(%ebp),%eax
80105f56:	50                   	push   %eax
80105f57:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80105f5a:	50                   	push   %eax
80105f5b:	ff 75 f4             	pushl  -0xc(%ebp)
80105f5e:	e8 4d c2 ff ff       	call   801021b0 <dirlookup>
80105f63:	83 c4 10             	add    $0x10,%esp
80105f66:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105f69:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105f6d:	0f 84 0a 01 00 00    	je     8010607d <sys_unlink+0x1c8>
    goto bad;
  ilock(ip);
80105f73:	83 ec 0c             	sub    $0xc,%esp
80105f76:	ff 75 f0             	pushl  -0x10(%ebp)
80105f79:	e8 ca b9 ff ff       	call   80101948 <ilock>
80105f7e:	83 c4 10             	add    $0x10,%esp

  if(ip->nlink < 1)
80105f81:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105f84:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105f88:	66 85 c0             	test   %ax,%ax
80105f8b:	7f 0d                	jg     80105f9a <sys_unlink+0xe5>
    panic("unlink: nlink < 1");
80105f8d:	83 ec 0c             	sub    $0xc,%esp
80105f90:	68 9c 8d 10 80       	push   $0x80108d9c
80105f95:	e8 c8 a5 ff ff       	call   80100562 <panic>
  if(ip->type == T_DIR && !isdirempty(ip)){
80105f9a:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105f9d:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105fa1:	66 83 f8 01          	cmp    $0x1,%ax
80105fa5:	75 25                	jne    80105fcc <sys_unlink+0x117>
80105fa7:	83 ec 0c             	sub    $0xc,%esp
80105faa:	ff 75 f0             	pushl  -0x10(%ebp)
80105fad:	e8 a0 fe ff ff       	call   80105e52 <isdirempty>
80105fb2:	83 c4 10             	add    $0x10,%esp
80105fb5:	85 c0                	test   %eax,%eax
80105fb7:	75 13                	jne    80105fcc <sys_unlink+0x117>
    iunlockput(ip);
80105fb9:	83 ec 0c             	sub    $0xc,%esp
80105fbc:	ff 75 f0             	pushl  -0x10(%ebp)
80105fbf:	e8 44 bc ff ff       	call   80101c08 <iunlockput>
80105fc4:	83 c4 10             	add    $0x10,%esp
    goto bad;
80105fc7:	e9 b2 00 00 00       	jmp    8010607e <sys_unlink+0x1c9>
  }

  memset(&de, 0, sizeof(de));
80105fcc:	83 ec 04             	sub    $0x4,%esp
80105fcf:	6a 10                	push   $0x10
80105fd1:	6a 00                	push   $0x0
80105fd3:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105fd6:	50                   	push   %eax
80105fd7:	e8 e1 f5 ff ff       	call   801055bd <memset>
80105fdc:	83 c4 10             	add    $0x10,%esp
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105fdf:	8b 45 c8             	mov    -0x38(%ebp),%eax
80105fe2:	6a 10                	push   $0x10
80105fe4:	50                   	push   %eax
80105fe5:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105fe8:	50                   	push   %eax
80105fe9:	ff 75 f4             	pushl  -0xc(%ebp)
80105fec:	e8 1c c0 ff ff       	call   8010200d <writei>
80105ff1:	83 c4 10             	add    $0x10,%esp
80105ff4:	83 f8 10             	cmp    $0x10,%eax
80105ff7:	74 0d                	je     80106006 <sys_unlink+0x151>
    panic("unlink: writei");
80105ff9:	83 ec 0c             	sub    $0xc,%esp
80105ffc:	68 ae 8d 10 80       	push   $0x80108dae
80106001:	e8 5c a5 ff ff       	call   80100562 <panic>
  if(ip->type == T_DIR){
80106006:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106009:	0f b7 40 10          	movzwl 0x10(%eax),%eax
8010600d:	66 83 f8 01          	cmp    $0x1,%ax
80106011:	75 21                	jne    80106034 <sys_unlink+0x17f>
    dp->nlink--;
80106013:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106016:	0f b7 40 16          	movzwl 0x16(%eax),%eax
8010601a:	83 e8 01             	sub    $0x1,%eax
8010601d:	89 c2                	mov    %eax,%edx
8010601f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106022:	66 89 50 16          	mov    %dx,0x16(%eax)
    iupdate(dp);
80106026:	83 ec 0c             	sub    $0xc,%esp
80106029:	ff 75 f4             	pushl  -0xc(%ebp)
8010602c:	e8 3d b7 ff ff       	call   8010176e <iupdate>
80106031:	83 c4 10             	add    $0x10,%esp
  }
  iunlockput(dp);
80106034:	83 ec 0c             	sub    $0xc,%esp
80106037:	ff 75 f4             	pushl  -0xc(%ebp)
8010603a:	e8 c9 bb ff ff       	call   80101c08 <iunlockput>
8010603f:	83 c4 10             	add    $0x10,%esp

  ip->nlink--;
80106042:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106045:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80106049:	83 e8 01             	sub    $0x1,%eax
8010604c:	89 c2                	mov    %eax,%edx
8010604e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106051:	66 89 50 16          	mov    %dx,0x16(%eax)
  iupdate(ip);
80106055:	83 ec 0c             	sub    $0xc,%esp
80106058:	ff 75 f0             	pushl  -0x10(%ebp)
8010605b:	e8 0e b7 ff ff       	call   8010176e <iupdate>
80106060:	83 c4 10             	add    $0x10,%esp
  iunlockput(ip);
80106063:	83 ec 0c             	sub    $0xc,%esp
80106066:	ff 75 f0             	pushl  -0x10(%ebp)
80106069:	e8 9a bb ff ff       	call   80101c08 <iunlockput>
8010606e:	83 c4 10             	add    $0x10,%esp

  end_op();
80106071:	e8 2d d5 ff ff       	call   801035a3 <end_op>

  return 0;
80106076:	b8 00 00 00 00       	mov    $0x0,%eax
8010607b:	eb 19                	jmp    80106096 <sys_unlink+0x1e1>
  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
    goto bad;
8010607d:	90                   	nop
  end_op();

  return 0;

bad:
  iunlockput(dp);
8010607e:	83 ec 0c             	sub    $0xc,%esp
80106081:	ff 75 f4             	pushl  -0xc(%ebp)
80106084:	e8 7f bb ff ff       	call   80101c08 <iunlockput>
80106089:	83 c4 10             	add    $0x10,%esp
  end_op();
8010608c:	e8 12 d5 ff ff       	call   801035a3 <end_op>
  return -1;
80106091:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106096:	c9                   	leave  
80106097:	c3                   	ret    

80106098 <create>:

static struct inode*
create(char *path, short type, short major, short minor)
{
80106098:	55                   	push   %ebp
80106099:	89 e5                	mov    %esp,%ebp
8010609b:	83 ec 38             	sub    $0x38,%esp
8010609e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801060a1:	8b 55 10             	mov    0x10(%ebp),%edx
801060a4:	8b 45 14             	mov    0x14(%ebp),%eax
801060a7:	66 89 4d d4          	mov    %cx,-0x2c(%ebp)
801060ab:	66 89 55 d0          	mov    %dx,-0x30(%ebp)
801060af:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
801060b3:	83 ec 08             	sub    $0x8,%esp
801060b6:	8d 45 de             	lea    -0x22(%ebp),%eax
801060b9:	50                   	push   %eax
801060ba:	ff 75 08             	pushl  0x8(%ebp)
801060bd:	e8 60 c4 ff ff       	call   80102522 <nameiparent>
801060c2:	83 c4 10             	add    $0x10,%esp
801060c5:	89 45 f4             	mov    %eax,-0xc(%ebp)
801060c8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801060cc:	75 0a                	jne    801060d8 <create+0x40>
    return 0;
801060ce:	b8 00 00 00 00       	mov    $0x0,%eax
801060d3:	e9 90 01 00 00       	jmp    80106268 <create+0x1d0>
  ilock(dp);
801060d8:	83 ec 0c             	sub    $0xc,%esp
801060db:	ff 75 f4             	pushl  -0xc(%ebp)
801060de:	e8 65 b8 ff ff       	call   80101948 <ilock>
801060e3:	83 c4 10             	add    $0x10,%esp

  if((ip = dirlookup(dp, name, &off)) != 0){
801060e6:	83 ec 04             	sub    $0x4,%esp
801060e9:	8d 45 ec             	lea    -0x14(%ebp),%eax
801060ec:	50                   	push   %eax
801060ed:	8d 45 de             	lea    -0x22(%ebp),%eax
801060f0:	50                   	push   %eax
801060f1:	ff 75 f4             	pushl  -0xc(%ebp)
801060f4:	e8 b7 c0 ff ff       	call   801021b0 <dirlookup>
801060f9:	83 c4 10             	add    $0x10,%esp
801060fc:	89 45 f0             	mov    %eax,-0x10(%ebp)
801060ff:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80106103:	74 50                	je     80106155 <create+0xbd>
    iunlockput(dp);
80106105:	83 ec 0c             	sub    $0xc,%esp
80106108:	ff 75 f4             	pushl  -0xc(%ebp)
8010610b:	e8 f8 ba ff ff       	call   80101c08 <iunlockput>
80106110:	83 c4 10             	add    $0x10,%esp
    ilock(ip);
80106113:	83 ec 0c             	sub    $0xc,%esp
80106116:	ff 75 f0             	pushl  -0x10(%ebp)
80106119:	e8 2a b8 ff ff       	call   80101948 <ilock>
8010611e:	83 c4 10             	add    $0x10,%esp
    if(type == T_FILE && ip->type == T_FILE)
80106121:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80106126:	75 15                	jne    8010613d <create+0xa5>
80106128:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010612b:	0f b7 40 10          	movzwl 0x10(%eax),%eax
8010612f:	66 83 f8 02          	cmp    $0x2,%ax
80106133:	75 08                	jne    8010613d <create+0xa5>
      return ip;
80106135:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106138:	e9 2b 01 00 00       	jmp    80106268 <create+0x1d0>
    iunlockput(ip);
8010613d:	83 ec 0c             	sub    $0xc,%esp
80106140:	ff 75 f0             	pushl  -0x10(%ebp)
80106143:	e8 c0 ba ff ff       	call   80101c08 <iunlockput>
80106148:	83 c4 10             	add    $0x10,%esp
    return 0;
8010614b:	b8 00 00 00 00       	mov    $0x0,%eax
80106150:	e9 13 01 00 00       	jmp    80106268 <create+0x1d0>
  }

  if((ip = ialloc(dp->dev, type)) == 0)
80106155:	0f bf 55 d4          	movswl -0x2c(%ebp),%edx
80106159:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010615c:	8b 00                	mov    (%eax),%eax
8010615e:	83 ec 08             	sub    $0x8,%esp
80106161:	52                   	push   %edx
80106162:	50                   	push   %eax
80106163:	e8 2f b5 ff ff       	call   80101697 <ialloc>
80106168:	83 c4 10             	add    $0x10,%esp
8010616b:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010616e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80106172:	75 0d                	jne    80106181 <create+0xe9>
    panic("create: ialloc");
80106174:	83 ec 0c             	sub    $0xc,%esp
80106177:	68 bd 8d 10 80       	push   $0x80108dbd
8010617c:	e8 e1 a3 ff ff       	call   80100562 <panic>

  ilock(ip);
80106181:	83 ec 0c             	sub    $0xc,%esp
80106184:	ff 75 f0             	pushl  -0x10(%ebp)
80106187:	e8 bc b7 ff ff       	call   80101948 <ilock>
8010618c:	83 c4 10             	add    $0x10,%esp
  ip->major = major;
8010618f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106192:	0f b7 55 d0          	movzwl -0x30(%ebp),%edx
80106196:	66 89 50 12          	mov    %dx,0x12(%eax)
  ip->minor = minor;
8010619a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010619d:	0f b7 55 cc          	movzwl -0x34(%ebp),%edx
801061a1:	66 89 50 14          	mov    %dx,0x14(%eax)
  ip->nlink = 1;
801061a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
801061a8:	66 c7 40 16 01 00    	movw   $0x1,0x16(%eax)
  iupdate(ip);
801061ae:	83 ec 0c             	sub    $0xc,%esp
801061b1:	ff 75 f0             	pushl  -0x10(%ebp)
801061b4:	e8 b5 b5 ff ff       	call   8010176e <iupdate>
801061b9:	83 c4 10             	add    $0x10,%esp

  if(type == T_DIR){  // Create . and .. entries.
801061bc:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
801061c1:	75 6a                	jne    8010622d <create+0x195>
    dp->nlink++;  // for ".."
801061c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801061c6:	0f b7 40 16          	movzwl 0x16(%eax),%eax
801061ca:	83 c0 01             	add    $0x1,%eax
801061cd:	89 c2                	mov    %eax,%edx
801061cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
801061d2:	66 89 50 16          	mov    %dx,0x16(%eax)
    iupdate(dp);
801061d6:	83 ec 0c             	sub    $0xc,%esp
801061d9:	ff 75 f4             	pushl  -0xc(%ebp)
801061dc:	e8 8d b5 ff ff       	call   8010176e <iupdate>
801061e1:	83 c4 10             	add    $0x10,%esp
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
801061e4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801061e7:	8b 40 04             	mov    0x4(%eax),%eax
801061ea:	83 ec 04             	sub    $0x4,%esp
801061ed:	50                   	push   %eax
801061ee:	68 97 8d 10 80       	push   $0x80108d97
801061f3:	ff 75 f0             	pushl  -0x10(%ebp)
801061f6:	e8 6f c0 ff ff       	call   8010226a <dirlink>
801061fb:	83 c4 10             	add    $0x10,%esp
801061fe:	85 c0                	test   %eax,%eax
80106200:	78 1e                	js     80106220 <create+0x188>
80106202:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106205:	8b 40 04             	mov    0x4(%eax),%eax
80106208:	83 ec 04             	sub    $0x4,%esp
8010620b:	50                   	push   %eax
8010620c:	68 99 8d 10 80       	push   $0x80108d99
80106211:	ff 75 f0             	pushl  -0x10(%ebp)
80106214:	e8 51 c0 ff ff       	call   8010226a <dirlink>
80106219:	83 c4 10             	add    $0x10,%esp
8010621c:	85 c0                	test   %eax,%eax
8010621e:	79 0d                	jns    8010622d <create+0x195>
      panic("create dots");
80106220:	83 ec 0c             	sub    $0xc,%esp
80106223:	68 cc 8d 10 80       	push   $0x80108dcc
80106228:	e8 35 a3 ff ff       	call   80100562 <panic>
  }

  if(dirlink(dp, name, ip->inum) < 0)
8010622d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106230:	8b 40 04             	mov    0x4(%eax),%eax
80106233:	83 ec 04             	sub    $0x4,%esp
80106236:	50                   	push   %eax
80106237:	8d 45 de             	lea    -0x22(%ebp),%eax
8010623a:	50                   	push   %eax
8010623b:	ff 75 f4             	pushl  -0xc(%ebp)
8010623e:	e8 27 c0 ff ff       	call   8010226a <dirlink>
80106243:	83 c4 10             	add    $0x10,%esp
80106246:	85 c0                	test   %eax,%eax
80106248:	79 0d                	jns    80106257 <create+0x1bf>
    panic("create: dirlink");
8010624a:	83 ec 0c             	sub    $0xc,%esp
8010624d:	68 d8 8d 10 80       	push   $0x80108dd8
80106252:	e8 0b a3 ff ff       	call   80100562 <panic>

  iunlockput(dp);
80106257:	83 ec 0c             	sub    $0xc,%esp
8010625a:	ff 75 f4             	pushl  -0xc(%ebp)
8010625d:	e8 a6 b9 ff ff       	call   80101c08 <iunlockput>
80106262:	83 c4 10             	add    $0x10,%esp

  return ip;
80106265:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80106268:	c9                   	leave  
80106269:	c3                   	ret    

8010626a <sys_open>:

int
sys_open(void)
{
8010626a:	55                   	push   %ebp
8010626b:	89 e5                	mov    %esp,%ebp
8010626d:	83 ec 28             	sub    $0x28,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80106270:	83 ec 08             	sub    $0x8,%esp
80106273:	8d 45 e8             	lea    -0x18(%ebp),%eax
80106276:	50                   	push   %eax
80106277:	6a 00                	push   $0x0
80106279:	e8 eb f6 ff ff       	call   80105969 <argstr>
8010627e:	83 c4 10             	add    $0x10,%esp
80106281:	85 c0                	test   %eax,%eax
80106283:	78 15                	js     8010629a <sys_open+0x30>
80106285:	83 ec 08             	sub    $0x8,%esp
80106288:	8d 45 e4             	lea    -0x1c(%ebp),%eax
8010628b:	50                   	push   %eax
8010628c:	6a 01                	push   $0x1
8010628e:	e8 51 f6 ff ff       	call   801058e4 <argint>
80106293:	83 c4 10             	add    $0x10,%esp
80106296:	85 c0                	test   %eax,%eax
80106298:	79 0a                	jns    801062a4 <sys_open+0x3a>
    return -1;
8010629a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010629f:	e9 61 01 00 00       	jmp    80106405 <sys_open+0x19b>

  begin_op();
801062a4:	e8 6c d2 ff ff       	call   80103515 <begin_op>

  if(omode & O_CREATE){
801062a9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801062ac:	25 00 02 00 00       	and    $0x200,%eax
801062b1:	85 c0                	test   %eax,%eax
801062b3:	74 2a                	je     801062df <sys_open+0x75>
    ip = create(path, T_FILE, 0, 0);
801062b5:	8b 45 e8             	mov    -0x18(%ebp),%eax
801062b8:	6a 00                	push   $0x0
801062ba:	6a 00                	push   $0x0
801062bc:	6a 02                	push   $0x2
801062be:	50                   	push   %eax
801062bf:	e8 d4 fd ff ff       	call   80106098 <create>
801062c4:	83 c4 10             	add    $0x10,%esp
801062c7:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(ip == 0){
801062ca:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801062ce:	75 75                	jne    80106345 <sys_open+0xdb>
      end_op();
801062d0:	e8 ce d2 ff ff       	call   801035a3 <end_op>
      return -1;
801062d5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801062da:	e9 26 01 00 00       	jmp    80106405 <sys_open+0x19b>
    }
  } else {
    if((ip = namei(path)) == 0){
801062df:	8b 45 e8             	mov    -0x18(%ebp),%eax
801062e2:	83 ec 0c             	sub    $0xc,%esp
801062e5:	50                   	push   %eax
801062e6:	e8 1b c2 ff ff       	call   80102506 <namei>
801062eb:	83 c4 10             	add    $0x10,%esp
801062ee:	89 45 f4             	mov    %eax,-0xc(%ebp)
801062f1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801062f5:	75 0f                	jne    80106306 <sys_open+0x9c>
      end_op();
801062f7:	e8 a7 d2 ff ff       	call   801035a3 <end_op>
      return -1;
801062fc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106301:	e9 ff 00 00 00       	jmp    80106405 <sys_open+0x19b>
    }
    ilock(ip);
80106306:	83 ec 0c             	sub    $0xc,%esp
80106309:	ff 75 f4             	pushl  -0xc(%ebp)
8010630c:	e8 37 b6 ff ff       	call   80101948 <ilock>
80106311:	83 c4 10             	add    $0x10,%esp
    if(ip->type == T_DIR && omode != O_RDONLY){
80106314:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106317:	0f b7 40 10          	movzwl 0x10(%eax),%eax
8010631b:	66 83 f8 01          	cmp    $0x1,%ax
8010631f:	75 24                	jne    80106345 <sys_open+0xdb>
80106321:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106324:	85 c0                	test   %eax,%eax
80106326:	74 1d                	je     80106345 <sys_open+0xdb>
      iunlockput(ip);
80106328:	83 ec 0c             	sub    $0xc,%esp
8010632b:	ff 75 f4             	pushl  -0xc(%ebp)
8010632e:	e8 d5 b8 ff ff       	call   80101c08 <iunlockput>
80106333:	83 c4 10             	add    $0x10,%esp
      end_op();
80106336:	e8 68 d2 ff ff       	call   801035a3 <end_op>
      return -1;
8010633b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106340:	e9 c0 00 00 00       	jmp    80106405 <sys_open+0x19b>
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80106345:	e8 29 ac ff ff       	call   80100f73 <filealloc>
8010634a:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010634d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80106351:	74 17                	je     8010636a <sys_open+0x100>
80106353:	83 ec 0c             	sub    $0xc,%esp
80106356:	ff 75 f0             	pushl  -0x10(%ebp)
80106359:	e8 37 f7 ff ff       	call   80105a95 <fdalloc>
8010635e:	83 c4 10             	add    $0x10,%esp
80106361:	89 45 ec             	mov    %eax,-0x14(%ebp)
80106364:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80106368:	79 2e                	jns    80106398 <sys_open+0x12e>
    if(f)
8010636a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010636e:	74 0e                	je     8010637e <sys_open+0x114>
      fileclose(f);
80106370:	83 ec 0c             	sub    $0xc,%esp
80106373:	ff 75 f0             	pushl  -0x10(%ebp)
80106376:	e8 b5 ac ff ff       	call   80101030 <fileclose>
8010637b:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
8010637e:	83 ec 0c             	sub    $0xc,%esp
80106381:	ff 75 f4             	pushl  -0xc(%ebp)
80106384:	e8 7f b8 ff ff       	call   80101c08 <iunlockput>
80106389:	83 c4 10             	add    $0x10,%esp
    end_op();
8010638c:	e8 12 d2 ff ff       	call   801035a3 <end_op>
    return -1;
80106391:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106396:	eb 6d                	jmp    80106405 <sys_open+0x19b>
  }
  iunlock(ip);
80106398:	83 ec 0c             	sub    $0xc,%esp
8010639b:	ff 75 f4             	pushl  -0xc(%ebp)
8010639e:	e8 03 b7 ff ff       	call   80101aa6 <iunlock>
801063a3:	83 c4 10             	add    $0x10,%esp
  end_op();
801063a6:	e8 f8 d1 ff ff       	call   801035a3 <end_op>

  f->type = FD_INODE;
801063ab:	8b 45 f0             	mov    -0x10(%ebp),%eax
801063ae:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
  f->ip = ip;
801063b4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801063b7:	8b 55 f4             	mov    -0xc(%ebp),%edx
801063ba:	89 50 10             	mov    %edx,0x10(%eax)
  f->off = 0;
801063bd:	8b 45 f0             	mov    -0x10(%ebp),%eax
801063c0:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  f->readable = !(omode & O_WRONLY);
801063c7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801063ca:	83 e0 01             	and    $0x1,%eax
801063cd:	85 c0                	test   %eax,%eax
801063cf:	0f 94 c0             	sete   %al
801063d2:	89 c2                	mov    %eax,%edx
801063d4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801063d7:	88 50 08             	mov    %dl,0x8(%eax)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801063da:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801063dd:	83 e0 01             	and    $0x1,%eax
801063e0:	85 c0                	test   %eax,%eax
801063e2:	75 0a                	jne    801063ee <sys_open+0x184>
801063e4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801063e7:	83 e0 02             	and    $0x2,%eax
801063ea:	85 c0                	test   %eax,%eax
801063ec:	74 07                	je     801063f5 <sys_open+0x18b>
801063ee:	b8 01 00 00 00       	mov    $0x1,%eax
801063f3:	eb 05                	jmp    801063fa <sys_open+0x190>
801063f5:	b8 00 00 00 00       	mov    $0x0,%eax
801063fa:	89 c2                	mov    %eax,%edx
801063fc:	8b 45 f0             	mov    -0x10(%ebp),%eax
801063ff:	88 50 09             	mov    %dl,0x9(%eax)
  return fd;
80106402:	8b 45 ec             	mov    -0x14(%ebp),%eax
}
80106405:	c9                   	leave  
80106406:	c3                   	ret    

80106407 <sys_mkdir>:

int
sys_mkdir(void)
{
80106407:	55                   	push   %ebp
80106408:	89 e5                	mov    %esp,%ebp
8010640a:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
8010640d:	e8 03 d1 ff ff       	call   80103515 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
80106412:	83 ec 08             	sub    $0x8,%esp
80106415:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106418:	50                   	push   %eax
80106419:	6a 00                	push   $0x0
8010641b:	e8 49 f5 ff ff       	call   80105969 <argstr>
80106420:	83 c4 10             	add    $0x10,%esp
80106423:	85 c0                	test   %eax,%eax
80106425:	78 1b                	js     80106442 <sys_mkdir+0x3b>
80106427:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010642a:	6a 00                	push   $0x0
8010642c:	6a 00                	push   $0x0
8010642e:	6a 01                	push   $0x1
80106430:	50                   	push   %eax
80106431:	e8 62 fc ff ff       	call   80106098 <create>
80106436:	83 c4 10             	add    $0x10,%esp
80106439:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010643c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106440:	75 0c                	jne    8010644e <sys_mkdir+0x47>
    end_op();
80106442:	e8 5c d1 ff ff       	call   801035a3 <end_op>
    return -1;
80106447:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010644c:	eb 18                	jmp    80106466 <sys_mkdir+0x5f>
  }
  iunlockput(ip);
8010644e:	83 ec 0c             	sub    $0xc,%esp
80106451:	ff 75 f4             	pushl  -0xc(%ebp)
80106454:	e8 af b7 ff ff       	call   80101c08 <iunlockput>
80106459:	83 c4 10             	add    $0x10,%esp
  end_op();
8010645c:	e8 42 d1 ff ff       	call   801035a3 <end_op>
  return 0;
80106461:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106466:	c9                   	leave  
80106467:	c3                   	ret    

80106468 <sys_mknod>:

int
sys_mknod(void)
{
80106468:	55                   	push   %ebp
80106469:	89 e5                	mov    %esp,%ebp
8010646b:	83 ec 28             	sub    $0x28,%esp
  struct inode *ip;
  char *path;
  int len;
  int major, minor;
  
  begin_op();
8010646e:	e8 a2 d0 ff ff       	call   80103515 <begin_op>
  if((len=argstr(0, &path)) < 0 ||
80106473:	83 ec 08             	sub    $0x8,%esp
80106476:	8d 45 ec             	lea    -0x14(%ebp),%eax
80106479:	50                   	push   %eax
8010647a:	6a 00                	push   $0x0
8010647c:	e8 e8 f4 ff ff       	call   80105969 <argstr>
80106481:	83 c4 10             	add    $0x10,%esp
80106484:	89 45 f4             	mov    %eax,-0xc(%ebp)
80106487:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010648b:	78 4f                	js     801064dc <sys_mknod+0x74>
     argint(1, &major) < 0 ||
8010648d:	83 ec 08             	sub    $0x8,%esp
80106490:	8d 45 e8             	lea    -0x18(%ebp),%eax
80106493:	50                   	push   %eax
80106494:	6a 01                	push   $0x1
80106496:	e8 49 f4 ff ff       	call   801058e4 <argint>
8010649b:	83 c4 10             	add    $0x10,%esp
  char *path;
  int len;
  int major, minor;
  
  begin_op();
  if((len=argstr(0, &path)) < 0 ||
8010649e:	85 c0                	test   %eax,%eax
801064a0:	78 3a                	js     801064dc <sys_mknod+0x74>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
801064a2:	83 ec 08             	sub    $0x8,%esp
801064a5:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801064a8:	50                   	push   %eax
801064a9:	6a 02                	push   $0x2
801064ab:	e8 34 f4 ff ff       	call   801058e4 <argint>
801064b0:	83 c4 10             	add    $0x10,%esp
  int len;
  int major, minor;
  
  begin_op();
  if((len=argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
801064b3:	85 c0                	test   %eax,%eax
801064b5:	78 25                	js     801064dc <sys_mknod+0x74>
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0){
801064b7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801064ba:	0f bf c8             	movswl %ax,%ecx
801064bd:	8b 45 e8             	mov    -0x18(%ebp),%eax
801064c0:	0f bf d0             	movswl %ax,%edx
801064c3:	8b 45 ec             	mov    -0x14(%ebp),%eax
  int major, minor;
  
  begin_op();
  if((len=argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
801064c6:	51                   	push   %ecx
801064c7:	52                   	push   %edx
801064c8:	6a 03                	push   $0x3
801064ca:	50                   	push   %eax
801064cb:	e8 c8 fb ff ff       	call   80106098 <create>
801064d0:	83 c4 10             	add    $0x10,%esp
801064d3:	89 45 f0             	mov    %eax,-0x10(%ebp)
801064d6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801064da:	75 0c                	jne    801064e8 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
801064dc:	e8 c2 d0 ff ff       	call   801035a3 <end_op>
    return -1;
801064e1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801064e6:	eb 18                	jmp    80106500 <sys_mknod+0x98>
  }
  iunlockput(ip);
801064e8:	83 ec 0c             	sub    $0xc,%esp
801064eb:	ff 75 f0             	pushl  -0x10(%ebp)
801064ee:	e8 15 b7 ff ff       	call   80101c08 <iunlockput>
801064f3:	83 c4 10             	add    $0x10,%esp
  end_op();
801064f6:	e8 a8 d0 ff ff       	call   801035a3 <end_op>
  return 0;
801064fb:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106500:	c9                   	leave  
80106501:	c3                   	ret    

80106502 <sys_chdir>:

int
sys_chdir(void)
{
80106502:	55                   	push   %ebp
80106503:	89 e5                	mov    %esp,%ebp
80106505:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80106508:	e8 08 d0 ff ff       	call   80103515 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
8010650d:	83 ec 08             	sub    $0x8,%esp
80106510:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106513:	50                   	push   %eax
80106514:	6a 00                	push   $0x0
80106516:	e8 4e f4 ff ff       	call   80105969 <argstr>
8010651b:	83 c4 10             	add    $0x10,%esp
8010651e:	85 c0                	test   %eax,%eax
80106520:	78 18                	js     8010653a <sys_chdir+0x38>
80106522:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106525:	83 ec 0c             	sub    $0xc,%esp
80106528:	50                   	push   %eax
80106529:	e8 d8 bf ff ff       	call   80102506 <namei>
8010652e:	83 c4 10             	add    $0x10,%esp
80106531:	89 45 f4             	mov    %eax,-0xc(%ebp)
80106534:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106538:	75 0c                	jne    80106546 <sys_chdir+0x44>
    end_op();
8010653a:	e8 64 d0 ff ff       	call   801035a3 <end_op>
    return -1;
8010653f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106544:	eb 6e                	jmp    801065b4 <sys_chdir+0xb2>
  }
  ilock(ip);
80106546:	83 ec 0c             	sub    $0xc,%esp
80106549:	ff 75 f4             	pushl  -0xc(%ebp)
8010654c:	e8 f7 b3 ff ff       	call   80101948 <ilock>
80106551:	83 c4 10             	add    $0x10,%esp
  if(ip->type != T_DIR){
80106554:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106557:	0f b7 40 10          	movzwl 0x10(%eax),%eax
8010655b:	66 83 f8 01          	cmp    $0x1,%ax
8010655f:	74 1a                	je     8010657b <sys_chdir+0x79>
    iunlockput(ip);
80106561:	83 ec 0c             	sub    $0xc,%esp
80106564:	ff 75 f4             	pushl  -0xc(%ebp)
80106567:	e8 9c b6 ff ff       	call   80101c08 <iunlockput>
8010656c:	83 c4 10             	add    $0x10,%esp
    end_op();
8010656f:	e8 2f d0 ff ff       	call   801035a3 <end_op>
    return -1;
80106574:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106579:	eb 39                	jmp    801065b4 <sys_chdir+0xb2>
  }
  iunlock(ip);
8010657b:	83 ec 0c             	sub    $0xc,%esp
8010657e:	ff 75 f4             	pushl  -0xc(%ebp)
80106581:	e8 20 b5 ff ff       	call   80101aa6 <iunlock>
80106586:	83 c4 10             	add    $0x10,%esp
  iput(proc->cwd);
80106589:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010658f:	8b 40 68             	mov    0x68(%eax),%eax
80106592:	83 ec 0c             	sub    $0xc,%esp
80106595:	50                   	push   %eax
80106596:	e8 7d b5 ff ff       	call   80101b18 <iput>
8010659b:	83 c4 10             	add    $0x10,%esp
  end_op();
8010659e:	e8 00 d0 ff ff       	call   801035a3 <end_op>
  proc->cwd = ip;
801065a3:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801065a9:	8b 55 f4             	mov    -0xc(%ebp),%edx
801065ac:	89 50 68             	mov    %edx,0x68(%eax)
  return 0;
801065af:	b8 00 00 00 00       	mov    $0x0,%eax
}
801065b4:	c9                   	leave  
801065b5:	c3                   	ret    

801065b6 <sys_exec>:

int
sys_exec(void)
{
801065b6:	55                   	push   %ebp
801065b7:	89 e5                	mov    %esp,%ebp
801065b9:	81 ec 98 00 00 00    	sub    $0x98,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801065bf:	83 ec 08             	sub    $0x8,%esp
801065c2:	8d 45 f0             	lea    -0x10(%ebp),%eax
801065c5:	50                   	push   %eax
801065c6:	6a 00                	push   $0x0
801065c8:	e8 9c f3 ff ff       	call   80105969 <argstr>
801065cd:	83 c4 10             	add    $0x10,%esp
801065d0:	85 c0                	test   %eax,%eax
801065d2:	78 18                	js     801065ec <sys_exec+0x36>
801065d4:	83 ec 08             	sub    $0x8,%esp
801065d7:	8d 85 6c ff ff ff    	lea    -0x94(%ebp),%eax
801065dd:	50                   	push   %eax
801065de:	6a 01                	push   $0x1
801065e0:	e8 ff f2 ff ff       	call   801058e4 <argint>
801065e5:	83 c4 10             	add    $0x10,%esp
801065e8:	85 c0                	test   %eax,%eax
801065ea:	79 0a                	jns    801065f6 <sys_exec+0x40>
    return -1;
801065ec:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801065f1:	e9 c6 00 00 00       	jmp    801066bc <sys_exec+0x106>
  }
  memset(argv, 0, sizeof(argv));
801065f6:	83 ec 04             	sub    $0x4,%esp
801065f9:	68 80 00 00 00       	push   $0x80
801065fe:	6a 00                	push   $0x0
80106600:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
80106606:	50                   	push   %eax
80106607:	e8 b1 ef ff ff       	call   801055bd <memset>
8010660c:	83 c4 10             	add    $0x10,%esp
  for(i=0;; i++){
8010660f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(i >= NELEM(argv))
80106616:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106619:	83 f8 1f             	cmp    $0x1f,%eax
8010661c:	76 0a                	jbe    80106628 <sys_exec+0x72>
      return -1;
8010661e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106623:	e9 94 00 00 00       	jmp    801066bc <sys_exec+0x106>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80106628:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010662b:	c1 e0 02             	shl    $0x2,%eax
8010662e:	89 c2                	mov    %eax,%edx
80106630:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
80106636:	01 c2                	add    %eax,%edx
80106638:	83 ec 08             	sub    $0x8,%esp
8010663b:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80106641:	50                   	push   %eax
80106642:	52                   	push   %edx
80106643:	e8 00 f2 ff ff       	call   80105848 <fetchint>
80106648:	83 c4 10             	add    $0x10,%esp
8010664b:	85 c0                	test   %eax,%eax
8010664d:	79 07                	jns    80106656 <sys_exec+0xa0>
      return -1;
8010664f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106654:	eb 66                	jmp    801066bc <sys_exec+0x106>
    if(uarg == 0){
80106656:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
8010665c:	85 c0                	test   %eax,%eax
8010665e:	75 27                	jne    80106687 <sys_exec+0xd1>
      argv[i] = 0;
80106660:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106663:	c7 84 85 70 ff ff ff 	movl   $0x0,-0x90(%ebp,%eax,4)
8010666a:	00 00 00 00 
      break;
8010666e:	90                   	nop
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
8010666f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106672:	83 ec 08             	sub    $0x8,%esp
80106675:	8d 95 70 ff ff ff    	lea    -0x90(%ebp),%edx
8010667b:	52                   	push   %edx
8010667c:	50                   	push   %eax
8010667d:	e8 d0 a4 ff ff       	call   80100b52 <exec>
80106682:	83 c4 10             	add    $0x10,%esp
80106685:	eb 35                	jmp    801066bc <sys_exec+0x106>
      return -1;
    if(uarg == 0){
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80106687:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
8010668d:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106690:	c1 e2 02             	shl    $0x2,%edx
80106693:	01 c2                	add    %eax,%edx
80106695:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
8010669b:	83 ec 08             	sub    $0x8,%esp
8010669e:	52                   	push   %edx
8010669f:	50                   	push   %eax
801066a0:	e8 dd f1 ff ff       	call   80105882 <fetchstr>
801066a5:	83 c4 10             	add    $0x10,%esp
801066a8:	85 c0                	test   %eax,%eax
801066aa:	79 07                	jns    801066b3 <sys_exec+0xfd>
      return -1;
801066ac:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801066b1:	eb 09                	jmp    801066bc <sys_exec+0x106>

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
801066b3:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
801066b7:	e9 5a ff ff ff       	jmp    80106616 <sys_exec+0x60>
  return exec(path, argv);
}
801066bc:	c9                   	leave  
801066bd:	c3                   	ret    

801066be <sys_pipe>:

int
sys_pipe(void)
{
801066be:	55                   	push   %ebp
801066bf:	89 e5                	mov    %esp,%ebp
801066c1:	83 ec 28             	sub    $0x28,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801066c4:	83 ec 04             	sub    $0x4,%esp
801066c7:	6a 08                	push   $0x8
801066c9:	8d 45 ec             	lea    -0x14(%ebp),%eax
801066cc:	50                   	push   %eax
801066cd:	6a 00                	push   $0x0
801066cf:	e8 38 f2 ff ff       	call   8010590c <argptr>
801066d4:	83 c4 10             	add    $0x10,%esp
801066d7:	85 c0                	test   %eax,%eax
801066d9:	79 0a                	jns    801066e5 <sys_pipe+0x27>
    return -1;
801066db:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801066e0:	e9 af 00 00 00       	jmp    80106794 <sys_pipe+0xd6>
  if(pipealloc(&rf, &wf) < 0)
801066e5:	83 ec 08             	sub    $0x8,%esp
801066e8:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801066eb:	50                   	push   %eax
801066ec:	8d 45 e8             	lea    -0x18(%ebp),%eax
801066ef:	50                   	push   %eax
801066f0:	e8 0d d9 ff ff       	call   80104002 <pipealloc>
801066f5:	83 c4 10             	add    $0x10,%esp
801066f8:	85 c0                	test   %eax,%eax
801066fa:	79 0a                	jns    80106706 <sys_pipe+0x48>
    return -1;
801066fc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106701:	e9 8e 00 00 00       	jmp    80106794 <sys_pipe+0xd6>
  fd0 = -1;
80106706:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
8010670d:	8b 45 e8             	mov    -0x18(%ebp),%eax
80106710:	83 ec 0c             	sub    $0xc,%esp
80106713:	50                   	push   %eax
80106714:	e8 7c f3 ff ff       	call   80105a95 <fdalloc>
80106719:	83 c4 10             	add    $0x10,%esp
8010671c:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010671f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106723:	78 18                	js     8010673d <sys_pipe+0x7f>
80106725:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106728:	83 ec 0c             	sub    $0xc,%esp
8010672b:	50                   	push   %eax
8010672c:	e8 64 f3 ff ff       	call   80105a95 <fdalloc>
80106731:	83 c4 10             	add    $0x10,%esp
80106734:	89 45 f0             	mov    %eax,-0x10(%ebp)
80106737:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010673b:	79 3f                	jns    8010677c <sys_pipe+0xbe>
    if(fd0 >= 0)
8010673d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106741:	78 14                	js     80106757 <sys_pipe+0x99>
      proc->ofile[fd0] = 0;
80106743:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106749:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010674c:	83 c2 08             	add    $0x8,%edx
8010674f:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
80106756:	00 
    fileclose(rf);
80106757:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010675a:	83 ec 0c             	sub    $0xc,%esp
8010675d:	50                   	push   %eax
8010675e:	e8 cd a8 ff ff       	call   80101030 <fileclose>
80106763:	83 c4 10             	add    $0x10,%esp
    fileclose(wf);
80106766:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106769:	83 ec 0c             	sub    $0xc,%esp
8010676c:	50                   	push   %eax
8010676d:	e8 be a8 ff ff       	call   80101030 <fileclose>
80106772:	83 c4 10             	add    $0x10,%esp
    return -1;
80106775:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010677a:	eb 18                	jmp    80106794 <sys_pipe+0xd6>
  }
  fd[0] = fd0;
8010677c:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010677f:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106782:	89 10                	mov    %edx,(%eax)
  fd[1] = fd1;
80106784:	8b 45 ec             	mov    -0x14(%ebp),%eax
80106787:	8d 50 04             	lea    0x4(%eax),%edx
8010678a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010678d:	89 02                	mov    %eax,(%edx)
  return 0;
8010678f:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106794:	c9                   	leave  
80106795:	c3                   	ret    

80106796 <sys_fork>:
#include "proc.h"


int
sys_fork(void)
{
80106796:	55                   	push   %ebp
80106797:	89 e5                	mov    %esp,%ebp
80106799:	83 ec 08             	sub    $0x8,%esp
  return fork();
8010679c:	e8 25 e2 ff ff       	call   801049c6 <fork>
}
801067a1:	c9                   	leave  
801067a2:	c3                   	ret    

801067a3 <sys_exit>:

int
sys_exit(void)
{
801067a3:	55                   	push   %ebp
801067a4:	89 e5                	mov    %esp,%ebp
801067a6:	83 ec 08             	sub    $0x8,%esp
  exit();
801067a9:	e8 d8 e3 ff ff       	call   80104b86 <exit>
  return 0;  // not reached
801067ae:	b8 00 00 00 00       	mov    $0x0,%eax
}
801067b3:	c9                   	leave  
801067b4:	c3                   	ret    

801067b5 <sys_wait>:

int
sys_wait(void)
{
801067b5:	55                   	push   %ebp
801067b6:	89 e5                	mov    %esp,%ebp
801067b8:	83 ec 08             	sub    $0x8,%esp
  return wait();
801067bb:	e8 34 e5 ff ff       	call   80104cf4 <wait>
}
801067c0:	c9                   	leave  
801067c1:	c3                   	ret    

801067c2 <sys_kill>:

int
sys_kill(void)
{
801067c2:	55                   	push   %ebp
801067c3:	89 e5                	mov    %esp,%ebp
801067c5:	83 ec 18             	sub    $0x18,%esp
  int pid;

  if(argint(0, &pid) < 0)
801067c8:	83 ec 08             	sub    $0x8,%esp
801067cb:	8d 45 f4             	lea    -0xc(%ebp),%eax
801067ce:	50                   	push   %eax
801067cf:	6a 00                	push   $0x0
801067d1:	e8 0e f1 ff ff       	call   801058e4 <argint>
801067d6:	83 c4 10             	add    $0x10,%esp
801067d9:	85 c0                	test   %eax,%eax
801067db:	79 07                	jns    801067e4 <sys_kill+0x22>
    return -1;
801067dd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801067e2:	eb 0f                	jmp    801067f3 <sys_kill+0x31>
  return kill(pid);
801067e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801067e7:	83 ec 0c             	sub    $0xc,%esp
801067ea:	50                   	push   %eax
801067eb:	e8 60 e9 ff ff       	call   80105150 <kill>
801067f0:	83 c4 10             	add    $0x10,%esp
}
801067f3:	c9                   	leave  
801067f4:	c3                   	ret    

801067f5 <sys_getpid>:

int
sys_getpid(void)
{
801067f5:	55                   	push   %ebp
801067f6:	89 e5                	mov    %esp,%ebp
  return proc->pid;
801067f8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801067fe:	8b 40 10             	mov    0x10(%eax),%eax
}
80106801:	5d                   	pop    %ebp
80106802:	c3                   	ret    

80106803 <sys_sbrk>:

int
sys_sbrk(void)
{
80106803:	55                   	push   %ebp
80106804:	89 e5                	mov    %esp,%ebp
80106806:	83 ec 18             	sub    $0x18,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
80106809:	83 ec 08             	sub    $0x8,%esp
8010680c:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010680f:	50                   	push   %eax
80106810:	6a 00                	push   $0x0
80106812:	e8 cd f0 ff ff       	call   801058e4 <argint>
80106817:	83 c4 10             	add    $0x10,%esp
8010681a:	85 c0                	test   %eax,%eax
8010681c:	79 07                	jns    80106825 <sys_sbrk+0x22>
    return -1;
8010681e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106823:	eb 28                	jmp    8010684d <sys_sbrk+0x4a>
  addr = proc->sz;
80106825:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010682b:	8b 00                	mov    (%eax),%eax
8010682d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(growproc(n) < 0)
80106830:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106833:	83 ec 0c             	sub    $0xc,%esp
80106836:	50                   	push   %eax
80106837:	e8 e7 e0 ff ff       	call   80104923 <growproc>
8010683c:	83 c4 10             	add    $0x10,%esp
8010683f:	85 c0                	test   %eax,%eax
80106841:	79 07                	jns    8010684a <sys_sbrk+0x47>
    return -1;
80106843:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106848:	eb 03                	jmp    8010684d <sys_sbrk+0x4a>
  return addr;
8010684a:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
8010684d:	c9                   	leave  
8010684e:	c3                   	ret    

8010684f <sys_sleep>:

int
sys_sleep(void)
{
8010684f:	55                   	push   %ebp
80106850:	89 e5                	mov    %esp,%ebp
80106852:	83 ec 18             	sub    $0x18,%esp
  int n;
  uint ticks0;
  
  if(argint(0, &n) < 0)
80106855:	83 ec 08             	sub    $0x8,%esp
80106858:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010685b:	50                   	push   %eax
8010685c:	6a 00                	push   $0x0
8010685e:	e8 81 f0 ff ff       	call   801058e4 <argint>
80106863:	83 c4 10             	add    $0x10,%esp
80106866:	85 c0                	test   %eax,%eax
80106868:	79 07                	jns    80106871 <sys_sleep+0x22>
    return -1;
8010686a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010686f:	eb 77                	jmp    801068e8 <sys_sleep+0x99>
  acquire(&tickslock);
80106871:	83 ec 0c             	sub    $0xc,%esp
80106874:	68 40 5f 11 80       	push   $0x80115f40
80106879:	e8 de ea ff ff       	call   8010535c <acquire>
8010687e:	83 c4 10             	add    $0x10,%esp
  ticks0 = ticks;
80106881:	a1 80 67 11 80       	mov    0x80116780,%eax
80106886:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(ticks - ticks0 < n){
80106889:	eb 39                	jmp    801068c4 <sys_sleep+0x75>
    if(proc->killed){
8010688b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106891:	8b 40 24             	mov    0x24(%eax),%eax
80106894:	85 c0                	test   %eax,%eax
80106896:	74 17                	je     801068af <sys_sleep+0x60>
      release(&tickslock);
80106898:	83 ec 0c             	sub    $0xc,%esp
8010689b:	68 40 5f 11 80       	push   $0x80115f40
801068a0:	e8 1e eb ff ff       	call   801053c3 <release>
801068a5:	83 c4 10             	add    $0x10,%esp
      return -1;
801068a8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801068ad:	eb 39                	jmp    801068e8 <sys_sleep+0x99>
    }
    sleep(&ticks, &tickslock);
801068af:	83 ec 08             	sub    $0x8,%esp
801068b2:	68 40 5f 11 80       	push   $0x80115f40
801068b7:	68 80 67 11 80       	push   $0x80116780
801068bc:	e8 5c e7 ff ff       	call   8010501d <sleep>
801068c1:	83 c4 10             	add    $0x10,%esp
  
  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
801068c4:	a1 80 67 11 80       	mov    0x80116780,%eax
801068c9:	2b 45 f4             	sub    -0xc(%ebp),%eax
801068cc:	8b 55 f0             	mov    -0x10(%ebp),%edx
801068cf:	39 d0                	cmp    %edx,%eax
801068d1:	72 b8                	jb     8010688b <sys_sleep+0x3c>
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
801068d3:	83 ec 0c             	sub    $0xc,%esp
801068d6:	68 40 5f 11 80       	push   $0x80115f40
801068db:	e8 e3 ea ff ff       	call   801053c3 <release>
801068e0:	83 c4 10             	add    $0x10,%esp
  return 0;
801068e3:	b8 00 00 00 00       	mov    $0x0,%eax
}
801068e8:	c9                   	leave  
801068e9:	c3                   	ret    

801068ea <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
801068ea:	55                   	push   %ebp
801068eb:	89 e5                	mov    %esp,%ebp
801068ed:	83 ec 18             	sub    $0x18,%esp
  uint xticks;
  
  acquire(&tickslock);
801068f0:	83 ec 0c             	sub    $0xc,%esp
801068f3:	68 40 5f 11 80       	push   $0x80115f40
801068f8:	e8 5f ea ff ff       	call   8010535c <acquire>
801068fd:	83 c4 10             	add    $0x10,%esp
  xticks = ticks;
80106900:	a1 80 67 11 80       	mov    0x80116780,%eax
80106905:	89 45 f4             	mov    %eax,-0xc(%ebp)
  release(&tickslock);
80106908:	83 ec 0c             	sub    $0xc,%esp
8010690b:	68 40 5f 11 80       	push   $0x80115f40
80106910:	e8 ae ea ff ff       	call   801053c3 <release>
80106915:	83 c4 10             	add    $0x10,%esp
  return xticks;
80106918:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
8010691b:	c9                   	leave  
8010691c:	c3                   	ret    

8010691d <outb>:
8010691d:	55                   	push   %ebp
8010691e:	89 e5                	mov    %esp,%ebp
80106920:	83 ec 08             	sub    $0x8,%esp
80106923:	8b 55 08             	mov    0x8(%ebp),%edx
80106926:	8b 45 0c             	mov    0xc(%ebp),%eax
80106929:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
8010692d:	88 45 f8             	mov    %al,-0x8(%ebp)
80106930:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80106934:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80106938:	ee                   	out    %al,(%dx)
80106939:	c9                   	leave  
8010693a:	c3                   	ret    

8010693b <timerinit>:
8010693b:	55                   	push   %ebp
8010693c:	89 e5                	mov    %esp,%ebp
8010693e:	83 ec 08             	sub    $0x8,%esp
80106941:	6a 34                	push   $0x34
80106943:	6a 43                	push   $0x43
80106945:	e8 d3 ff ff ff       	call   8010691d <outb>
8010694a:	83 c4 08             	add    $0x8,%esp
8010694d:	68 9c 00 00 00       	push   $0x9c
80106952:	6a 40                	push   $0x40
80106954:	e8 c4 ff ff ff       	call   8010691d <outb>
80106959:	83 c4 08             	add    $0x8,%esp
8010695c:	6a 2e                	push   $0x2e
8010695e:	6a 40                	push   $0x40
80106960:	e8 b8 ff ff ff       	call   8010691d <outb>
80106965:	83 c4 08             	add    $0x8,%esp
80106968:	83 ec 0c             	sub    $0xc,%esp
8010696b:	6a 00                	push   $0x0
8010696d:	e8 7c d5 ff ff       	call   80103eee <picenable>
80106972:	83 c4 10             	add    $0x10,%esp
80106975:	c9                   	leave  
80106976:	c3                   	ret    

80106977 <alltraps>:
80106977:	1e                   	push   %ds
80106978:	06                   	push   %es
80106979:	0f a0                	push   %fs
8010697b:	0f a8                	push   %gs
8010697d:	60                   	pusha  
8010697e:	66 b8 10 00          	mov    $0x10,%ax
80106982:	8e d8                	mov    %eax,%ds
80106984:	8e c0                	mov    %eax,%es
80106986:	66 b8 18 00          	mov    $0x18,%ax
8010698a:	8e e0                	mov    %eax,%fs
8010698c:	8e e8                	mov    %eax,%gs
8010698e:	54                   	push   %esp
8010698f:	e8 d7 01 00 00       	call   80106b6b <trap>
80106994:	83 c4 04             	add    $0x4,%esp

80106997 <trapret>:
80106997:	61                   	popa   
80106998:	0f a9                	pop    %gs
8010699a:	0f a1                	pop    %fs
8010699c:	07                   	pop    %es
8010699d:	1f                   	pop    %ds
8010699e:	83 c4 08             	add    $0x8,%esp
801069a1:	cf                   	iret   

801069a2 <lidt>:

struct gatedesc;

static inline void
lidt(struct gatedesc *p, int size)
{
801069a2:	55                   	push   %ebp
801069a3:	89 e5                	mov    %esp,%ebp
801069a5:	83 ec 10             	sub    $0x10,%esp
  volatile ushort pd[3];

  pd[0] = size-1;
801069a8:	8b 45 0c             	mov    0xc(%ebp),%eax
801069ab:	83 e8 01             	sub    $0x1,%eax
801069ae:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
801069b2:	8b 45 08             	mov    0x8(%ebp),%eax
801069b5:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
801069b9:	8b 45 08             	mov    0x8(%ebp),%eax
801069bc:	c1 e8 10             	shr    $0x10,%eax
801069bf:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lidt (%0)" : : "r" (pd));
801069c3:	8d 45 fa             	lea    -0x6(%ebp),%eax
801069c6:	0f 01 18             	lidtl  (%eax)
}
801069c9:	90                   	nop
801069ca:	c9                   	leave  
801069cb:	c3                   	ret    

801069cc <rcr2>:
  return result;
}

static inline uint
rcr2(void)
{
801069cc:	55                   	push   %ebp
801069cd:	89 e5                	mov    %esp,%ebp
801069cf:	83 ec 10             	sub    $0x10,%esp
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
801069d2:	0f 20 d0             	mov    %cr2,%eax
801069d5:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return val;
801069d8:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
801069db:	c9                   	leave  
801069dc:	c3                   	ret    

801069dd <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
801069dd:	55                   	push   %ebp
801069de:	89 e5                	mov    %esp,%ebp
801069e0:	83 ec 18             	sub    $0x18,%esp
  int i;

  for(i = 0; i < 256; i++)
801069e3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801069ea:	e9 c3 00 00 00       	jmp    80106ab2 <tvinit+0xd5>
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
801069ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
801069f2:	8b 04 85 98 c0 10 80 	mov    -0x7fef3f68(,%eax,4),%eax
801069f9:	89 c2                	mov    %eax,%edx
801069fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801069fe:	66 89 14 c5 80 5f 11 	mov    %dx,-0x7feea080(,%eax,8)
80106a05:	80 
80106a06:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106a09:	66 c7 04 c5 82 5f 11 	movw   $0x8,-0x7feea07e(,%eax,8)
80106a10:	80 08 00 
80106a13:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106a16:	0f b6 14 c5 84 5f 11 	movzbl -0x7feea07c(,%eax,8),%edx
80106a1d:	80 
80106a1e:	83 e2 e0             	and    $0xffffffe0,%edx
80106a21:	88 14 c5 84 5f 11 80 	mov    %dl,-0x7feea07c(,%eax,8)
80106a28:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106a2b:	0f b6 14 c5 84 5f 11 	movzbl -0x7feea07c(,%eax,8),%edx
80106a32:	80 
80106a33:	83 e2 1f             	and    $0x1f,%edx
80106a36:	88 14 c5 84 5f 11 80 	mov    %dl,-0x7feea07c(,%eax,8)
80106a3d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106a40:	0f b6 14 c5 85 5f 11 	movzbl -0x7feea07b(,%eax,8),%edx
80106a47:	80 
80106a48:	83 e2 f0             	and    $0xfffffff0,%edx
80106a4b:	83 ca 0e             	or     $0xe,%edx
80106a4e:	88 14 c5 85 5f 11 80 	mov    %dl,-0x7feea07b(,%eax,8)
80106a55:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106a58:	0f b6 14 c5 85 5f 11 	movzbl -0x7feea07b(,%eax,8),%edx
80106a5f:	80 
80106a60:	83 e2 ef             	and    $0xffffffef,%edx
80106a63:	88 14 c5 85 5f 11 80 	mov    %dl,-0x7feea07b(,%eax,8)
80106a6a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106a6d:	0f b6 14 c5 85 5f 11 	movzbl -0x7feea07b(,%eax,8),%edx
80106a74:	80 
80106a75:	83 e2 9f             	and    $0xffffff9f,%edx
80106a78:	88 14 c5 85 5f 11 80 	mov    %dl,-0x7feea07b(,%eax,8)
80106a7f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106a82:	0f b6 14 c5 85 5f 11 	movzbl -0x7feea07b(,%eax,8),%edx
80106a89:	80 
80106a8a:	83 ca 80             	or     $0xffffff80,%edx
80106a8d:	88 14 c5 85 5f 11 80 	mov    %dl,-0x7feea07b(,%eax,8)
80106a94:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106a97:	8b 04 85 98 c0 10 80 	mov    -0x7fef3f68(,%eax,4),%eax
80106a9e:	c1 e8 10             	shr    $0x10,%eax
80106aa1:	89 c2                	mov    %eax,%edx
80106aa3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106aa6:	66 89 14 c5 86 5f 11 	mov    %dx,-0x7feea07a(,%eax,8)
80106aad:	80 
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
80106aae:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80106ab2:	81 7d f4 ff 00 00 00 	cmpl   $0xff,-0xc(%ebp)
80106ab9:	0f 8e 30 ff ff ff    	jle    801069ef <tvinit+0x12>
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106abf:	a1 98 c1 10 80       	mov    0x8010c198,%eax
80106ac4:	66 a3 80 61 11 80    	mov    %ax,0x80116180
80106aca:	66 c7 05 82 61 11 80 	movw   $0x8,0x80116182
80106ad1:	08 00 
80106ad3:	0f b6 05 84 61 11 80 	movzbl 0x80116184,%eax
80106ada:	83 e0 e0             	and    $0xffffffe0,%eax
80106add:	a2 84 61 11 80       	mov    %al,0x80116184
80106ae2:	0f b6 05 84 61 11 80 	movzbl 0x80116184,%eax
80106ae9:	83 e0 1f             	and    $0x1f,%eax
80106aec:	a2 84 61 11 80       	mov    %al,0x80116184
80106af1:	0f b6 05 85 61 11 80 	movzbl 0x80116185,%eax
80106af8:	83 c8 0f             	or     $0xf,%eax
80106afb:	a2 85 61 11 80       	mov    %al,0x80116185
80106b00:	0f b6 05 85 61 11 80 	movzbl 0x80116185,%eax
80106b07:	83 e0 ef             	and    $0xffffffef,%eax
80106b0a:	a2 85 61 11 80       	mov    %al,0x80116185
80106b0f:	0f b6 05 85 61 11 80 	movzbl 0x80116185,%eax
80106b16:	83 c8 60             	or     $0x60,%eax
80106b19:	a2 85 61 11 80       	mov    %al,0x80116185
80106b1e:	0f b6 05 85 61 11 80 	movzbl 0x80116185,%eax
80106b25:	83 c8 80             	or     $0xffffff80,%eax
80106b28:	a2 85 61 11 80       	mov    %al,0x80116185
80106b2d:	a1 98 c1 10 80       	mov    0x8010c198,%eax
80106b32:	c1 e8 10             	shr    $0x10,%eax
80106b35:	66 a3 86 61 11 80    	mov    %ax,0x80116186
  
  initlock(&tickslock, "time");
80106b3b:	83 ec 08             	sub    $0x8,%esp
80106b3e:	68 e8 8d 10 80       	push   $0x80108de8
80106b43:	68 40 5f 11 80       	push   $0x80115f40
80106b48:	e8 ed e7 ff ff       	call   8010533a <initlock>
80106b4d:	83 c4 10             	add    $0x10,%esp
}
80106b50:	90                   	nop
80106b51:	c9                   	leave  
80106b52:	c3                   	ret    

80106b53 <idtinit>:

void
idtinit(void)
{
80106b53:	55                   	push   %ebp
80106b54:	89 e5                	mov    %esp,%ebp
  lidt(idt, sizeof(idt));
80106b56:	68 00 08 00 00       	push   $0x800
80106b5b:	68 80 5f 11 80       	push   $0x80115f80
80106b60:	e8 3d fe ff ff       	call   801069a2 <lidt>
80106b65:	83 c4 08             	add    $0x8,%esp
}
80106b68:	90                   	nop
80106b69:	c9                   	leave  
80106b6a:	c3                   	ret    

80106b6b <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80106b6b:	55                   	push   %ebp
80106b6c:	89 e5                	mov    %esp,%ebp
80106b6e:	57                   	push   %edi
80106b6f:	56                   	push   %esi
80106b70:	53                   	push   %ebx
80106b71:	83 ec 1c             	sub    $0x1c,%esp
  if(tf->trapno == T_SYSCALL){
80106b74:	8b 45 08             	mov    0x8(%ebp),%eax
80106b77:	8b 40 30             	mov    0x30(%eax),%eax
80106b7a:	83 f8 40             	cmp    $0x40,%eax
80106b7d:	75 3e                	jne    80106bbd <trap+0x52>
    if(proc->killed)
80106b7f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106b85:	8b 40 24             	mov    0x24(%eax),%eax
80106b88:	85 c0                	test   %eax,%eax
80106b8a:	74 05                	je     80106b91 <trap+0x26>
      exit();
80106b8c:	e8 f5 df ff ff       	call   80104b86 <exit>
    proc->tf = tf;
80106b91:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106b97:	8b 55 08             	mov    0x8(%ebp),%edx
80106b9a:	89 50 18             	mov    %edx,0x18(%eax)
    syscall();
80106b9d:	e8 f8 ed ff ff       	call   8010599a <syscall>
    if(proc->killed)
80106ba2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106ba8:	8b 40 24             	mov    0x24(%eax),%eax
80106bab:	85 c0                	test   %eax,%eax
80106bad:	0f 84 2c 02 00 00    	je     80106ddf <trap+0x274>
      exit();
80106bb3:	e8 ce df ff ff       	call   80104b86 <exit>
    return;
80106bb8:	e9 22 02 00 00       	jmp    80106ddf <trap+0x274>
  }

  switch(tf->trapno){
80106bbd:	8b 45 08             	mov    0x8(%ebp),%eax
80106bc0:	8b 40 30             	mov    0x30(%eax),%eax
80106bc3:	83 e8 20             	sub    $0x20,%eax
80106bc6:	83 f8 1f             	cmp    $0x1f,%eax
80106bc9:	0f 87 c0 00 00 00    	ja     80106c8f <trap+0x124>
80106bcf:	8b 04 85 90 8e 10 80 	mov    -0x7fef7170(,%eax,4),%eax
80106bd6:	ff e0                	jmp    *%eax
  case T_IRQ0 + IRQ_TIMER:
    if(cpu->id == 0){
80106bd8:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80106bde:	0f b6 00             	movzbl (%eax),%eax
80106be1:	84 c0                	test   %al,%al
80106be3:	75 3d                	jne    80106c22 <trap+0xb7>
      acquire(&tickslock);
80106be5:	83 ec 0c             	sub    $0xc,%esp
80106be8:	68 40 5f 11 80       	push   $0x80115f40
80106bed:	e8 6a e7 ff ff       	call   8010535c <acquire>
80106bf2:	83 c4 10             	add    $0x10,%esp
      ticks++;
80106bf5:	a1 80 67 11 80       	mov    0x80116780,%eax
80106bfa:	83 c0 01             	add    $0x1,%eax
80106bfd:	a3 80 67 11 80       	mov    %eax,0x80116780
      wakeup(&ticks);
80106c02:	83 ec 0c             	sub    $0xc,%esp
80106c05:	68 80 67 11 80       	push   $0x80116780
80106c0a:	e8 0a e5 ff ff       	call   80105119 <wakeup>
80106c0f:	83 c4 10             	add    $0x10,%esp
      release(&tickslock);
80106c12:	83 ec 0c             	sub    $0xc,%esp
80106c15:	68 40 5f 11 80       	push   $0x80115f40
80106c1a:	e8 a4 e7 ff ff       	call   801053c3 <release>
80106c1f:	83 c4 10             	add    $0x10,%esp
    }
    lapiceoi();
80106c22:	e8 cf c3 ff ff       	call   80102ff6 <lapiceoi>
    break;
80106c27:	e9 1c 01 00 00       	jmp    80106d48 <trap+0x1dd>
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80106c2c:	e8 e5 bb ff ff       	call   80102816 <ideintr>
    lapiceoi();
80106c31:	e8 c0 c3 ff ff       	call   80102ff6 <lapiceoi>
    break;
80106c36:	e9 0d 01 00 00       	jmp    80106d48 <trap+0x1dd>
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
80106c3b:	e8 bd c1 ff ff       	call   80102dfd <kbdintr>
    lapiceoi();
80106c40:	e8 b1 c3 ff ff       	call   80102ff6 <lapiceoi>
    break;
80106c45:	e9 fe 00 00 00       	jmp    80106d48 <trap+0x1dd>
  case T_IRQ0 + IRQ_COM1:
    uartintr();
80106c4a:	e8 71 03 00 00       	call   80106fc0 <uartintr>
    lapiceoi();
80106c4f:	e8 a2 c3 ff ff       	call   80102ff6 <lapiceoi>
    break;
80106c54:	e9 ef 00 00 00       	jmp    80106d48 <trap+0x1dd>
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106c59:	8b 45 08             	mov    0x8(%ebp),%eax
80106c5c:	8b 48 38             	mov    0x38(%eax),%ecx
            cpu->id, tf->cs, tf->eip);
80106c5f:	8b 45 08             	mov    0x8(%ebp),%eax
80106c62:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
    uartintr();
    lapiceoi();
    break;
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106c66:	0f b7 d0             	movzwl %ax,%edx
            cpu->id, tf->cs, tf->eip);
80106c69:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80106c6f:	0f b6 00             	movzbl (%eax),%eax
    uartintr();
    lapiceoi();
    break;
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106c72:	0f b6 c0             	movzbl %al,%eax
80106c75:	51                   	push   %ecx
80106c76:	52                   	push   %edx
80106c77:	50                   	push   %eax
80106c78:	68 f0 8d 10 80       	push   $0x80108df0
80106c7d:	e8 40 97 ff ff       	call   801003c2 <cprintf>
80106c82:	83 c4 10             	add    $0x10,%esp
            cpu->id, tf->cs, tf->eip);
    lapiceoi();
80106c85:	e8 6c c3 ff ff       	call   80102ff6 <lapiceoi>
    break;
80106c8a:	e9 b9 00 00 00       	jmp    80106d48 <trap+0x1dd>
   
  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
80106c8f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106c95:	85 c0                	test   %eax,%eax
80106c97:	74 11                	je     80106caa <trap+0x13f>
80106c99:	8b 45 08             	mov    0x8(%ebp),%eax
80106c9c:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
80106ca0:	0f b7 c0             	movzwl %ax,%eax
80106ca3:	83 e0 03             	and    $0x3,%eax
80106ca6:	85 c0                	test   %eax,%eax
80106ca8:	75 40                	jne    80106cea <trap+0x17f>
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80106caa:	e8 1d fd ff ff       	call   801069cc <rcr2>
80106caf:	89 c3                	mov    %eax,%ebx
80106cb1:	8b 45 08             	mov    0x8(%ebp),%eax
80106cb4:	8b 48 38             	mov    0x38(%eax),%ecx
              tf->trapno, cpu->id, tf->eip, rcr2());
80106cb7:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80106cbd:	0f b6 00             	movzbl (%eax),%eax
   
  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80106cc0:	0f b6 d0             	movzbl %al,%edx
80106cc3:	8b 45 08             	mov    0x8(%ebp),%eax
80106cc6:	8b 40 30             	mov    0x30(%eax),%eax
80106cc9:	83 ec 0c             	sub    $0xc,%esp
80106ccc:	53                   	push   %ebx
80106ccd:	51                   	push   %ecx
80106cce:	52                   	push   %edx
80106ccf:	50                   	push   %eax
80106cd0:	68 14 8e 10 80       	push   $0x80108e14
80106cd5:	e8 e8 96 ff ff       	call   801003c2 <cprintf>
80106cda:	83 c4 20             	add    $0x20,%esp
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
80106cdd:	83 ec 0c             	sub    $0xc,%esp
80106ce0:	68 46 8e 10 80       	push   $0x80108e46
80106ce5:	e8 78 98 ff ff       	call   80100562 <panic>
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106cea:	e8 dd fc ff ff       	call   801069cc <rcr2>
80106cef:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106cf2:	8b 45 08             	mov    0x8(%ebp),%eax
80106cf5:	8b 70 38             	mov    0x38(%eax),%esi
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
80106cf8:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80106cfe:	0f b6 00             	movzbl (%eax),%eax
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106d01:	0f b6 d8             	movzbl %al,%ebx
80106d04:	8b 45 08             	mov    0x8(%ebp),%eax
80106d07:	8b 48 34             	mov    0x34(%eax),%ecx
80106d0a:	8b 45 08             	mov    0x8(%ebp),%eax
80106d0d:	8b 50 30             	mov    0x30(%eax),%edx
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
80106d10:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106d16:	8d 78 6c             	lea    0x6c(%eax),%edi
80106d19:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106d1f:	8b 40 10             	mov    0x10(%eax),%eax
80106d22:	ff 75 e4             	pushl  -0x1c(%ebp)
80106d25:	56                   	push   %esi
80106d26:	53                   	push   %ebx
80106d27:	51                   	push   %ecx
80106d28:	52                   	push   %edx
80106d29:	57                   	push   %edi
80106d2a:	50                   	push   %eax
80106d2b:	68 4c 8e 10 80       	push   $0x80108e4c
80106d30:	e8 8d 96 ff ff       	call   801003c2 <cprintf>
80106d35:	83 c4 20             	add    $0x20,%esp
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
            rcr2());
    proc->killed = 1;
80106d38:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106d3e:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
80106d45:	eb 01                	jmp    80106d48 <trap+0x1dd>
    ideintr();
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
80106d47:	90                   	nop
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running 
  // until it gets to the regular system call return.)
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80106d48:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106d4e:	85 c0                	test   %eax,%eax
80106d50:	74 24                	je     80106d76 <trap+0x20b>
80106d52:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106d58:	8b 40 24             	mov    0x24(%eax),%eax
80106d5b:	85 c0                	test   %eax,%eax
80106d5d:	74 17                	je     80106d76 <trap+0x20b>
80106d5f:	8b 45 08             	mov    0x8(%ebp),%eax
80106d62:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
80106d66:	0f b7 c0             	movzwl %ax,%eax
80106d69:	83 e0 03             	and    $0x3,%eax
80106d6c:	83 f8 03             	cmp    $0x3,%eax
80106d6f:	75 05                	jne    80106d76 <trap+0x20b>
    exit();
80106d71:	e8 10 de ff ff       	call   80104b86 <exit>

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  
  if(proc && proc->priority != LOW)				//Só continua se a prioridade for diferente de baixa (não-preemptivo)
80106d76:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106d7c:	85 c0                	test   %eax,%eax
80106d7e:	74 2f                	je     80106daf <trap+0x244>
80106d80:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106d86:	8b 80 80 00 00 00    	mov    0x80(%eax),%eax
80106d8c:	83 f8 02             	cmp    $0x2,%eax
80106d8f:	74 1e                	je     80106daf <trap+0x244>
    if(proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
80106d91:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106d97:	8b 40 0c             	mov    0xc(%eax),%eax
80106d9a:	83 f8 04             	cmp    $0x4,%eax
80106d9d:	75 10                	jne    80106daf <trap+0x244>
80106d9f:	8b 45 08             	mov    0x8(%ebp),%eax
80106da2:	8b 40 30             	mov    0x30(%eax),%eax
80106da5:	83 f8 20             	cmp    $0x20,%eax
80106da8:	75 05                	jne    80106daf <trap+0x244>
	   yield();
80106daa:	e8 db e1 ff ff       	call   80104f8a <yield>

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80106daf:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106db5:	85 c0                	test   %eax,%eax
80106db7:	74 27                	je     80106de0 <trap+0x275>
80106db9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106dbf:	8b 40 24             	mov    0x24(%eax),%eax
80106dc2:	85 c0                	test   %eax,%eax
80106dc4:	74 1a                	je     80106de0 <trap+0x275>
80106dc6:	8b 45 08             	mov    0x8(%ebp),%eax
80106dc9:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
80106dcd:	0f b7 c0             	movzwl %ax,%eax
80106dd0:	83 e0 03             	and    $0x3,%eax
80106dd3:	83 f8 03             	cmp    $0x3,%eax
80106dd6:	75 08                	jne    80106de0 <trap+0x275>
    exit();
80106dd8:	e8 a9 dd ff ff       	call   80104b86 <exit>
80106ddd:	eb 01                	jmp    80106de0 <trap+0x275>
      exit();
    proc->tf = tf;
    syscall();
    if(proc->killed)
      exit();
    return;
80106ddf:	90                   	nop
	   yield();

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
    exit();
}
80106de0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106de3:	5b                   	pop    %ebx
80106de4:	5e                   	pop    %esi
80106de5:	5f                   	pop    %edi
80106de6:	5d                   	pop    %ebp
80106de7:	c3                   	ret    

80106de8 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
80106de8:	55                   	push   %ebp
80106de9:	89 e5                	mov    %esp,%ebp
80106deb:	83 ec 14             	sub    $0x14,%esp
80106dee:	8b 45 08             	mov    0x8(%ebp),%eax
80106df1:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80106df5:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80106df9:	89 c2                	mov    %eax,%edx
80106dfb:	ec                   	in     (%dx),%al
80106dfc:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80106dff:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80106e03:	c9                   	leave  
80106e04:	c3                   	ret    

80106e05 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80106e05:	55                   	push   %ebp
80106e06:	89 e5                	mov    %esp,%ebp
80106e08:	83 ec 08             	sub    $0x8,%esp
80106e0b:	8b 55 08             	mov    0x8(%ebp),%edx
80106e0e:	8b 45 0c             	mov    0xc(%ebp),%eax
80106e11:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80106e15:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106e18:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80106e1c:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80106e20:	ee                   	out    %al,(%dx)
}
80106e21:	90                   	nop
80106e22:	c9                   	leave  
80106e23:	c3                   	ret    

80106e24 <uartinit>:

static int uart;    // is there a uart?

void
uartinit(void)
{
80106e24:	55                   	push   %ebp
80106e25:	89 e5                	mov    %esp,%ebp
80106e27:	83 ec 18             	sub    $0x18,%esp
  char *p;

  // Turn off the FIFO
  outb(COM1+2, 0);
80106e2a:	6a 00                	push   $0x0
80106e2c:	68 fa 03 00 00       	push   $0x3fa
80106e31:	e8 cf ff ff ff       	call   80106e05 <outb>
80106e36:	83 c4 08             	add    $0x8,%esp
  
  // 9600 baud, 8 data bits, 1 stop bit, parity off.
  outb(COM1+3, 0x80);    // Unlock divisor
80106e39:	68 80 00 00 00       	push   $0x80
80106e3e:	68 fb 03 00 00       	push   $0x3fb
80106e43:	e8 bd ff ff ff       	call   80106e05 <outb>
80106e48:	83 c4 08             	add    $0x8,%esp
  outb(COM1+0, 115200/9600);
80106e4b:	6a 0c                	push   $0xc
80106e4d:	68 f8 03 00 00       	push   $0x3f8
80106e52:	e8 ae ff ff ff       	call   80106e05 <outb>
80106e57:	83 c4 08             	add    $0x8,%esp
  outb(COM1+1, 0);
80106e5a:	6a 00                	push   $0x0
80106e5c:	68 f9 03 00 00       	push   $0x3f9
80106e61:	e8 9f ff ff ff       	call   80106e05 <outb>
80106e66:	83 c4 08             	add    $0x8,%esp
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
80106e69:	6a 03                	push   $0x3
80106e6b:	68 fb 03 00 00       	push   $0x3fb
80106e70:	e8 90 ff ff ff       	call   80106e05 <outb>
80106e75:	83 c4 08             	add    $0x8,%esp
  outb(COM1+4, 0);
80106e78:	6a 00                	push   $0x0
80106e7a:	68 fc 03 00 00       	push   $0x3fc
80106e7f:	e8 81 ff ff ff       	call   80106e05 <outb>
80106e84:	83 c4 08             	add    $0x8,%esp
  outb(COM1+1, 0x01);    // Enable receive interrupts.
80106e87:	6a 01                	push   $0x1
80106e89:	68 f9 03 00 00       	push   $0x3f9
80106e8e:	e8 72 ff ff ff       	call   80106e05 <outb>
80106e93:	83 c4 08             	add    $0x8,%esp

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
80106e96:	68 fd 03 00 00       	push   $0x3fd
80106e9b:	e8 48 ff ff ff       	call   80106de8 <inb>
80106ea0:	83 c4 04             	add    $0x4,%esp
80106ea3:	3c ff                	cmp    $0xff,%al
80106ea5:	74 6e                	je     80106f15 <uartinit+0xf1>
    return;
  uart = 1;
80106ea7:	c7 05 60 ca 10 80 01 	movl   $0x1,0x8010ca60
80106eae:	00 00 00 

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
80106eb1:	68 fa 03 00 00       	push   $0x3fa
80106eb6:	e8 2d ff ff ff       	call   80106de8 <inb>
80106ebb:	83 c4 04             	add    $0x4,%esp
  inb(COM1+0);
80106ebe:	68 f8 03 00 00       	push   $0x3f8
80106ec3:	e8 20 ff ff ff       	call   80106de8 <inb>
80106ec8:	83 c4 04             	add    $0x4,%esp
  picenable(IRQ_COM1);
80106ecb:	83 ec 0c             	sub    $0xc,%esp
80106ece:	6a 04                	push   $0x4
80106ed0:	e8 19 d0 ff ff       	call   80103eee <picenable>
80106ed5:	83 c4 10             	add    $0x10,%esp
  ioapicenable(IRQ_COM1, 0);
80106ed8:	83 ec 08             	sub    $0x8,%esp
80106edb:	6a 00                	push   $0x0
80106edd:	6a 04                	push   $0x4
80106edf:	e8 d1 bb ff ff       	call   80102ab5 <ioapicenable>
80106ee4:	83 c4 10             	add    $0x10,%esp
  
  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80106ee7:	c7 45 f4 10 8f 10 80 	movl   $0x80108f10,-0xc(%ebp)
80106eee:	eb 19                	jmp    80106f09 <uartinit+0xe5>
    uartputc(*p);
80106ef0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106ef3:	0f b6 00             	movzbl (%eax),%eax
80106ef6:	0f be c0             	movsbl %al,%eax
80106ef9:	83 ec 0c             	sub    $0xc,%esp
80106efc:	50                   	push   %eax
80106efd:	e8 16 00 00 00       	call   80106f18 <uartputc>
80106f02:	83 c4 10             	add    $0x10,%esp
  inb(COM1+0);
  picenable(IRQ_COM1);
  ioapicenable(IRQ_COM1, 0);
  
  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80106f05:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80106f09:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106f0c:	0f b6 00             	movzbl (%eax),%eax
80106f0f:	84 c0                	test   %al,%al
80106f11:	75 dd                	jne    80106ef0 <uartinit+0xcc>
80106f13:	eb 01                	jmp    80106f16 <uartinit+0xf2>
  outb(COM1+4, 0);
  outb(COM1+1, 0x01);    // Enable receive interrupts.

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
    return;
80106f15:	90                   	nop
  ioapicenable(IRQ_COM1, 0);
  
  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
    uartputc(*p);
}
80106f16:	c9                   	leave  
80106f17:	c3                   	ret    

80106f18 <uartputc>:

void
uartputc(int c)
{
80106f18:	55                   	push   %ebp
80106f19:	89 e5                	mov    %esp,%ebp
80106f1b:	83 ec 18             	sub    $0x18,%esp
  int i;

  if(!uart)
80106f1e:	a1 60 ca 10 80       	mov    0x8010ca60,%eax
80106f23:	85 c0                	test   %eax,%eax
80106f25:	74 53                	je     80106f7a <uartputc+0x62>
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80106f27:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80106f2e:	eb 11                	jmp    80106f41 <uartputc+0x29>
    microdelay(10);
80106f30:	83 ec 0c             	sub    $0xc,%esp
80106f33:	6a 0a                	push   $0xa
80106f35:	e8 d6 c0 ff ff       	call   80103010 <microdelay>
80106f3a:	83 c4 10             	add    $0x10,%esp
{
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80106f3d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80106f41:	83 7d f4 7f          	cmpl   $0x7f,-0xc(%ebp)
80106f45:	7f 1a                	jg     80106f61 <uartputc+0x49>
80106f47:	83 ec 0c             	sub    $0xc,%esp
80106f4a:	68 fd 03 00 00       	push   $0x3fd
80106f4f:	e8 94 fe ff ff       	call   80106de8 <inb>
80106f54:	83 c4 10             	add    $0x10,%esp
80106f57:	0f b6 c0             	movzbl %al,%eax
80106f5a:	83 e0 20             	and    $0x20,%eax
80106f5d:	85 c0                	test   %eax,%eax
80106f5f:	74 cf                	je     80106f30 <uartputc+0x18>
    microdelay(10);
  outb(COM1+0, c);
80106f61:	8b 45 08             	mov    0x8(%ebp),%eax
80106f64:	0f b6 c0             	movzbl %al,%eax
80106f67:	83 ec 08             	sub    $0x8,%esp
80106f6a:	50                   	push   %eax
80106f6b:	68 f8 03 00 00       	push   $0x3f8
80106f70:	e8 90 fe ff ff       	call   80106e05 <outb>
80106f75:	83 c4 10             	add    $0x10,%esp
80106f78:	eb 01                	jmp    80106f7b <uartputc+0x63>
uartputc(int c)
{
  int i;

  if(!uart)
    return;
80106f7a:	90                   	nop
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
  outb(COM1+0, c);
}
80106f7b:	c9                   	leave  
80106f7c:	c3                   	ret    

80106f7d <uartgetc>:

static int
uartgetc(void)
{
80106f7d:	55                   	push   %ebp
80106f7e:	89 e5                	mov    %esp,%ebp
  if(!uart)
80106f80:	a1 60 ca 10 80       	mov    0x8010ca60,%eax
80106f85:	85 c0                	test   %eax,%eax
80106f87:	75 07                	jne    80106f90 <uartgetc+0x13>
    return -1;
80106f89:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106f8e:	eb 2e                	jmp    80106fbe <uartgetc+0x41>
  if(!(inb(COM1+5) & 0x01))
80106f90:	68 fd 03 00 00       	push   $0x3fd
80106f95:	e8 4e fe ff ff       	call   80106de8 <inb>
80106f9a:	83 c4 04             	add    $0x4,%esp
80106f9d:	0f b6 c0             	movzbl %al,%eax
80106fa0:	83 e0 01             	and    $0x1,%eax
80106fa3:	85 c0                	test   %eax,%eax
80106fa5:	75 07                	jne    80106fae <uartgetc+0x31>
    return -1;
80106fa7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106fac:	eb 10                	jmp    80106fbe <uartgetc+0x41>
  return inb(COM1+0);
80106fae:	68 f8 03 00 00       	push   $0x3f8
80106fb3:	e8 30 fe ff ff       	call   80106de8 <inb>
80106fb8:	83 c4 04             	add    $0x4,%esp
80106fbb:	0f b6 c0             	movzbl %al,%eax
}
80106fbe:	c9                   	leave  
80106fbf:	c3                   	ret    

80106fc0 <uartintr>:

void
uartintr(void)
{
80106fc0:	55                   	push   %ebp
80106fc1:	89 e5                	mov    %esp,%ebp
80106fc3:	83 ec 08             	sub    $0x8,%esp
  consoleintr(uartgetc);
80106fc6:	83 ec 0c             	sub    $0xc,%esp
80106fc9:	68 7d 6f 10 80       	push   $0x80106f7d
80106fce:	e8 06 98 ff ff       	call   801007d9 <consoleintr>
80106fd3:	83 c4 10             	add    $0x10,%esp
}
80106fd6:	90                   	nop
80106fd7:	c9                   	leave  
80106fd8:	c3                   	ret    

80106fd9 <vector0>:
80106fd9:	6a 00                	push   $0x0
80106fdb:	6a 00                	push   $0x0
80106fdd:	e9 95 f9 ff ff       	jmp    80106977 <alltraps>

80106fe2 <vector1>:
80106fe2:	6a 00                	push   $0x0
80106fe4:	6a 01                	push   $0x1
80106fe6:	e9 8c f9 ff ff       	jmp    80106977 <alltraps>

80106feb <vector2>:
80106feb:	6a 00                	push   $0x0
80106fed:	6a 02                	push   $0x2
80106fef:	e9 83 f9 ff ff       	jmp    80106977 <alltraps>

80106ff4 <vector3>:
80106ff4:	6a 00                	push   $0x0
80106ff6:	6a 03                	push   $0x3
80106ff8:	e9 7a f9 ff ff       	jmp    80106977 <alltraps>

80106ffd <vector4>:
80106ffd:	6a 00                	push   $0x0
80106fff:	6a 04                	push   $0x4
80107001:	e9 71 f9 ff ff       	jmp    80106977 <alltraps>

80107006 <vector5>:
80107006:	6a 00                	push   $0x0
80107008:	6a 05                	push   $0x5
8010700a:	e9 68 f9 ff ff       	jmp    80106977 <alltraps>

8010700f <vector6>:
8010700f:	6a 00                	push   $0x0
80107011:	6a 06                	push   $0x6
80107013:	e9 5f f9 ff ff       	jmp    80106977 <alltraps>

80107018 <vector7>:
80107018:	6a 00                	push   $0x0
8010701a:	6a 07                	push   $0x7
8010701c:	e9 56 f9 ff ff       	jmp    80106977 <alltraps>

80107021 <vector8>:
80107021:	6a 08                	push   $0x8
80107023:	e9 4f f9 ff ff       	jmp    80106977 <alltraps>

80107028 <vector9>:
80107028:	6a 00                	push   $0x0
8010702a:	6a 09                	push   $0x9
8010702c:	e9 46 f9 ff ff       	jmp    80106977 <alltraps>

80107031 <vector10>:
80107031:	6a 0a                	push   $0xa
80107033:	e9 3f f9 ff ff       	jmp    80106977 <alltraps>

80107038 <vector11>:
80107038:	6a 0b                	push   $0xb
8010703a:	e9 38 f9 ff ff       	jmp    80106977 <alltraps>

8010703f <vector12>:
8010703f:	6a 0c                	push   $0xc
80107041:	e9 31 f9 ff ff       	jmp    80106977 <alltraps>

80107046 <vector13>:
80107046:	6a 0d                	push   $0xd
80107048:	e9 2a f9 ff ff       	jmp    80106977 <alltraps>

8010704d <vector14>:
8010704d:	6a 0e                	push   $0xe
8010704f:	e9 23 f9 ff ff       	jmp    80106977 <alltraps>

80107054 <vector15>:
80107054:	6a 00                	push   $0x0
80107056:	6a 0f                	push   $0xf
80107058:	e9 1a f9 ff ff       	jmp    80106977 <alltraps>

8010705d <vector16>:
8010705d:	6a 00                	push   $0x0
8010705f:	6a 10                	push   $0x10
80107061:	e9 11 f9 ff ff       	jmp    80106977 <alltraps>

80107066 <vector17>:
80107066:	6a 11                	push   $0x11
80107068:	e9 0a f9 ff ff       	jmp    80106977 <alltraps>

8010706d <vector18>:
8010706d:	6a 00                	push   $0x0
8010706f:	6a 12                	push   $0x12
80107071:	e9 01 f9 ff ff       	jmp    80106977 <alltraps>

80107076 <vector19>:
80107076:	6a 00                	push   $0x0
80107078:	6a 13                	push   $0x13
8010707a:	e9 f8 f8 ff ff       	jmp    80106977 <alltraps>

8010707f <vector20>:
8010707f:	6a 00                	push   $0x0
80107081:	6a 14                	push   $0x14
80107083:	e9 ef f8 ff ff       	jmp    80106977 <alltraps>

80107088 <vector21>:
80107088:	6a 00                	push   $0x0
8010708a:	6a 15                	push   $0x15
8010708c:	e9 e6 f8 ff ff       	jmp    80106977 <alltraps>

80107091 <vector22>:
80107091:	6a 00                	push   $0x0
80107093:	6a 16                	push   $0x16
80107095:	e9 dd f8 ff ff       	jmp    80106977 <alltraps>

8010709a <vector23>:
8010709a:	6a 00                	push   $0x0
8010709c:	6a 17                	push   $0x17
8010709e:	e9 d4 f8 ff ff       	jmp    80106977 <alltraps>

801070a3 <vector24>:
801070a3:	6a 00                	push   $0x0
801070a5:	6a 18                	push   $0x18
801070a7:	e9 cb f8 ff ff       	jmp    80106977 <alltraps>

801070ac <vector25>:
801070ac:	6a 00                	push   $0x0
801070ae:	6a 19                	push   $0x19
801070b0:	e9 c2 f8 ff ff       	jmp    80106977 <alltraps>

801070b5 <vector26>:
801070b5:	6a 00                	push   $0x0
801070b7:	6a 1a                	push   $0x1a
801070b9:	e9 b9 f8 ff ff       	jmp    80106977 <alltraps>

801070be <vector27>:
801070be:	6a 00                	push   $0x0
801070c0:	6a 1b                	push   $0x1b
801070c2:	e9 b0 f8 ff ff       	jmp    80106977 <alltraps>

801070c7 <vector28>:
801070c7:	6a 00                	push   $0x0
801070c9:	6a 1c                	push   $0x1c
801070cb:	e9 a7 f8 ff ff       	jmp    80106977 <alltraps>

801070d0 <vector29>:
801070d0:	6a 00                	push   $0x0
801070d2:	6a 1d                	push   $0x1d
801070d4:	e9 9e f8 ff ff       	jmp    80106977 <alltraps>

801070d9 <vector30>:
801070d9:	6a 00                	push   $0x0
801070db:	6a 1e                	push   $0x1e
801070dd:	e9 95 f8 ff ff       	jmp    80106977 <alltraps>

801070e2 <vector31>:
801070e2:	6a 00                	push   $0x0
801070e4:	6a 1f                	push   $0x1f
801070e6:	e9 8c f8 ff ff       	jmp    80106977 <alltraps>

801070eb <vector32>:
801070eb:	6a 00                	push   $0x0
801070ed:	6a 20                	push   $0x20
801070ef:	e9 83 f8 ff ff       	jmp    80106977 <alltraps>

801070f4 <vector33>:
801070f4:	6a 00                	push   $0x0
801070f6:	6a 21                	push   $0x21
801070f8:	e9 7a f8 ff ff       	jmp    80106977 <alltraps>

801070fd <vector34>:
801070fd:	6a 00                	push   $0x0
801070ff:	6a 22                	push   $0x22
80107101:	e9 71 f8 ff ff       	jmp    80106977 <alltraps>

80107106 <vector35>:
80107106:	6a 00                	push   $0x0
80107108:	6a 23                	push   $0x23
8010710a:	e9 68 f8 ff ff       	jmp    80106977 <alltraps>

8010710f <vector36>:
8010710f:	6a 00                	push   $0x0
80107111:	6a 24                	push   $0x24
80107113:	e9 5f f8 ff ff       	jmp    80106977 <alltraps>

80107118 <vector37>:
80107118:	6a 00                	push   $0x0
8010711a:	6a 25                	push   $0x25
8010711c:	e9 56 f8 ff ff       	jmp    80106977 <alltraps>

80107121 <vector38>:
80107121:	6a 00                	push   $0x0
80107123:	6a 26                	push   $0x26
80107125:	e9 4d f8 ff ff       	jmp    80106977 <alltraps>

8010712a <vector39>:
8010712a:	6a 00                	push   $0x0
8010712c:	6a 27                	push   $0x27
8010712e:	e9 44 f8 ff ff       	jmp    80106977 <alltraps>

80107133 <vector40>:
80107133:	6a 00                	push   $0x0
80107135:	6a 28                	push   $0x28
80107137:	e9 3b f8 ff ff       	jmp    80106977 <alltraps>

8010713c <vector41>:
8010713c:	6a 00                	push   $0x0
8010713e:	6a 29                	push   $0x29
80107140:	e9 32 f8 ff ff       	jmp    80106977 <alltraps>

80107145 <vector42>:
80107145:	6a 00                	push   $0x0
80107147:	6a 2a                	push   $0x2a
80107149:	e9 29 f8 ff ff       	jmp    80106977 <alltraps>

8010714e <vector43>:
8010714e:	6a 00                	push   $0x0
80107150:	6a 2b                	push   $0x2b
80107152:	e9 20 f8 ff ff       	jmp    80106977 <alltraps>

80107157 <vector44>:
80107157:	6a 00                	push   $0x0
80107159:	6a 2c                	push   $0x2c
8010715b:	e9 17 f8 ff ff       	jmp    80106977 <alltraps>

80107160 <vector45>:
80107160:	6a 00                	push   $0x0
80107162:	6a 2d                	push   $0x2d
80107164:	e9 0e f8 ff ff       	jmp    80106977 <alltraps>

80107169 <vector46>:
80107169:	6a 00                	push   $0x0
8010716b:	6a 2e                	push   $0x2e
8010716d:	e9 05 f8 ff ff       	jmp    80106977 <alltraps>

80107172 <vector47>:
80107172:	6a 00                	push   $0x0
80107174:	6a 2f                	push   $0x2f
80107176:	e9 fc f7 ff ff       	jmp    80106977 <alltraps>

8010717b <vector48>:
8010717b:	6a 00                	push   $0x0
8010717d:	6a 30                	push   $0x30
8010717f:	e9 f3 f7 ff ff       	jmp    80106977 <alltraps>

80107184 <vector49>:
80107184:	6a 00                	push   $0x0
80107186:	6a 31                	push   $0x31
80107188:	e9 ea f7 ff ff       	jmp    80106977 <alltraps>

8010718d <vector50>:
8010718d:	6a 00                	push   $0x0
8010718f:	6a 32                	push   $0x32
80107191:	e9 e1 f7 ff ff       	jmp    80106977 <alltraps>

80107196 <vector51>:
80107196:	6a 00                	push   $0x0
80107198:	6a 33                	push   $0x33
8010719a:	e9 d8 f7 ff ff       	jmp    80106977 <alltraps>

8010719f <vector52>:
8010719f:	6a 00                	push   $0x0
801071a1:	6a 34                	push   $0x34
801071a3:	e9 cf f7 ff ff       	jmp    80106977 <alltraps>

801071a8 <vector53>:
801071a8:	6a 00                	push   $0x0
801071aa:	6a 35                	push   $0x35
801071ac:	e9 c6 f7 ff ff       	jmp    80106977 <alltraps>

801071b1 <vector54>:
801071b1:	6a 00                	push   $0x0
801071b3:	6a 36                	push   $0x36
801071b5:	e9 bd f7 ff ff       	jmp    80106977 <alltraps>

801071ba <vector55>:
801071ba:	6a 00                	push   $0x0
801071bc:	6a 37                	push   $0x37
801071be:	e9 b4 f7 ff ff       	jmp    80106977 <alltraps>

801071c3 <vector56>:
801071c3:	6a 00                	push   $0x0
801071c5:	6a 38                	push   $0x38
801071c7:	e9 ab f7 ff ff       	jmp    80106977 <alltraps>

801071cc <vector57>:
801071cc:	6a 00                	push   $0x0
801071ce:	6a 39                	push   $0x39
801071d0:	e9 a2 f7 ff ff       	jmp    80106977 <alltraps>

801071d5 <vector58>:
801071d5:	6a 00                	push   $0x0
801071d7:	6a 3a                	push   $0x3a
801071d9:	e9 99 f7 ff ff       	jmp    80106977 <alltraps>

801071de <vector59>:
801071de:	6a 00                	push   $0x0
801071e0:	6a 3b                	push   $0x3b
801071e2:	e9 90 f7 ff ff       	jmp    80106977 <alltraps>

801071e7 <vector60>:
801071e7:	6a 00                	push   $0x0
801071e9:	6a 3c                	push   $0x3c
801071eb:	e9 87 f7 ff ff       	jmp    80106977 <alltraps>

801071f0 <vector61>:
801071f0:	6a 00                	push   $0x0
801071f2:	6a 3d                	push   $0x3d
801071f4:	e9 7e f7 ff ff       	jmp    80106977 <alltraps>

801071f9 <vector62>:
801071f9:	6a 00                	push   $0x0
801071fb:	6a 3e                	push   $0x3e
801071fd:	e9 75 f7 ff ff       	jmp    80106977 <alltraps>

80107202 <vector63>:
80107202:	6a 00                	push   $0x0
80107204:	6a 3f                	push   $0x3f
80107206:	e9 6c f7 ff ff       	jmp    80106977 <alltraps>

8010720b <vector64>:
8010720b:	6a 00                	push   $0x0
8010720d:	6a 40                	push   $0x40
8010720f:	e9 63 f7 ff ff       	jmp    80106977 <alltraps>

80107214 <vector65>:
80107214:	6a 00                	push   $0x0
80107216:	6a 41                	push   $0x41
80107218:	e9 5a f7 ff ff       	jmp    80106977 <alltraps>

8010721d <vector66>:
8010721d:	6a 00                	push   $0x0
8010721f:	6a 42                	push   $0x42
80107221:	e9 51 f7 ff ff       	jmp    80106977 <alltraps>

80107226 <vector67>:
80107226:	6a 00                	push   $0x0
80107228:	6a 43                	push   $0x43
8010722a:	e9 48 f7 ff ff       	jmp    80106977 <alltraps>

8010722f <vector68>:
8010722f:	6a 00                	push   $0x0
80107231:	6a 44                	push   $0x44
80107233:	e9 3f f7 ff ff       	jmp    80106977 <alltraps>

80107238 <vector69>:
80107238:	6a 00                	push   $0x0
8010723a:	6a 45                	push   $0x45
8010723c:	e9 36 f7 ff ff       	jmp    80106977 <alltraps>

80107241 <vector70>:
80107241:	6a 00                	push   $0x0
80107243:	6a 46                	push   $0x46
80107245:	e9 2d f7 ff ff       	jmp    80106977 <alltraps>

8010724a <vector71>:
8010724a:	6a 00                	push   $0x0
8010724c:	6a 47                	push   $0x47
8010724e:	e9 24 f7 ff ff       	jmp    80106977 <alltraps>

80107253 <vector72>:
80107253:	6a 00                	push   $0x0
80107255:	6a 48                	push   $0x48
80107257:	e9 1b f7 ff ff       	jmp    80106977 <alltraps>

8010725c <vector73>:
8010725c:	6a 00                	push   $0x0
8010725e:	6a 49                	push   $0x49
80107260:	e9 12 f7 ff ff       	jmp    80106977 <alltraps>

80107265 <vector74>:
80107265:	6a 00                	push   $0x0
80107267:	6a 4a                	push   $0x4a
80107269:	e9 09 f7 ff ff       	jmp    80106977 <alltraps>

8010726e <vector75>:
8010726e:	6a 00                	push   $0x0
80107270:	6a 4b                	push   $0x4b
80107272:	e9 00 f7 ff ff       	jmp    80106977 <alltraps>

80107277 <vector76>:
80107277:	6a 00                	push   $0x0
80107279:	6a 4c                	push   $0x4c
8010727b:	e9 f7 f6 ff ff       	jmp    80106977 <alltraps>

80107280 <vector77>:
80107280:	6a 00                	push   $0x0
80107282:	6a 4d                	push   $0x4d
80107284:	e9 ee f6 ff ff       	jmp    80106977 <alltraps>

80107289 <vector78>:
80107289:	6a 00                	push   $0x0
8010728b:	6a 4e                	push   $0x4e
8010728d:	e9 e5 f6 ff ff       	jmp    80106977 <alltraps>

80107292 <vector79>:
80107292:	6a 00                	push   $0x0
80107294:	6a 4f                	push   $0x4f
80107296:	e9 dc f6 ff ff       	jmp    80106977 <alltraps>

8010729b <vector80>:
8010729b:	6a 00                	push   $0x0
8010729d:	6a 50                	push   $0x50
8010729f:	e9 d3 f6 ff ff       	jmp    80106977 <alltraps>

801072a4 <vector81>:
801072a4:	6a 00                	push   $0x0
801072a6:	6a 51                	push   $0x51
801072a8:	e9 ca f6 ff ff       	jmp    80106977 <alltraps>

801072ad <vector82>:
801072ad:	6a 00                	push   $0x0
801072af:	6a 52                	push   $0x52
801072b1:	e9 c1 f6 ff ff       	jmp    80106977 <alltraps>

801072b6 <vector83>:
801072b6:	6a 00                	push   $0x0
801072b8:	6a 53                	push   $0x53
801072ba:	e9 b8 f6 ff ff       	jmp    80106977 <alltraps>

801072bf <vector84>:
801072bf:	6a 00                	push   $0x0
801072c1:	6a 54                	push   $0x54
801072c3:	e9 af f6 ff ff       	jmp    80106977 <alltraps>

801072c8 <vector85>:
801072c8:	6a 00                	push   $0x0
801072ca:	6a 55                	push   $0x55
801072cc:	e9 a6 f6 ff ff       	jmp    80106977 <alltraps>

801072d1 <vector86>:
801072d1:	6a 00                	push   $0x0
801072d3:	6a 56                	push   $0x56
801072d5:	e9 9d f6 ff ff       	jmp    80106977 <alltraps>

801072da <vector87>:
801072da:	6a 00                	push   $0x0
801072dc:	6a 57                	push   $0x57
801072de:	e9 94 f6 ff ff       	jmp    80106977 <alltraps>

801072e3 <vector88>:
801072e3:	6a 00                	push   $0x0
801072e5:	6a 58                	push   $0x58
801072e7:	e9 8b f6 ff ff       	jmp    80106977 <alltraps>

801072ec <vector89>:
801072ec:	6a 00                	push   $0x0
801072ee:	6a 59                	push   $0x59
801072f0:	e9 82 f6 ff ff       	jmp    80106977 <alltraps>

801072f5 <vector90>:
801072f5:	6a 00                	push   $0x0
801072f7:	6a 5a                	push   $0x5a
801072f9:	e9 79 f6 ff ff       	jmp    80106977 <alltraps>

801072fe <vector91>:
801072fe:	6a 00                	push   $0x0
80107300:	6a 5b                	push   $0x5b
80107302:	e9 70 f6 ff ff       	jmp    80106977 <alltraps>

80107307 <vector92>:
80107307:	6a 00                	push   $0x0
80107309:	6a 5c                	push   $0x5c
8010730b:	e9 67 f6 ff ff       	jmp    80106977 <alltraps>

80107310 <vector93>:
80107310:	6a 00                	push   $0x0
80107312:	6a 5d                	push   $0x5d
80107314:	e9 5e f6 ff ff       	jmp    80106977 <alltraps>

80107319 <vector94>:
80107319:	6a 00                	push   $0x0
8010731b:	6a 5e                	push   $0x5e
8010731d:	e9 55 f6 ff ff       	jmp    80106977 <alltraps>

80107322 <vector95>:
80107322:	6a 00                	push   $0x0
80107324:	6a 5f                	push   $0x5f
80107326:	e9 4c f6 ff ff       	jmp    80106977 <alltraps>

8010732b <vector96>:
8010732b:	6a 00                	push   $0x0
8010732d:	6a 60                	push   $0x60
8010732f:	e9 43 f6 ff ff       	jmp    80106977 <alltraps>

80107334 <vector97>:
80107334:	6a 00                	push   $0x0
80107336:	6a 61                	push   $0x61
80107338:	e9 3a f6 ff ff       	jmp    80106977 <alltraps>

8010733d <vector98>:
8010733d:	6a 00                	push   $0x0
8010733f:	6a 62                	push   $0x62
80107341:	e9 31 f6 ff ff       	jmp    80106977 <alltraps>

80107346 <vector99>:
80107346:	6a 00                	push   $0x0
80107348:	6a 63                	push   $0x63
8010734a:	e9 28 f6 ff ff       	jmp    80106977 <alltraps>

8010734f <vector100>:
8010734f:	6a 00                	push   $0x0
80107351:	6a 64                	push   $0x64
80107353:	e9 1f f6 ff ff       	jmp    80106977 <alltraps>

80107358 <vector101>:
80107358:	6a 00                	push   $0x0
8010735a:	6a 65                	push   $0x65
8010735c:	e9 16 f6 ff ff       	jmp    80106977 <alltraps>

80107361 <vector102>:
80107361:	6a 00                	push   $0x0
80107363:	6a 66                	push   $0x66
80107365:	e9 0d f6 ff ff       	jmp    80106977 <alltraps>

8010736a <vector103>:
8010736a:	6a 00                	push   $0x0
8010736c:	6a 67                	push   $0x67
8010736e:	e9 04 f6 ff ff       	jmp    80106977 <alltraps>

80107373 <vector104>:
80107373:	6a 00                	push   $0x0
80107375:	6a 68                	push   $0x68
80107377:	e9 fb f5 ff ff       	jmp    80106977 <alltraps>

8010737c <vector105>:
8010737c:	6a 00                	push   $0x0
8010737e:	6a 69                	push   $0x69
80107380:	e9 f2 f5 ff ff       	jmp    80106977 <alltraps>

80107385 <vector106>:
80107385:	6a 00                	push   $0x0
80107387:	6a 6a                	push   $0x6a
80107389:	e9 e9 f5 ff ff       	jmp    80106977 <alltraps>

8010738e <vector107>:
8010738e:	6a 00                	push   $0x0
80107390:	6a 6b                	push   $0x6b
80107392:	e9 e0 f5 ff ff       	jmp    80106977 <alltraps>

80107397 <vector108>:
80107397:	6a 00                	push   $0x0
80107399:	6a 6c                	push   $0x6c
8010739b:	e9 d7 f5 ff ff       	jmp    80106977 <alltraps>

801073a0 <vector109>:
801073a0:	6a 00                	push   $0x0
801073a2:	6a 6d                	push   $0x6d
801073a4:	e9 ce f5 ff ff       	jmp    80106977 <alltraps>

801073a9 <vector110>:
801073a9:	6a 00                	push   $0x0
801073ab:	6a 6e                	push   $0x6e
801073ad:	e9 c5 f5 ff ff       	jmp    80106977 <alltraps>

801073b2 <vector111>:
801073b2:	6a 00                	push   $0x0
801073b4:	6a 6f                	push   $0x6f
801073b6:	e9 bc f5 ff ff       	jmp    80106977 <alltraps>

801073bb <vector112>:
801073bb:	6a 00                	push   $0x0
801073bd:	6a 70                	push   $0x70
801073bf:	e9 b3 f5 ff ff       	jmp    80106977 <alltraps>

801073c4 <vector113>:
801073c4:	6a 00                	push   $0x0
801073c6:	6a 71                	push   $0x71
801073c8:	e9 aa f5 ff ff       	jmp    80106977 <alltraps>

801073cd <vector114>:
801073cd:	6a 00                	push   $0x0
801073cf:	6a 72                	push   $0x72
801073d1:	e9 a1 f5 ff ff       	jmp    80106977 <alltraps>

801073d6 <vector115>:
801073d6:	6a 00                	push   $0x0
801073d8:	6a 73                	push   $0x73
801073da:	e9 98 f5 ff ff       	jmp    80106977 <alltraps>

801073df <vector116>:
801073df:	6a 00                	push   $0x0
801073e1:	6a 74                	push   $0x74
801073e3:	e9 8f f5 ff ff       	jmp    80106977 <alltraps>

801073e8 <vector117>:
801073e8:	6a 00                	push   $0x0
801073ea:	6a 75                	push   $0x75
801073ec:	e9 86 f5 ff ff       	jmp    80106977 <alltraps>

801073f1 <vector118>:
801073f1:	6a 00                	push   $0x0
801073f3:	6a 76                	push   $0x76
801073f5:	e9 7d f5 ff ff       	jmp    80106977 <alltraps>

801073fa <vector119>:
801073fa:	6a 00                	push   $0x0
801073fc:	6a 77                	push   $0x77
801073fe:	e9 74 f5 ff ff       	jmp    80106977 <alltraps>

80107403 <vector120>:
80107403:	6a 00                	push   $0x0
80107405:	6a 78                	push   $0x78
80107407:	e9 6b f5 ff ff       	jmp    80106977 <alltraps>

8010740c <vector121>:
8010740c:	6a 00                	push   $0x0
8010740e:	6a 79                	push   $0x79
80107410:	e9 62 f5 ff ff       	jmp    80106977 <alltraps>

80107415 <vector122>:
80107415:	6a 00                	push   $0x0
80107417:	6a 7a                	push   $0x7a
80107419:	e9 59 f5 ff ff       	jmp    80106977 <alltraps>

8010741e <vector123>:
8010741e:	6a 00                	push   $0x0
80107420:	6a 7b                	push   $0x7b
80107422:	e9 50 f5 ff ff       	jmp    80106977 <alltraps>

80107427 <vector124>:
80107427:	6a 00                	push   $0x0
80107429:	6a 7c                	push   $0x7c
8010742b:	e9 47 f5 ff ff       	jmp    80106977 <alltraps>

80107430 <vector125>:
80107430:	6a 00                	push   $0x0
80107432:	6a 7d                	push   $0x7d
80107434:	e9 3e f5 ff ff       	jmp    80106977 <alltraps>

80107439 <vector126>:
80107439:	6a 00                	push   $0x0
8010743b:	6a 7e                	push   $0x7e
8010743d:	e9 35 f5 ff ff       	jmp    80106977 <alltraps>

80107442 <vector127>:
80107442:	6a 00                	push   $0x0
80107444:	6a 7f                	push   $0x7f
80107446:	e9 2c f5 ff ff       	jmp    80106977 <alltraps>

8010744b <vector128>:
8010744b:	6a 00                	push   $0x0
8010744d:	68 80 00 00 00       	push   $0x80
80107452:	e9 20 f5 ff ff       	jmp    80106977 <alltraps>

80107457 <vector129>:
80107457:	6a 00                	push   $0x0
80107459:	68 81 00 00 00       	push   $0x81
8010745e:	e9 14 f5 ff ff       	jmp    80106977 <alltraps>

80107463 <vector130>:
80107463:	6a 00                	push   $0x0
80107465:	68 82 00 00 00       	push   $0x82
8010746a:	e9 08 f5 ff ff       	jmp    80106977 <alltraps>

8010746f <vector131>:
8010746f:	6a 00                	push   $0x0
80107471:	68 83 00 00 00       	push   $0x83
80107476:	e9 fc f4 ff ff       	jmp    80106977 <alltraps>

8010747b <vector132>:
8010747b:	6a 00                	push   $0x0
8010747d:	68 84 00 00 00       	push   $0x84
80107482:	e9 f0 f4 ff ff       	jmp    80106977 <alltraps>

80107487 <vector133>:
80107487:	6a 00                	push   $0x0
80107489:	68 85 00 00 00       	push   $0x85
8010748e:	e9 e4 f4 ff ff       	jmp    80106977 <alltraps>

80107493 <vector134>:
80107493:	6a 00                	push   $0x0
80107495:	68 86 00 00 00       	push   $0x86
8010749a:	e9 d8 f4 ff ff       	jmp    80106977 <alltraps>

8010749f <vector135>:
8010749f:	6a 00                	push   $0x0
801074a1:	68 87 00 00 00       	push   $0x87
801074a6:	e9 cc f4 ff ff       	jmp    80106977 <alltraps>

801074ab <vector136>:
801074ab:	6a 00                	push   $0x0
801074ad:	68 88 00 00 00       	push   $0x88
801074b2:	e9 c0 f4 ff ff       	jmp    80106977 <alltraps>

801074b7 <vector137>:
801074b7:	6a 00                	push   $0x0
801074b9:	68 89 00 00 00       	push   $0x89
801074be:	e9 b4 f4 ff ff       	jmp    80106977 <alltraps>

801074c3 <vector138>:
801074c3:	6a 00                	push   $0x0
801074c5:	68 8a 00 00 00       	push   $0x8a
801074ca:	e9 a8 f4 ff ff       	jmp    80106977 <alltraps>

801074cf <vector139>:
801074cf:	6a 00                	push   $0x0
801074d1:	68 8b 00 00 00       	push   $0x8b
801074d6:	e9 9c f4 ff ff       	jmp    80106977 <alltraps>

801074db <vector140>:
801074db:	6a 00                	push   $0x0
801074dd:	68 8c 00 00 00       	push   $0x8c
801074e2:	e9 90 f4 ff ff       	jmp    80106977 <alltraps>

801074e7 <vector141>:
801074e7:	6a 00                	push   $0x0
801074e9:	68 8d 00 00 00       	push   $0x8d
801074ee:	e9 84 f4 ff ff       	jmp    80106977 <alltraps>

801074f3 <vector142>:
801074f3:	6a 00                	push   $0x0
801074f5:	68 8e 00 00 00       	push   $0x8e
801074fa:	e9 78 f4 ff ff       	jmp    80106977 <alltraps>

801074ff <vector143>:
801074ff:	6a 00                	push   $0x0
80107501:	68 8f 00 00 00       	push   $0x8f
80107506:	e9 6c f4 ff ff       	jmp    80106977 <alltraps>

8010750b <vector144>:
8010750b:	6a 00                	push   $0x0
8010750d:	68 90 00 00 00       	push   $0x90
80107512:	e9 60 f4 ff ff       	jmp    80106977 <alltraps>

80107517 <vector145>:
80107517:	6a 00                	push   $0x0
80107519:	68 91 00 00 00       	push   $0x91
8010751e:	e9 54 f4 ff ff       	jmp    80106977 <alltraps>

80107523 <vector146>:
80107523:	6a 00                	push   $0x0
80107525:	68 92 00 00 00       	push   $0x92
8010752a:	e9 48 f4 ff ff       	jmp    80106977 <alltraps>

8010752f <vector147>:
8010752f:	6a 00                	push   $0x0
80107531:	68 93 00 00 00       	push   $0x93
80107536:	e9 3c f4 ff ff       	jmp    80106977 <alltraps>

8010753b <vector148>:
8010753b:	6a 00                	push   $0x0
8010753d:	68 94 00 00 00       	push   $0x94
80107542:	e9 30 f4 ff ff       	jmp    80106977 <alltraps>

80107547 <vector149>:
80107547:	6a 00                	push   $0x0
80107549:	68 95 00 00 00       	push   $0x95
8010754e:	e9 24 f4 ff ff       	jmp    80106977 <alltraps>

80107553 <vector150>:
80107553:	6a 00                	push   $0x0
80107555:	68 96 00 00 00       	push   $0x96
8010755a:	e9 18 f4 ff ff       	jmp    80106977 <alltraps>

8010755f <vector151>:
8010755f:	6a 00                	push   $0x0
80107561:	68 97 00 00 00       	push   $0x97
80107566:	e9 0c f4 ff ff       	jmp    80106977 <alltraps>

8010756b <vector152>:
8010756b:	6a 00                	push   $0x0
8010756d:	68 98 00 00 00       	push   $0x98
80107572:	e9 00 f4 ff ff       	jmp    80106977 <alltraps>

80107577 <vector153>:
80107577:	6a 00                	push   $0x0
80107579:	68 99 00 00 00       	push   $0x99
8010757e:	e9 f4 f3 ff ff       	jmp    80106977 <alltraps>

80107583 <vector154>:
80107583:	6a 00                	push   $0x0
80107585:	68 9a 00 00 00       	push   $0x9a
8010758a:	e9 e8 f3 ff ff       	jmp    80106977 <alltraps>

8010758f <vector155>:
8010758f:	6a 00                	push   $0x0
80107591:	68 9b 00 00 00       	push   $0x9b
80107596:	e9 dc f3 ff ff       	jmp    80106977 <alltraps>

8010759b <vector156>:
8010759b:	6a 00                	push   $0x0
8010759d:	68 9c 00 00 00       	push   $0x9c
801075a2:	e9 d0 f3 ff ff       	jmp    80106977 <alltraps>

801075a7 <vector157>:
801075a7:	6a 00                	push   $0x0
801075a9:	68 9d 00 00 00       	push   $0x9d
801075ae:	e9 c4 f3 ff ff       	jmp    80106977 <alltraps>

801075b3 <vector158>:
801075b3:	6a 00                	push   $0x0
801075b5:	68 9e 00 00 00       	push   $0x9e
801075ba:	e9 b8 f3 ff ff       	jmp    80106977 <alltraps>

801075bf <vector159>:
801075bf:	6a 00                	push   $0x0
801075c1:	68 9f 00 00 00       	push   $0x9f
801075c6:	e9 ac f3 ff ff       	jmp    80106977 <alltraps>

801075cb <vector160>:
801075cb:	6a 00                	push   $0x0
801075cd:	68 a0 00 00 00       	push   $0xa0
801075d2:	e9 a0 f3 ff ff       	jmp    80106977 <alltraps>

801075d7 <vector161>:
801075d7:	6a 00                	push   $0x0
801075d9:	68 a1 00 00 00       	push   $0xa1
801075de:	e9 94 f3 ff ff       	jmp    80106977 <alltraps>

801075e3 <vector162>:
801075e3:	6a 00                	push   $0x0
801075e5:	68 a2 00 00 00       	push   $0xa2
801075ea:	e9 88 f3 ff ff       	jmp    80106977 <alltraps>

801075ef <vector163>:
801075ef:	6a 00                	push   $0x0
801075f1:	68 a3 00 00 00       	push   $0xa3
801075f6:	e9 7c f3 ff ff       	jmp    80106977 <alltraps>

801075fb <vector164>:
801075fb:	6a 00                	push   $0x0
801075fd:	68 a4 00 00 00       	push   $0xa4
80107602:	e9 70 f3 ff ff       	jmp    80106977 <alltraps>

80107607 <vector165>:
80107607:	6a 00                	push   $0x0
80107609:	68 a5 00 00 00       	push   $0xa5
8010760e:	e9 64 f3 ff ff       	jmp    80106977 <alltraps>

80107613 <vector166>:
80107613:	6a 00                	push   $0x0
80107615:	68 a6 00 00 00       	push   $0xa6
8010761a:	e9 58 f3 ff ff       	jmp    80106977 <alltraps>

8010761f <vector167>:
8010761f:	6a 00                	push   $0x0
80107621:	68 a7 00 00 00       	push   $0xa7
80107626:	e9 4c f3 ff ff       	jmp    80106977 <alltraps>

8010762b <vector168>:
8010762b:	6a 00                	push   $0x0
8010762d:	68 a8 00 00 00       	push   $0xa8
80107632:	e9 40 f3 ff ff       	jmp    80106977 <alltraps>

80107637 <vector169>:
80107637:	6a 00                	push   $0x0
80107639:	68 a9 00 00 00       	push   $0xa9
8010763e:	e9 34 f3 ff ff       	jmp    80106977 <alltraps>

80107643 <vector170>:
80107643:	6a 00                	push   $0x0
80107645:	68 aa 00 00 00       	push   $0xaa
8010764a:	e9 28 f3 ff ff       	jmp    80106977 <alltraps>

8010764f <vector171>:
8010764f:	6a 00                	push   $0x0
80107651:	68 ab 00 00 00       	push   $0xab
80107656:	e9 1c f3 ff ff       	jmp    80106977 <alltraps>

8010765b <vector172>:
8010765b:	6a 00                	push   $0x0
8010765d:	68 ac 00 00 00       	push   $0xac
80107662:	e9 10 f3 ff ff       	jmp    80106977 <alltraps>

80107667 <vector173>:
80107667:	6a 00                	push   $0x0
80107669:	68 ad 00 00 00       	push   $0xad
8010766e:	e9 04 f3 ff ff       	jmp    80106977 <alltraps>

80107673 <vector174>:
80107673:	6a 00                	push   $0x0
80107675:	68 ae 00 00 00       	push   $0xae
8010767a:	e9 f8 f2 ff ff       	jmp    80106977 <alltraps>

8010767f <vector175>:
8010767f:	6a 00                	push   $0x0
80107681:	68 af 00 00 00       	push   $0xaf
80107686:	e9 ec f2 ff ff       	jmp    80106977 <alltraps>

8010768b <vector176>:
8010768b:	6a 00                	push   $0x0
8010768d:	68 b0 00 00 00       	push   $0xb0
80107692:	e9 e0 f2 ff ff       	jmp    80106977 <alltraps>

80107697 <vector177>:
80107697:	6a 00                	push   $0x0
80107699:	68 b1 00 00 00       	push   $0xb1
8010769e:	e9 d4 f2 ff ff       	jmp    80106977 <alltraps>

801076a3 <vector178>:
801076a3:	6a 00                	push   $0x0
801076a5:	68 b2 00 00 00       	push   $0xb2
801076aa:	e9 c8 f2 ff ff       	jmp    80106977 <alltraps>

801076af <vector179>:
801076af:	6a 00                	push   $0x0
801076b1:	68 b3 00 00 00       	push   $0xb3
801076b6:	e9 bc f2 ff ff       	jmp    80106977 <alltraps>

801076bb <vector180>:
801076bb:	6a 00                	push   $0x0
801076bd:	68 b4 00 00 00       	push   $0xb4
801076c2:	e9 b0 f2 ff ff       	jmp    80106977 <alltraps>

801076c7 <vector181>:
801076c7:	6a 00                	push   $0x0
801076c9:	68 b5 00 00 00       	push   $0xb5
801076ce:	e9 a4 f2 ff ff       	jmp    80106977 <alltraps>

801076d3 <vector182>:
801076d3:	6a 00                	push   $0x0
801076d5:	68 b6 00 00 00       	push   $0xb6
801076da:	e9 98 f2 ff ff       	jmp    80106977 <alltraps>

801076df <vector183>:
801076df:	6a 00                	push   $0x0
801076e1:	68 b7 00 00 00       	push   $0xb7
801076e6:	e9 8c f2 ff ff       	jmp    80106977 <alltraps>

801076eb <vector184>:
801076eb:	6a 00                	push   $0x0
801076ed:	68 b8 00 00 00       	push   $0xb8
801076f2:	e9 80 f2 ff ff       	jmp    80106977 <alltraps>

801076f7 <vector185>:
801076f7:	6a 00                	push   $0x0
801076f9:	68 b9 00 00 00       	push   $0xb9
801076fe:	e9 74 f2 ff ff       	jmp    80106977 <alltraps>

80107703 <vector186>:
80107703:	6a 00                	push   $0x0
80107705:	68 ba 00 00 00       	push   $0xba
8010770a:	e9 68 f2 ff ff       	jmp    80106977 <alltraps>

8010770f <vector187>:
8010770f:	6a 00                	push   $0x0
80107711:	68 bb 00 00 00       	push   $0xbb
80107716:	e9 5c f2 ff ff       	jmp    80106977 <alltraps>

8010771b <vector188>:
8010771b:	6a 00                	push   $0x0
8010771d:	68 bc 00 00 00       	push   $0xbc
80107722:	e9 50 f2 ff ff       	jmp    80106977 <alltraps>

80107727 <vector189>:
80107727:	6a 00                	push   $0x0
80107729:	68 bd 00 00 00       	push   $0xbd
8010772e:	e9 44 f2 ff ff       	jmp    80106977 <alltraps>

80107733 <vector190>:
80107733:	6a 00                	push   $0x0
80107735:	68 be 00 00 00       	push   $0xbe
8010773a:	e9 38 f2 ff ff       	jmp    80106977 <alltraps>

8010773f <vector191>:
8010773f:	6a 00                	push   $0x0
80107741:	68 bf 00 00 00       	push   $0xbf
80107746:	e9 2c f2 ff ff       	jmp    80106977 <alltraps>

8010774b <vector192>:
8010774b:	6a 00                	push   $0x0
8010774d:	68 c0 00 00 00       	push   $0xc0
80107752:	e9 20 f2 ff ff       	jmp    80106977 <alltraps>

80107757 <vector193>:
80107757:	6a 00                	push   $0x0
80107759:	68 c1 00 00 00       	push   $0xc1
8010775e:	e9 14 f2 ff ff       	jmp    80106977 <alltraps>

80107763 <vector194>:
80107763:	6a 00                	push   $0x0
80107765:	68 c2 00 00 00       	push   $0xc2
8010776a:	e9 08 f2 ff ff       	jmp    80106977 <alltraps>

8010776f <vector195>:
8010776f:	6a 00                	push   $0x0
80107771:	68 c3 00 00 00       	push   $0xc3
80107776:	e9 fc f1 ff ff       	jmp    80106977 <alltraps>

8010777b <vector196>:
8010777b:	6a 00                	push   $0x0
8010777d:	68 c4 00 00 00       	push   $0xc4
80107782:	e9 f0 f1 ff ff       	jmp    80106977 <alltraps>

80107787 <vector197>:
80107787:	6a 00                	push   $0x0
80107789:	68 c5 00 00 00       	push   $0xc5
8010778e:	e9 e4 f1 ff ff       	jmp    80106977 <alltraps>

80107793 <vector198>:
80107793:	6a 00                	push   $0x0
80107795:	68 c6 00 00 00       	push   $0xc6
8010779a:	e9 d8 f1 ff ff       	jmp    80106977 <alltraps>

8010779f <vector199>:
8010779f:	6a 00                	push   $0x0
801077a1:	68 c7 00 00 00       	push   $0xc7
801077a6:	e9 cc f1 ff ff       	jmp    80106977 <alltraps>

801077ab <vector200>:
801077ab:	6a 00                	push   $0x0
801077ad:	68 c8 00 00 00       	push   $0xc8
801077b2:	e9 c0 f1 ff ff       	jmp    80106977 <alltraps>

801077b7 <vector201>:
801077b7:	6a 00                	push   $0x0
801077b9:	68 c9 00 00 00       	push   $0xc9
801077be:	e9 b4 f1 ff ff       	jmp    80106977 <alltraps>

801077c3 <vector202>:
801077c3:	6a 00                	push   $0x0
801077c5:	68 ca 00 00 00       	push   $0xca
801077ca:	e9 a8 f1 ff ff       	jmp    80106977 <alltraps>

801077cf <vector203>:
801077cf:	6a 00                	push   $0x0
801077d1:	68 cb 00 00 00       	push   $0xcb
801077d6:	e9 9c f1 ff ff       	jmp    80106977 <alltraps>

801077db <vector204>:
801077db:	6a 00                	push   $0x0
801077dd:	68 cc 00 00 00       	push   $0xcc
801077e2:	e9 90 f1 ff ff       	jmp    80106977 <alltraps>

801077e7 <vector205>:
801077e7:	6a 00                	push   $0x0
801077e9:	68 cd 00 00 00       	push   $0xcd
801077ee:	e9 84 f1 ff ff       	jmp    80106977 <alltraps>

801077f3 <vector206>:
801077f3:	6a 00                	push   $0x0
801077f5:	68 ce 00 00 00       	push   $0xce
801077fa:	e9 78 f1 ff ff       	jmp    80106977 <alltraps>

801077ff <vector207>:
801077ff:	6a 00                	push   $0x0
80107801:	68 cf 00 00 00       	push   $0xcf
80107806:	e9 6c f1 ff ff       	jmp    80106977 <alltraps>

8010780b <vector208>:
8010780b:	6a 00                	push   $0x0
8010780d:	68 d0 00 00 00       	push   $0xd0
80107812:	e9 60 f1 ff ff       	jmp    80106977 <alltraps>

80107817 <vector209>:
80107817:	6a 00                	push   $0x0
80107819:	68 d1 00 00 00       	push   $0xd1
8010781e:	e9 54 f1 ff ff       	jmp    80106977 <alltraps>

80107823 <vector210>:
80107823:	6a 00                	push   $0x0
80107825:	68 d2 00 00 00       	push   $0xd2
8010782a:	e9 48 f1 ff ff       	jmp    80106977 <alltraps>

8010782f <vector211>:
8010782f:	6a 00                	push   $0x0
80107831:	68 d3 00 00 00       	push   $0xd3
80107836:	e9 3c f1 ff ff       	jmp    80106977 <alltraps>

8010783b <vector212>:
8010783b:	6a 00                	push   $0x0
8010783d:	68 d4 00 00 00       	push   $0xd4
80107842:	e9 30 f1 ff ff       	jmp    80106977 <alltraps>

80107847 <vector213>:
80107847:	6a 00                	push   $0x0
80107849:	68 d5 00 00 00       	push   $0xd5
8010784e:	e9 24 f1 ff ff       	jmp    80106977 <alltraps>

80107853 <vector214>:
80107853:	6a 00                	push   $0x0
80107855:	68 d6 00 00 00       	push   $0xd6
8010785a:	e9 18 f1 ff ff       	jmp    80106977 <alltraps>

8010785f <vector215>:
8010785f:	6a 00                	push   $0x0
80107861:	68 d7 00 00 00       	push   $0xd7
80107866:	e9 0c f1 ff ff       	jmp    80106977 <alltraps>

8010786b <vector216>:
8010786b:	6a 00                	push   $0x0
8010786d:	68 d8 00 00 00       	push   $0xd8
80107872:	e9 00 f1 ff ff       	jmp    80106977 <alltraps>

80107877 <vector217>:
80107877:	6a 00                	push   $0x0
80107879:	68 d9 00 00 00       	push   $0xd9
8010787e:	e9 f4 f0 ff ff       	jmp    80106977 <alltraps>

80107883 <vector218>:
80107883:	6a 00                	push   $0x0
80107885:	68 da 00 00 00       	push   $0xda
8010788a:	e9 e8 f0 ff ff       	jmp    80106977 <alltraps>

8010788f <vector219>:
8010788f:	6a 00                	push   $0x0
80107891:	68 db 00 00 00       	push   $0xdb
80107896:	e9 dc f0 ff ff       	jmp    80106977 <alltraps>

8010789b <vector220>:
8010789b:	6a 00                	push   $0x0
8010789d:	68 dc 00 00 00       	push   $0xdc
801078a2:	e9 d0 f0 ff ff       	jmp    80106977 <alltraps>

801078a7 <vector221>:
801078a7:	6a 00                	push   $0x0
801078a9:	68 dd 00 00 00       	push   $0xdd
801078ae:	e9 c4 f0 ff ff       	jmp    80106977 <alltraps>

801078b3 <vector222>:
801078b3:	6a 00                	push   $0x0
801078b5:	68 de 00 00 00       	push   $0xde
801078ba:	e9 b8 f0 ff ff       	jmp    80106977 <alltraps>

801078bf <vector223>:
801078bf:	6a 00                	push   $0x0
801078c1:	68 df 00 00 00       	push   $0xdf
801078c6:	e9 ac f0 ff ff       	jmp    80106977 <alltraps>

801078cb <vector224>:
801078cb:	6a 00                	push   $0x0
801078cd:	68 e0 00 00 00       	push   $0xe0
801078d2:	e9 a0 f0 ff ff       	jmp    80106977 <alltraps>

801078d7 <vector225>:
801078d7:	6a 00                	push   $0x0
801078d9:	68 e1 00 00 00       	push   $0xe1
801078de:	e9 94 f0 ff ff       	jmp    80106977 <alltraps>

801078e3 <vector226>:
801078e3:	6a 00                	push   $0x0
801078e5:	68 e2 00 00 00       	push   $0xe2
801078ea:	e9 88 f0 ff ff       	jmp    80106977 <alltraps>

801078ef <vector227>:
801078ef:	6a 00                	push   $0x0
801078f1:	68 e3 00 00 00       	push   $0xe3
801078f6:	e9 7c f0 ff ff       	jmp    80106977 <alltraps>

801078fb <vector228>:
801078fb:	6a 00                	push   $0x0
801078fd:	68 e4 00 00 00       	push   $0xe4
80107902:	e9 70 f0 ff ff       	jmp    80106977 <alltraps>

80107907 <vector229>:
80107907:	6a 00                	push   $0x0
80107909:	68 e5 00 00 00       	push   $0xe5
8010790e:	e9 64 f0 ff ff       	jmp    80106977 <alltraps>

80107913 <vector230>:
80107913:	6a 00                	push   $0x0
80107915:	68 e6 00 00 00       	push   $0xe6
8010791a:	e9 58 f0 ff ff       	jmp    80106977 <alltraps>

8010791f <vector231>:
8010791f:	6a 00                	push   $0x0
80107921:	68 e7 00 00 00       	push   $0xe7
80107926:	e9 4c f0 ff ff       	jmp    80106977 <alltraps>

8010792b <vector232>:
8010792b:	6a 00                	push   $0x0
8010792d:	68 e8 00 00 00       	push   $0xe8
80107932:	e9 40 f0 ff ff       	jmp    80106977 <alltraps>

80107937 <vector233>:
80107937:	6a 00                	push   $0x0
80107939:	68 e9 00 00 00       	push   $0xe9
8010793e:	e9 34 f0 ff ff       	jmp    80106977 <alltraps>

80107943 <vector234>:
80107943:	6a 00                	push   $0x0
80107945:	68 ea 00 00 00       	push   $0xea
8010794a:	e9 28 f0 ff ff       	jmp    80106977 <alltraps>

8010794f <vector235>:
8010794f:	6a 00                	push   $0x0
80107951:	68 eb 00 00 00       	push   $0xeb
80107956:	e9 1c f0 ff ff       	jmp    80106977 <alltraps>

8010795b <vector236>:
8010795b:	6a 00                	push   $0x0
8010795d:	68 ec 00 00 00       	push   $0xec
80107962:	e9 10 f0 ff ff       	jmp    80106977 <alltraps>

80107967 <vector237>:
80107967:	6a 00                	push   $0x0
80107969:	68 ed 00 00 00       	push   $0xed
8010796e:	e9 04 f0 ff ff       	jmp    80106977 <alltraps>

80107973 <vector238>:
80107973:	6a 00                	push   $0x0
80107975:	68 ee 00 00 00       	push   $0xee
8010797a:	e9 f8 ef ff ff       	jmp    80106977 <alltraps>

8010797f <vector239>:
8010797f:	6a 00                	push   $0x0
80107981:	68 ef 00 00 00       	push   $0xef
80107986:	e9 ec ef ff ff       	jmp    80106977 <alltraps>

8010798b <vector240>:
8010798b:	6a 00                	push   $0x0
8010798d:	68 f0 00 00 00       	push   $0xf0
80107992:	e9 e0 ef ff ff       	jmp    80106977 <alltraps>

80107997 <vector241>:
80107997:	6a 00                	push   $0x0
80107999:	68 f1 00 00 00       	push   $0xf1
8010799e:	e9 d4 ef ff ff       	jmp    80106977 <alltraps>

801079a3 <vector242>:
801079a3:	6a 00                	push   $0x0
801079a5:	68 f2 00 00 00       	push   $0xf2
801079aa:	e9 c8 ef ff ff       	jmp    80106977 <alltraps>

801079af <vector243>:
801079af:	6a 00                	push   $0x0
801079b1:	68 f3 00 00 00       	push   $0xf3
801079b6:	e9 bc ef ff ff       	jmp    80106977 <alltraps>

801079bb <vector244>:
801079bb:	6a 00                	push   $0x0
801079bd:	68 f4 00 00 00       	push   $0xf4
801079c2:	e9 b0 ef ff ff       	jmp    80106977 <alltraps>

801079c7 <vector245>:
801079c7:	6a 00                	push   $0x0
801079c9:	68 f5 00 00 00       	push   $0xf5
801079ce:	e9 a4 ef ff ff       	jmp    80106977 <alltraps>

801079d3 <vector246>:
801079d3:	6a 00                	push   $0x0
801079d5:	68 f6 00 00 00       	push   $0xf6
801079da:	e9 98 ef ff ff       	jmp    80106977 <alltraps>

801079df <vector247>:
801079df:	6a 00                	push   $0x0
801079e1:	68 f7 00 00 00       	push   $0xf7
801079e6:	e9 8c ef ff ff       	jmp    80106977 <alltraps>

801079eb <vector248>:
801079eb:	6a 00                	push   $0x0
801079ed:	68 f8 00 00 00       	push   $0xf8
801079f2:	e9 80 ef ff ff       	jmp    80106977 <alltraps>

801079f7 <vector249>:
801079f7:	6a 00                	push   $0x0
801079f9:	68 f9 00 00 00       	push   $0xf9
801079fe:	e9 74 ef ff ff       	jmp    80106977 <alltraps>

80107a03 <vector250>:
80107a03:	6a 00                	push   $0x0
80107a05:	68 fa 00 00 00       	push   $0xfa
80107a0a:	e9 68 ef ff ff       	jmp    80106977 <alltraps>

80107a0f <vector251>:
80107a0f:	6a 00                	push   $0x0
80107a11:	68 fb 00 00 00       	push   $0xfb
80107a16:	e9 5c ef ff ff       	jmp    80106977 <alltraps>

80107a1b <vector252>:
80107a1b:	6a 00                	push   $0x0
80107a1d:	68 fc 00 00 00       	push   $0xfc
80107a22:	e9 50 ef ff ff       	jmp    80106977 <alltraps>

80107a27 <vector253>:
80107a27:	6a 00                	push   $0x0
80107a29:	68 fd 00 00 00       	push   $0xfd
80107a2e:	e9 44 ef ff ff       	jmp    80106977 <alltraps>

80107a33 <vector254>:
80107a33:	6a 00                	push   $0x0
80107a35:	68 fe 00 00 00       	push   $0xfe
80107a3a:	e9 38 ef ff ff       	jmp    80106977 <alltraps>

80107a3f <vector255>:
80107a3f:	6a 00                	push   $0x0
80107a41:	68 ff 00 00 00       	push   $0xff
80107a46:	e9 2c ef ff ff       	jmp    80106977 <alltraps>

80107a4b <lgdt>:

struct segdesc;

static inline void
lgdt(struct segdesc *p, int size)
{
80107a4b:	55                   	push   %ebp
80107a4c:	89 e5                	mov    %esp,%ebp
80107a4e:	83 ec 10             	sub    $0x10,%esp
  volatile ushort pd[3];

  pd[0] = size-1;
80107a51:	8b 45 0c             	mov    0xc(%ebp),%eax
80107a54:	83 e8 01             	sub    $0x1,%eax
80107a57:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80107a5b:	8b 45 08             	mov    0x8(%ebp),%eax
80107a5e:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80107a62:	8b 45 08             	mov    0x8(%ebp),%eax
80107a65:	c1 e8 10             	shr    $0x10,%eax
80107a68:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lgdt (%0)" : : "r" (pd));
80107a6c:	8d 45 fa             	lea    -0x6(%ebp),%eax
80107a6f:	0f 01 10             	lgdtl  (%eax)
}
80107a72:	90                   	nop
80107a73:	c9                   	leave  
80107a74:	c3                   	ret    

80107a75 <ltr>:
  asm volatile("lidt (%0)" : : "r" (pd));
}

static inline void
ltr(ushort sel)
{
80107a75:	55                   	push   %ebp
80107a76:	89 e5                	mov    %esp,%ebp
80107a78:	83 ec 04             	sub    $0x4,%esp
80107a7b:	8b 45 08             	mov    0x8(%ebp),%eax
80107a7e:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  asm volatile("ltr %0" : : "r" (sel));
80107a82:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80107a86:	0f 00 d8             	ltr    %ax
}
80107a89:	90                   	nop
80107a8a:	c9                   	leave  
80107a8b:	c3                   	ret    

80107a8c <loadgs>:
  return eflags;
}

static inline void
loadgs(ushort v)
{
80107a8c:	55                   	push   %ebp
80107a8d:	89 e5                	mov    %esp,%ebp
80107a8f:	83 ec 04             	sub    $0x4,%esp
80107a92:	8b 45 08             	mov    0x8(%ebp),%eax
80107a95:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  asm volatile("movw %0, %%gs" : : "r" (v));
80107a99:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80107a9d:	8e e8                	mov    %eax,%gs
}
80107a9f:	90                   	nop
80107aa0:	c9                   	leave  
80107aa1:	c3                   	ret    

80107aa2 <lcr3>:
  return val;
}

static inline void
lcr3(uint val) 
{
80107aa2:	55                   	push   %ebp
80107aa3:	89 e5                	mov    %esp,%ebp
  asm volatile("movl %0,%%cr3" : : "r" (val));
80107aa5:	8b 45 08             	mov    0x8(%ebp),%eax
80107aa8:	0f 22 d8             	mov    %eax,%cr3
}
80107aab:	90                   	nop
80107aac:	5d                   	pop    %ebp
80107aad:	c3                   	ret    

80107aae <v2p>:
#define KERNBASE 0x80000000         // First kernel virtual address
#define KERNLINK (KERNBASE+EXTMEM)  // Address where kernel is linked

#ifndef __ASSEMBLER__

static inline uint v2p(void *a) { return ((uint) (a))  - KERNBASE; }
80107aae:	55                   	push   %ebp
80107aaf:	89 e5                	mov    %esp,%ebp
80107ab1:	8b 45 08             	mov    0x8(%ebp),%eax
80107ab4:	05 00 00 00 80       	add    $0x80000000,%eax
80107ab9:	5d                   	pop    %ebp
80107aba:	c3                   	ret    

80107abb <p2v>:
static inline void *p2v(uint a) { return (void *) ((a) + KERNBASE); }
80107abb:	55                   	push   %ebp
80107abc:	89 e5                	mov    %esp,%ebp
80107abe:	8b 45 08             	mov    0x8(%ebp),%eax
80107ac1:	05 00 00 00 80       	add    $0x80000000,%eax
80107ac6:	5d                   	pop    %ebp
80107ac7:	c3                   	ret    

80107ac8 <seginit>:

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
80107ac8:	55                   	push   %ebp
80107ac9:	89 e5                	mov    %esp,%ebp
80107acb:	53                   	push   %ebx
80107acc:	83 ec 14             	sub    $0x14,%esp

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
80107acf:	e8 c9 b4 ff ff       	call   80102f9d <cpunum>
80107ad4:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80107ada:	05 00 38 11 80       	add    $0x80113800,%eax
80107adf:	89 45 f4             	mov    %eax,-0xc(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80107ae2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ae5:	66 c7 40 78 ff ff    	movw   $0xffff,0x78(%eax)
80107aeb:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107aee:	66 c7 40 7a 00 00    	movw   $0x0,0x7a(%eax)
80107af4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107af7:	c6 40 7c 00          	movb   $0x0,0x7c(%eax)
80107afb:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107afe:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
80107b02:	83 e2 f0             	and    $0xfffffff0,%edx
80107b05:	83 ca 0a             	or     $0xa,%edx
80107b08:	88 50 7d             	mov    %dl,0x7d(%eax)
80107b0b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b0e:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
80107b12:	83 ca 10             	or     $0x10,%edx
80107b15:	88 50 7d             	mov    %dl,0x7d(%eax)
80107b18:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b1b:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
80107b1f:	83 e2 9f             	and    $0xffffff9f,%edx
80107b22:	88 50 7d             	mov    %dl,0x7d(%eax)
80107b25:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b28:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
80107b2c:	83 ca 80             	or     $0xffffff80,%edx
80107b2f:	88 50 7d             	mov    %dl,0x7d(%eax)
80107b32:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b35:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80107b39:	83 ca 0f             	or     $0xf,%edx
80107b3c:	88 50 7e             	mov    %dl,0x7e(%eax)
80107b3f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b42:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80107b46:	83 e2 ef             	and    $0xffffffef,%edx
80107b49:	88 50 7e             	mov    %dl,0x7e(%eax)
80107b4c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b4f:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80107b53:	83 e2 df             	and    $0xffffffdf,%edx
80107b56:	88 50 7e             	mov    %dl,0x7e(%eax)
80107b59:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b5c:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80107b60:	83 ca 40             	or     $0x40,%edx
80107b63:	88 50 7e             	mov    %dl,0x7e(%eax)
80107b66:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b69:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80107b6d:	83 ca 80             	or     $0xffffff80,%edx
80107b70:	88 50 7e             	mov    %dl,0x7e(%eax)
80107b73:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b76:	c6 40 7f 00          	movb   $0x0,0x7f(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80107b7a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b7d:	66 c7 80 80 00 00 00 	movw   $0xffff,0x80(%eax)
80107b84:	ff ff 
80107b86:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b89:	66 c7 80 82 00 00 00 	movw   $0x0,0x82(%eax)
80107b90:	00 00 
80107b92:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b95:	c6 80 84 00 00 00 00 	movb   $0x0,0x84(%eax)
80107b9c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b9f:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
80107ba6:	83 e2 f0             	and    $0xfffffff0,%edx
80107ba9:	83 ca 02             	or     $0x2,%edx
80107bac:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
80107bb2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bb5:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
80107bbc:	83 ca 10             	or     $0x10,%edx
80107bbf:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
80107bc5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bc8:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
80107bcf:	83 e2 9f             	and    $0xffffff9f,%edx
80107bd2:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
80107bd8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bdb:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
80107be2:	83 ca 80             	or     $0xffffff80,%edx
80107be5:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
80107beb:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bee:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80107bf5:	83 ca 0f             	or     $0xf,%edx
80107bf8:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107bfe:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c01:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80107c08:	83 e2 ef             	and    $0xffffffef,%edx
80107c0b:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107c11:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c14:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80107c1b:	83 e2 df             	and    $0xffffffdf,%edx
80107c1e:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107c24:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c27:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80107c2e:	83 ca 40             	or     $0x40,%edx
80107c31:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107c37:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c3a:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80107c41:	83 ca 80             	or     $0xffffff80,%edx
80107c44:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107c4a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c4d:	c6 80 87 00 00 00 00 	movb   $0x0,0x87(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80107c54:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c57:	66 c7 80 90 00 00 00 	movw   $0xffff,0x90(%eax)
80107c5e:	ff ff 
80107c60:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c63:	66 c7 80 92 00 00 00 	movw   $0x0,0x92(%eax)
80107c6a:	00 00 
80107c6c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c6f:	c6 80 94 00 00 00 00 	movb   $0x0,0x94(%eax)
80107c76:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c79:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80107c80:	83 e2 f0             	and    $0xfffffff0,%edx
80107c83:	83 ca 0a             	or     $0xa,%edx
80107c86:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80107c8c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c8f:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80107c96:	83 ca 10             	or     $0x10,%edx
80107c99:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80107c9f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ca2:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80107ca9:	83 ca 60             	or     $0x60,%edx
80107cac:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80107cb2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107cb5:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80107cbc:	83 ca 80             	or     $0xffffff80,%edx
80107cbf:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80107cc5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107cc8:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107ccf:	83 ca 0f             	or     $0xf,%edx
80107cd2:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107cd8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107cdb:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107ce2:	83 e2 ef             	and    $0xffffffef,%edx
80107ce5:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107ceb:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107cee:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107cf5:	83 e2 df             	and    $0xffffffdf,%edx
80107cf8:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107cfe:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d01:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107d08:	83 ca 40             	or     $0x40,%edx
80107d0b:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107d11:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d14:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107d1b:	83 ca 80             	or     $0xffffff80,%edx
80107d1e:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107d24:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d27:	c6 80 97 00 00 00 00 	movb   $0x0,0x97(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80107d2e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d31:	66 c7 80 98 00 00 00 	movw   $0xffff,0x98(%eax)
80107d38:	ff ff 
80107d3a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d3d:	66 c7 80 9a 00 00 00 	movw   $0x0,0x9a(%eax)
80107d44:	00 00 
80107d46:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d49:	c6 80 9c 00 00 00 00 	movb   $0x0,0x9c(%eax)
80107d50:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d53:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107d5a:	83 e2 f0             	and    $0xfffffff0,%edx
80107d5d:	83 ca 02             	or     $0x2,%edx
80107d60:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107d66:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d69:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107d70:	83 ca 10             	or     $0x10,%edx
80107d73:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107d79:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d7c:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107d83:	83 ca 60             	or     $0x60,%edx
80107d86:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107d8c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d8f:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107d96:	83 ca 80             	or     $0xffffff80,%edx
80107d99:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107d9f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107da2:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107da9:	83 ca 0f             	or     $0xf,%edx
80107dac:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107db2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107db5:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107dbc:	83 e2 ef             	and    $0xffffffef,%edx
80107dbf:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107dc5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107dc8:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107dcf:	83 e2 df             	and    $0xffffffdf,%edx
80107dd2:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107dd8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ddb:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107de2:	83 ca 40             	or     $0x40,%edx
80107de5:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107deb:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107dee:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107df5:	83 ca 80             	or     $0xffffff80,%edx
80107df8:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107dfe:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e01:	c6 80 9f 00 00 00 00 	movb   $0x0,0x9f(%eax)

  // Map cpu, and curproc
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
80107e08:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e0b:	05 b4 00 00 00       	add    $0xb4,%eax
80107e10:	89 c3                	mov    %eax,%ebx
80107e12:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e15:	05 b4 00 00 00       	add    $0xb4,%eax
80107e1a:	c1 e8 10             	shr    $0x10,%eax
80107e1d:	89 c2                	mov    %eax,%edx
80107e1f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e22:	05 b4 00 00 00       	add    $0xb4,%eax
80107e27:	c1 e8 18             	shr    $0x18,%eax
80107e2a:	89 c1                	mov    %eax,%ecx
80107e2c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e2f:	66 c7 80 88 00 00 00 	movw   $0x0,0x88(%eax)
80107e36:	00 00 
80107e38:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e3b:	66 89 98 8a 00 00 00 	mov    %bx,0x8a(%eax)
80107e42:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e45:	88 90 8c 00 00 00    	mov    %dl,0x8c(%eax)
80107e4b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e4e:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80107e55:	83 e2 f0             	and    $0xfffffff0,%edx
80107e58:	83 ca 02             	or     $0x2,%edx
80107e5b:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80107e61:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e64:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80107e6b:	83 ca 10             	or     $0x10,%edx
80107e6e:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80107e74:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e77:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80107e7e:	83 e2 9f             	and    $0xffffff9f,%edx
80107e81:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80107e87:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e8a:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80107e91:	83 ca 80             	or     $0xffffff80,%edx
80107e94:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80107e9a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e9d:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80107ea4:	83 e2 f0             	and    $0xfffffff0,%edx
80107ea7:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80107ead:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107eb0:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80107eb7:	83 e2 ef             	and    $0xffffffef,%edx
80107eba:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80107ec0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ec3:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80107eca:	83 e2 df             	and    $0xffffffdf,%edx
80107ecd:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80107ed3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ed6:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80107edd:	83 ca 40             	or     $0x40,%edx
80107ee0:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80107ee6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ee9:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80107ef0:	83 ca 80             	or     $0xffffff80,%edx
80107ef3:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80107ef9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107efc:	88 88 8f 00 00 00    	mov    %cl,0x8f(%eax)

  lgdt(c->gdt, sizeof(c->gdt));
80107f02:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f05:	83 c0 70             	add    $0x70,%eax
80107f08:	83 ec 08             	sub    $0x8,%esp
80107f0b:	6a 38                	push   $0x38
80107f0d:	50                   	push   %eax
80107f0e:	e8 38 fb ff ff       	call   80107a4b <lgdt>
80107f13:	83 c4 10             	add    $0x10,%esp
  loadgs(SEG_KCPU << 3);
80107f16:	83 ec 0c             	sub    $0xc,%esp
80107f19:	6a 18                	push   $0x18
80107f1b:	e8 6c fb ff ff       	call   80107a8c <loadgs>
80107f20:	83 c4 10             	add    $0x10,%esp
  
  // Initialize cpu-local storage.
  cpu = c;
80107f23:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f26:	65 a3 00 00 00 00    	mov    %eax,%gs:0x0
  proc = 0;
80107f2c:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
80107f33:	00 00 00 00 
}
80107f37:	90                   	nop
80107f38:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80107f3b:	c9                   	leave  
80107f3c:	c3                   	ret    

80107f3d <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80107f3d:	55                   	push   %ebp
80107f3e:	89 e5                	mov    %esp,%ebp
80107f40:	83 ec 18             	sub    $0x18,%esp
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80107f43:	8b 45 0c             	mov    0xc(%ebp),%eax
80107f46:	c1 e8 16             	shr    $0x16,%eax
80107f49:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80107f50:	8b 45 08             	mov    0x8(%ebp),%eax
80107f53:	01 d0                	add    %edx,%eax
80107f55:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(*pde & PTE_P){
80107f58:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107f5b:	8b 00                	mov    (%eax),%eax
80107f5d:	83 e0 01             	and    $0x1,%eax
80107f60:	85 c0                	test   %eax,%eax
80107f62:	74 18                	je     80107f7c <walkpgdir+0x3f>
    pgtab = (pte_t*)p2v(PTE_ADDR(*pde));
80107f64:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107f67:	8b 00                	mov    (%eax),%eax
80107f69:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107f6e:	50                   	push   %eax
80107f6f:	e8 47 fb ff ff       	call   80107abb <p2v>
80107f74:	83 c4 04             	add    $0x4,%esp
80107f77:	89 45 f4             	mov    %eax,-0xc(%ebp)
80107f7a:	eb 48                	jmp    80107fc4 <walkpgdir+0x87>
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80107f7c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80107f80:	74 0e                	je     80107f90 <walkpgdir+0x53>
80107f82:	e8 b5 ac ff ff       	call   80102c3c <kalloc>
80107f87:	89 45 f4             	mov    %eax,-0xc(%ebp)
80107f8a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80107f8e:	75 07                	jne    80107f97 <walkpgdir+0x5a>
      return 0;
80107f90:	b8 00 00 00 00       	mov    $0x0,%eax
80107f95:	eb 44                	jmp    80107fdb <walkpgdir+0x9e>
    // Make sure all those PTE_P bits are zero.
    memset(pgtab, 0, PGSIZE);
80107f97:	83 ec 04             	sub    $0x4,%esp
80107f9a:	68 00 10 00 00       	push   $0x1000
80107f9f:	6a 00                	push   $0x0
80107fa1:	ff 75 f4             	pushl  -0xc(%ebp)
80107fa4:	e8 14 d6 ff ff       	call   801055bd <memset>
80107fa9:	83 c4 10             	add    $0x10,%esp
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table 
    // entries, if necessary.
    *pde = v2p(pgtab) | PTE_P | PTE_W | PTE_U;
80107fac:	83 ec 0c             	sub    $0xc,%esp
80107faf:	ff 75 f4             	pushl  -0xc(%ebp)
80107fb2:	e8 f7 fa ff ff       	call   80107aae <v2p>
80107fb7:	83 c4 10             	add    $0x10,%esp
80107fba:	83 c8 07             	or     $0x7,%eax
80107fbd:	89 c2                	mov    %eax,%edx
80107fbf:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107fc2:	89 10                	mov    %edx,(%eax)
  }
  return &pgtab[PTX(va)];
80107fc4:	8b 45 0c             	mov    0xc(%ebp),%eax
80107fc7:	c1 e8 0c             	shr    $0xc,%eax
80107fca:	25 ff 03 00 00       	and    $0x3ff,%eax
80107fcf:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80107fd6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107fd9:	01 d0                	add    %edx,%eax
}
80107fdb:	c9                   	leave  
80107fdc:	c3                   	ret    

80107fdd <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80107fdd:	55                   	push   %ebp
80107fde:	89 e5                	mov    %esp,%ebp
80107fe0:	83 ec 18             	sub    $0x18,%esp
  char *a, *last;
  pte_t *pte;
  
  a = (char*)PGROUNDDOWN((uint)va);
80107fe3:	8b 45 0c             	mov    0xc(%ebp),%eax
80107fe6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107feb:	89 45 f4             	mov    %eax,-0xc(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80107fee:	8b 55 0c             	mov    0xc(%ebp),%edx
80107ff1:	8b 45 10             	mov    0x10(%ebp),%eax
80107ff4:	01 d0                	add    %edx,%eax
80107ff6:	83 e8 01             	sub    $0x1,%eax
80107ff9:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107ffe:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80108001:	83 ec 04             	sub    $0x4,%esp
80108004:	6a 01                	push   $0x1
80108006:	ff 75 f4             	pushl  -0xc(%ebp)
80108009:	ff 75 08             	pushl  0x8(%ebp)
8010800c:	e8 2c ff ff ff       	call   80107f3d <walkpgdir>
80108011:	83 c4 10             	add    $0x10,%esp
80108014:	89 45 ec             	mov    %eax,-0x14(%ebp)
80108017:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
8010801b:	75 07                	jne    80108024 <mappages+0x47>
      return -1;
8010801d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80108022:	eb 47                	jmp    8010806b <mappages+0x8e>
    if(*pte & PTE_P)
80108024:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108027:	8b 00                	mov    (%eax),%eax
80108029:	83 e0 01             	and    $0x1,%eax
8010802c:	85 c0                	test   %eax,%eax
8010802e:	74 0d                	je     8010803d <mappages+0x60>
      panic("remap");
80108030:	83 ec 0c             	sub    $0xc,%esp
80108033:	68 18 8f 10 80       	push   $0x80108f18
80108038:	e8 25 85 ff ff       	call   80100562 <panic>
    *pte = pa | perm | PTE_P;
8010803d:	8b 45 18             	mov    0x18(%ebp),%eax
80108040:	0b 45 14             	or     0x14(%ebp),%eax
80108043:	83 c8 01             	or     $0x1,%eax
80108046:	89 c2                	mov    %eax,%edx
80108048:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010804b:	89 10                	mov    %edx,(%eax)
    if(a == last)
8010804d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108050:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80108053:	74 10                	je     80108065 <mappages+0x88>
      break;
    a += PGSIZE;
80108055:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
    pa += PGSIZE;
8010805c:	81 45 14 00 10 00 00 	addl   $0x1000,0x14(%ebp)
  }
80108063:	eb 9c                	jmp    80108001 <mappages+0x24>
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
    if(a == last)
      break;
80108065:	90                   	nop
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
80108066:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010806b:	c9                   	leave  
8010806c:	c3                   	ret    

8010806d <setupkvm>:
};

// Set up kernel part of a page table.
pde_t*
setupkvm(void)
{
8010806d:	55                   	push   %ebp
8010806e:	89 e5                	mov    %esp,%ebp
80108070:	53                   	push   %ebx
80108071:	83 ec 14             	sub    $0x14,%esp
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
80108074:	e8 c3 ab ff ff       	call   80102c3c <kalloc>
80108079:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010807c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80108080:	75 0a                	jne    8010808c <setupkvm+0x1f>
    return 0;
80108082:	b8 00 00 00 00       	mov    $0x0,%eax
80108087:	e9 8e 00 00 00       	jmp    8010811a <setupkvm+0xad>
  memset(pgdir, 0, PGSIZE);
8010808c:	83 ec 04             	sub    $0x4,%esp
8010808f:	68 00 10 00 00       	push   $0x1000
80108094:	6a 00                	push   $0x0
80108096:	ff 75 f0             	pushl  -0x10(%ebp)
80108099:	e8 1f d5 ff ff       	call   801055bd <memset>
8010809e:	83 c4 10             	add    $0x10,%esp
  if (p2v(PHYSTOP) > (void*)DEVSPACE)
801080a1:	83 ec 0c             	sub    $0xc,%esp
801080a4:	68 00 00 00 0e       	push   $0xe000000
801080a9:	e8 0d fa ff ff       	call   80107abb <p2v>
801080ae:	83 c4 10             	add    $0x10,%esp
801080b1:	3d 00 00 00 fe       	cmp    $0xfe000000,%eax
801080b6:	76 0d                	jbe    801080c5 <setupkvm+0x58>
    panic("PHYSTOP too high");
801080b8:	83 ec 0c             	sub    $0xc,%esp
801080bb:	68 1e 8f 10 80       	push   $0x80108f1e
801080c0:	e8 9d 84 ff ff       	call   80100562 <panic>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801080c5:	c7 45 f4 a0 c4 10 80 	movl   $0x8010c4a0,-0xc(%ebp)
801080cc:	eb 40                	jmp    8010810e <setupkvm+0xa1>
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start, 
801080ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
801080d1:	8b 48 0c             	mov    0xc(%eax),%ecx
                (uint)k->phys_start, k->perm) < 0)
801080d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801080d7:	8b 50 04             	mov    0x4(%eax),%edx
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (p2v(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start, 
801080da:	8b 45 f4             	mov    -0xc(%ebp),%eax
801080dd:	8b 58 08             	mov    0x8(%eax),%ebx
801080e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801080e3:	8b 40 04             	mov    0x4(%eax),%eax
801080e6:	29 c3                	sub    %eax,%ebx
801080e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801080eb:	8b 00                	mov    (%eax),%eax
801080ed:	83 ec 0c             	sub    $0xc,%esp
801080f0:	51                   	push   %ecx
801080f1:	52                   	push   %edx
801080f2:	53                   	push   %ebx
801080f3:	50                   	push   %eax
801080f4:	ff 75 f0             	pushl  -0x10(%ebp)
801080f7:	e8 e1 fe ff ff       	call   80107fdd <mappages>
801080fc:	83 c4 20             	add    $0x20,%esp
801080ff:	85 c0                	test   %eax,%eax
80108101:	79 07                	jns    8010810a <setupkvm+0x9d>
                (uint)k->phys_start, k->perm) < 0)
      return 0;
80108103:	b8 00 00 00 00       	mov    $0x0,%eax
80108108:	eb 10                	jmp    8010811a <setupkvm+0xad>
  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (p2v(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
8010810a:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
8010810e:	81 7d f4 e0 c4 10 80 	cmpl   $0x8010c4e0,-0xc(%ebp)
80108115:	72 b7                	jb     801080ce <setupkvm+0x61>
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start, 
                (uint)k->phys_start, k->perm) < 0)
      return 0;
  return pgdir;
80108117:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
8010811a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010811d:	c9                   	leave  
8010811e:	c3                   	ret    

8010811f <kvmalloc>:

// Allocate one page table for the machine for the kernel address
// space for scheduler processes.
void
kvmalloc(void)
{
8010811f:	55                   	push   %ebp
80108120:	89 e5                	mov    %esp,%ebp
80108122:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80108125:	e8 43 ff ff ff       	call   8010806d <setupkvm>
8010812a:	a3 d8 67 11 80       	mov    %eax,0x801167d8
  switchkvm();
8010812f:	e8 03 00 00 00       	call   80108137 <switchkvm>
}
80108134:	90                   	nop
80108135:	c9                   	leave  
80108136:	c3                   	ret    

80108137 <switchkvm>:

// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
80108137:	55                   	push   %ebp
80108138:	89 e5                	mov    %esp,%ebp
  lcr3(v2p(kpgdir));   // switch to the kernel page table
8010813a:	a1 d8 67 11 80       	mov    0x801167d8,%eax
8010813f:	50                   	push   %eax
80108140:	e8 69 f9 ff ff       	call   80107aae <v2p>
80108145:	83 c4 04             	add    $0x4,%esp
80108148:	50                   	push   %eax
80108149:	e8 54 f9 ff ff       	call   80107aa2 <lcr3>
8010814e:	83 c4 04             	add    $0x4,%esp
}
80108151:	90                   	nop
80108152:	c9                   	leave  
80108153:	c3                   	ret    

80108154 <switchuvm>:

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
80108154:	55                   	push   %ebp
80108155:	89 e5                	mov    %esp,%ebp
80108157:	56                   	push   %esi
80108158:	53                   	push   %ebx
  pushcli();
80108159:	e8 5b d3 ff ff       	call   801054b9 <pushcli>
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
8010815e:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80108164:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
8010816b:	83 c2 08             	add    $0x8,%edx
8010816e:	89 d6                	mov    %edx,%esi
80108170:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80108177:	83 c2 08             	add    $0x8,%edx
8010817a:	c1 ea 10             	shr    $0x10,%edx
8010817d:	89 d3                	mov    %edx,%ebx
8010817f:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80108186:	83 c2 08             	add    $0x8,%edx
80108189:	c1 ea 18             	shr    $0x18,%edx
8010818c:	89 d1                	mov    %edx,%ecx
8010818e:	66 c7 80 a0 00 00 00 	movw   $0x67,0xa0(%eax)
80108195:	67 00 
80108197:	66 89 b0 a2 00 00 00 	mov    %si,0xa2(%eax)
8010819e:	88 98 a4 00 00 00    	mov    %bl,0xa4(%eax)
801081a4:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
801081ab:	83 e2 f0             	and    $0xfffffff0,%edx
801081ae:	83 ca 09             	or     $0x9,%edx
801081b1:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
801081b7:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
801081be:	83 ca 10             	or     $0x10,%edx
801081c1:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
801081c7:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
801081ce:	83 e2 9f             	and    $0xffffff9f,%edx
801081d1:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
801081d7:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
801081de:	83 ca 80             	or     $0xffffff80,%edx
801081e1:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
801081e7:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
801081ee:	83 e2 f0             	and    $0xfffffff0,%edx
801081f1:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
801081f7:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
801081fe:	83 e2 ef             	and    $0xffffffef,%edx
80108201:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80108207:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
8010820e:	83 e2 df             	and    $0xffffffdf,%edx
80108211:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80108217:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
8010821e:	83 ca 40             	or     $0x40,%edx
80108221:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80108227:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
8010822e:	83 e2 7f             	and    $0x7f,%edx
80108231:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80108237:	88 88 a7 00 00 00    	mov    %cl,0xa7(%eax)
  cpu->gdt[SEG_TSS].s = 0;
8010823d:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80108243:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
8010824a:	83 e2 ef             	and    $0xffffffef,%edx
8010824d:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
  cpu->ts.ss0 = SEG_KDATA << 3;
80108253:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80108259:	66 c7 40 10 10 00    	movw   $0x10,0x10(%eax)
  cpu->ts.esp0 = (uint)proc->kstack + KSTACKSIZE;
8010825f:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80108265:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
8010826c:	8b 52 08             	mov    0x8(%edx),%edx
8010826f:	81 c2 00 10 00 00    	add    $0x1000,%edx
80108275:	89 50 0c             	mov    %edx,0xc(%eax)
  ltr(SEG_TSS << 3);
80108278:	83 ec 0c             	sub    $0xc,%esp
8010827b:	6a 30                	push   $0x30
8010827d:	e8 f3 f7 ff ff       	call   80107a75 <ltr>
80108282:	83 c4 10             	add    $0x10,%esp
  if(p->pgdir == 0)
80108285:	8b 45 08             	mov    0x8(%ebp),%eax
80108288:	8b 40 04             	mov    0x4(%eax),%eax
8010828b:	85 c0                	test   %eax,%eax
8010828d:	75 0d                	jne    8010829c <switchuvm+0x148>
    panic("switchuvm: no pgdir");
8010828f:	83 ec 0c             	sub    $0xc,%esp
80108292:	68 2f 8f 10 80       	push   $0x80108f2f
80108297:	e8 c6 82 ff ff       	call   80100562 <panic>
  lcr3(v2p(p->pgdir));  // switch to new address space
8010829c:	8b 45 08             	mov    0x8(%ebp),%eax
8010829f:	8b 40 04             	mov    0x4(%eax),%eax
801082a2:	83 ec 0c             	sub    $0xc,%esp
801082a5:	50                   	push   %eax
801082a6:	e8 03 f8 ff ff       	call   80107aae <v2p>
801082ab:	83 c4 10             	add    $0x10,%esp
801082ae:	83 ec 0c             	sub    $0xc,%esp
801082b1:	50                   	push   %eax
801082b2:	e8 eb f7 ff ff       	call   80107aa2 <lcr3>
801082b7:	83 c4 10             	add    $0x10,%esp
  popcli();
801082ba:	e8 3f d2 ff ff       	call   801054fe <popcli>
}
801082bf:	90                   	nop
801082c0:	8d 65 f8             	lea    -0x8(%ebp),%esp
801082c3:	5b                   	pop    %ebx
801082c4:	5e                   	pop    %esi
801082c5:	5d                   	pop    %ebp
801082c6:	c3                   	ret    

801082c7 <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
801082c7:	55                   	push   %ebp
801082c8:	89 e5                	mov    %esp,%ebp
801082ca:	83 ec 18             	sub    $0x18,%esp
  char *mem;
  
  if(sz >= PGSIZE)
801082cd:	81 7d 10 ff 0f 00 00 	cmpl   $0xfff,0x10(%ebp)
801082d4:	76 0d                	jbe    801082e3 <inituvm+0x1c>
    panic("inituvm: more than a page");
801082d6:	83 ec 0c             	sub    $0xc,%esp
801082d9:	68 43 8f 10 80       	push   $0x80108f43
801082de:	e8 7f 82 ff ff       	call   80100562 <panic>
  mem = kalloc();
801082e3:	e8 54 a9 ff ff       	call   80102c3c <kalloc>
801082e8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(mem, 0, PGSIZE);
801082eb:	83 ec 04             	sub    $0x4,%esp
801082ee:	68 00 10 00 00       	push   $0x1000
801082f3:	6a 00                	push   $0x0
801082f5:	ff 75 f4             	pushl  -0xc(%ebp)
801082f8:	e8 c0 d2 ff ff       	call   801055bd <memset>
801082fd:	83 c4 10             	add    $0x10,%esp
  mappages(pgdir, 0, PGSIZE, v2p(mem), PTE_W|PTE_U);
80108300:	83 ec 0c             	sub    $0xc,%esp
80108303:	ff 75 f4             	pushl  -0xc(%ebp)
80108306:	e8 a3 f7 ff ff       	call   80107aae <v2p>
8010830b:	83 c4 10             	add    $0x10,%esp
8010830e:	83 ec 0c             	sub    $0xc,%esp
80108311:	6a 06                	push   $0x6
80108313:	50                   	push   %eax
80108314:	68 00 10 00 00       	push   $0x1000
80108319:	6a 00                	push   $0x0
8010831b:	ff 75 08             	pushl  0x8(%ebp)
8010831e:	e8 ba fc ff ff       	call   80107fdd <mappages>
80108323:	83 c4 20             	add    $0x20,%esp
  memmove(mem, init, sz);
80108326:	83 ec 04             	sub    $0x4,%esp
80108329:	ff 75 10             	pushl  0x10(%ebp)
8010832c:	ff 75 0c             	pushl  0xc(%ebp)
8010832f:	ff 75 f4             	pushl  -0xc(%ebp)
80108332:	e8 45 d3 ff ff       	call   8010567c <memmove>
80108337:	83 c4 10             	add    $0x10,%esp
}
8010833a:	90                   	nop
8010833b:	c9                   	leave  
8010833c:	c3                   	ret    

8010833d <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
8010833d:	55                   	push   %ebp
8010833e:	89 e5                	mov    %esp,%ebp
80108340:	53                   	push   %ebx
80108341:	83 ec 14             	sub    $0x14,%esp
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
80108344:	8b 45 0c             	mov    0xc(%ebp),%eax
80108347:	25 ff 0f 00 00       	and    $0xfff,%eax
8010834c:	85 c0                	test   %eax,%eax
8010834e:	74 0d                	je     8010835d <loaduvm+0x20>
    panic("loaduvm: addr must be page aligned");
80108350:	83 ec 0c             	sub    $0xc,%esp
80108353:	68 60 8f 10 80       	push   $0x80108f60
80108358:	e8 05 82 ff ff       	call   80100562 <panic>
  for(i = 0; i < sz; i += PGSIZE){
8010835d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80108364:	e9 95 00 00 00       	jmp    801083fe <loaduvm+0xc1>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80108369:	8b 55 0c             	mov    0xc(%ebp),%edx
8010836c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010836f:	01 d0                	add    %edx,%eax
80108371:	83 ec 04             	sub    $0x4,%esp
80108374:	6a 00                	push   $0x0
80108376:	50                   	push   %eax
80108377:	ff 75 08             	pushl  0x8(%ebp)
8010837a:	e8 be fb ff ff       	call   80107f3d <walkpgdir>
8010837f:	83 c4 10             	add    $0x10,%esp
80108382:	89 45 ec             	mov    %eax,-0x14(%ebp)
80108385:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80108389:	75 0d                	jne    80108398 <loaduvm+0x5b>
      panic("loaduvm: address should exist");
8010838b:	83 ec 0c             	sub    $0xc,%esp
8010838e:	68 83 8f 10 80       	push   $0x80108f83
80108393:	e8 ca 81 ff ff       	call   80100562 <panic>
    pa = PTE_ADDR(*pte);
80108398:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010839b:	8b 00                	mov    (%eax),%eax
8010839d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801083a2:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(sz - i < PGSIZE)
801083a5:	8b 45 18             	mov    0x18(%ebp),%eax
801083a8:	2b 45 f4             	sub    -0xc(%ebp),%eax
801083ab:	3d ff 0f 00 00       	cmp    $0xfff,%eax
801083b0:	77 0b                	ja     801083bd <loaduvm+0x80>
      n = sz - i;
801083b2:	8b 45 18             	mov    0x18(%ebp),%eax
801083b5:	2b 45 f4             	sub    -0xc(%ebp),%eax
801083b8:	89 45 f0             	mov    %eax,-0x10(%ebp)
801083bb:	eb 07                	jmp    801083c4 <loaduvm+0x87>
    else
      n = PGSIZE;
801083bd:	c7 45 f0 00 10 00 00 	movl   $0x1000,-0x10(%ebp)
    if(readi(ip, p2v(pa), offset+i, n) != n)
801083c4:	8b 55 14             	mov    0x14(%ebp),%edx
801083c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801083ca:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
801083cd:	83 ec 0c             	sub    $0xc,%esp
801083d0:	ff 75 e8             	pushl  -0x18(%ebp)
801083d3:	e8 e3 f6 ff ff       	call   80107abb <p2v>
801083d8:	83 c4 10             	add    $0x10,%esp
801083db:	ff 75 f0             	pushl  -0x10(%ebp)
801083de:	53                   	push   %ebx
801083df:	50                   	push   %eax
801083e0:	ff 75 10             	pushl  0x10(%ebp)
801083e3:	e8 ce 9a ff ff       	call   80101eb6 <readi>
801083e8:	83 c4 10             	add    $0x10,%esp
801083eb:	3b 45 f0             	cmp    -0x10(%ebp),%eax
801083ee:	74 07                	je     801083f7 <loaduvm+0xba>
      return -1;
801083f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801083f5:	eb 18                	jmp    8010840f <loaduvm+0xd2>
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
801083f7:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
801083fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108401:	3b 45 18             	cmp    0x18(%ebp),%eax
80108404:	0f 82 5f ff ff ff    	jb     80108369 <loaduvm+0x2c>
    else
      n = PGSIZE;
    if(readi(ip, p2v(pa), offset+i, n) != n)
      return -1;
  }
  return 0;
8010840a:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010840f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80108412:	c9                   	leave  
80108413:	c3                   	ret    

80108414 <allocuvm>:

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80108414:	55                   	push   %ebp
80108415:	89 e5                	mov    %esp,%ebp
80108417:	83 ec 18             	sub    $0x18,%esp
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
8010841a:	8b 45 10             	mov    0x10(%ebp),%eax
8010841d:	85 c0                	test   %eax,%eax
8010841f:	79 0a                	jns    8010842b <allocuvm+0x17>
    return 0;
80108421:	b8 00 00 00 00       	mov    $0x0,%eax
80108426:	e9 b0 00 00 00       	jmp    801084db <allocuvm+0xc7>
  if(newsz < oldsz)
8010842b:	8b 45 10             	mov    0x10(%ebp),%eax
8010842e:	3b 45 0c             	cmp    0xc(%ebp),%eax
80108431:	73 08                	jae    8010843b <allocuvm+0x27>
    return oldsz;
80108433:	8b 45 0c             	mov    0xc(%ebp),%eax
80108436:	e9 a0 00 00 00       	jmp    801084db <allocuvm+0xc7>

  a = PGROUNDUP(oldsz);
8010843b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010843e:	05 ff 0f 00 00       	add    $0xfff,%eax
80108443:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108448:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; a < newsz; a += PGSIZE){
8010844b:	eb 7f                	jmp    801084cc <allocuvm+0xb8>
    mem = kalloc();
8010844d:	e8 ea a7 ff ff       	call   80102c3c <kalloc>
80108452:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(mem == 0){
80108455:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80108459:	75 2b                	jne    80108486 <allocuvm+0x72>
      cprintf("allocuvm out of memory\n");
8010845b:	83 ec 0c             	sub    $0xc,%esp
8010845e:	68 a1 8f 10 80       	push   $0x80108fa1
80108463:	e8 5a 7f ff ff       	call   801003c2 <cprintf>
80108468:	83 c4 10             	add    $0x10,%esp
      deallocuvm(pgdir, newsz, oldsz);
8010846b:	83 ec 04             	sub    $0x4,%esp
8010846e:	ff 75 0c             	pushl  0xc(%ebp)
80108471:	ff 75 10             	pushl  0x10(%ebp)
80108474:	ff 75 08             	pushl  0x8(%ebp)
80108477:	e8 61 00 00 00       	call   801084dd <deallocuvm>
8010847c:	83 c4 10             	add    $0x10,%esp
      return 0;
8010847f:	b8 00 00 00 00       	mov    $0x0,%eax
80108484:	eb 55                	jmp    801084db <allocuvm+0xc7>
    }
    memset(mem, 0, PGSIZE);
80108486:	83 ec 04             	sub    $0x4,%esp
80108489:	68 00 10 00 00       	push   $0x1000
8010848e:	6a 00                	push   $0x0
80108490:	ff 75 f0             	pushl  -0x10(%ebp)
80108493:	e8 25 d1 ff ff       	call   801055bd <memset>
80108498:	83 c4 10             	add    $0x10,%esp
    mappages(pgdir, (char*)a, PGSIZE, v2p(mem), PTE_W|PTE_U);
8010849b:	83 ec 0c             	sub    $0xc,%esp
8010849e:	ff 75 f0             	pushl  -0x10(%ebp)
801084a1:	e8 08 f6 ff ff       	call   80107aae <v2p>
801084a6:	83 c4 10             	add    $0x10,%esp
801084a9:	89 c2                	mov    %eax,%edx
801084ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
801084ae:	83 ec 0c             	sub    $0xc,%esp
801084b1:	6a 06                	push   $0x6
801084b3:	52                   	push   %edx
801084b4:	68 00 10 00 00       	push   $0x1000
801084b9:	50                   	push   %eax
801084ba:	ff 75 08             	pushl  0x8(%ebp)
801084bd:	e8 1b fb ff ff       	call   80107fdd <mappages>
801084c2:	83 c4 20             	add    $0x20,%esp
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
801084c5:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
801084cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801084cf:	3b 45 10             	cmp    0x10(%ebp),%eax
801084d2:	0f 82 75 ff ff ff    	jb     8010844d <allocuvm+0x39>
      return 0;
    }
    memset(mem, 0, PGSIZE);
    mappages(pgdir, (char*)a, PGSIZE, v2p(mem), PTE_W|PTE_U);
  }
  return newsz;
801084d8:	8b 45 10             	mov    0x10(%ebp),%eax
}
801084db:	c9                   	leave  
801084dc:	c3                   	ret    

801084dd <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
801084dd:	55                   	push   %ebp
801084de:	89 e5                	mov    %esp,%ebp
801084e0:	83 ec 18             	sub    $0x18,%esp
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
801084e3:	8b 45 10             	mov    0x10(%ebp),%eax
801084e6:	3b 45 0c             	cmp    0xc(%ebp),%eax
801084e9:	72 08                	jb     801084f3 <deallocuvm+0x16>
    return oldsz;
801084eb:	8b 45 0c             	mov    0xc(%ebp),%eax
801084ee:	e9 a5 00 00 00       	jmp    80108598 <deallocuvm+0xbb>

  a = PGROUNDUP(newsz);
801084f3:	8b 45 10             	mov    0x10(%ebp),%eax
801084f6:	05 ff 0f 00 00       	add    $0xfff,%eax
801084fb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108500:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80108503:	e9 81 00 00 00       	jmp    80108589 <deallocuvm+0xac>
    pte = walkpgdir(pgdir, (char*)a, 0);
80108508:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010850b:	83 ec 04             	sub    $0x4,%esp
8010850e:	6a 00                	push   $0x0
80108510:	50                   	push   %eax
80108511:	ff 75 08             	pushl  0x8(%ebp)
80108514:	e8 24 fa ff ff       	call   80107f3d <walkpgdir>
80108519:	83 c4 10             	add    $0x10,%esp
8010851c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(!pte)
8010851f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80108523:	75 09                	jne    8010852e <deallocuvm+0x51>
      a += (NPTENTRIES - 1) * PGSIZE;
80108525:	81 45 f4 00 f0 3f 00 	addl   $0x3ff000,-0xc(%ebp)
8010852c:	eb 54                	jmp    80108582 <deallocuvm+0xa5>
    else if((*pte & PTE_P) != 0){
8010852e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108531:	8b 00                	mov    (%eax),%eax
80108533:	83 e0 01             	and    $0x1,%eax
80108536:	85 c0                	test   %eax,%eax
80108538:	74 48                	je     80108582 <deallocuvm+0xa5>
      pa = PTE_ADDR(*pte);
8010853a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010853d:	8b 00                	mov    (%eax),%eax
8010853f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108544:	89 45 ec             	mov    %eax,-0x14(%ebp)
      if(pa == 0)
80108547:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
8010854b:	75 0d                	jne    8010855a <deallocuvm+0x7d>
        panic("kfree");
8010854d:	83 ec 0c             	sub    $0xc,%esp
80108550:	68 b9 8f 10 80       	push   $0x80108fb9
80108555:	e8 08 80 ff ff       	call   80100562 <panic>
      char *v = p2v(pa);
8010855a:	83 ec 0c             	sub    $0xc,%esp
8010855d:	ff 75 ec             	pushl  -0x14(%ebp)
80108560:	e8 56 f5 ff ff       	call   80107abb <p2v>
80108565:	83 c4 10             	add    $0x10,%esp
80108568:	89 45 e8             	mov    %eax,-0x18(%ebp)
      kfree(v);
8010856b:	83 ec 0c             	sub    $0xc,%esp
8010856e:	ff 75 e8             	pushl  -0x18(%ebp)
80108571:	e8 2a a6 ff ff       	call   80102ba0 <kfree>
80108576:	83 c4 10             	add    $0x10,%esp
      *pte = 0;
80108579:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010857c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80108582:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80108589:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010858c:	3b 45 0c             	cmp    0xc(%ebp),%eax
8010858f:	0f 82 73 ff ff ff    	jb     80108508 <deallocuvm+0x2b>
      char *v = p2v(pa);
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
80108595:	8b 45 10             	mov    0x10(%ebp),%eax
}
80108598:	c9                   	leave  
80108599:	c3                   	ret    

8010859a <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
8010859a:	55                   	push   %ebp
8010859b:	89 e5                	mov    %esp,%ebp
8010859d:	83 ec 18             	sub    $0x18,%esp
  uint i;

  if(pgdir == 0)
801085a0:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801085a4:	75 0d                	jne    801085b3 <freevm+0x19>
    panic("freevm: no pgdir");
801085a6:	83 ec 0c             	sub    $0xc,%esp
801085a9:	68 bf 8f 10 80       	push   $0x80108fbf
801085ae:	e8 af 7f ff ff       	call   80100562 <panic>
  deallocuvm(pgdir, KERNBASE, 0);
801085b3:	83 ec 04             	sub    $0x4,%esp
801085b6:	6a 00                	push   $0x0
801085b8:	68 00 00 00 80       	push   $0x80000000
801085bd:	ff 75 08             	pushl  0x8(%ebp)
801085c0:	e8 18 ff ff ff       	call   801084dd <deallocuvm>
801085c5:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
801085c8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801085cf:	eb 4f                	jmp    80108620 <freevm+0x86>
    if(pgdir[i] & PTE_P){
801085d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801085d4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
801085db:	8b 45 08             	mov    0x8(%ebp),%eax
801085de:	01 d0                	add    %edx,%eax
801085e0:	8b 00                	mov    (%eax),%eax
801085e2:	83 e0 01             	and    $0x1,%eax
801085e5:	85 c0                	test   %eax,%eax
801085e7:	74 33                	je     8010861c <freevm+0x82>
      char * v = p2v(PTE_ADDR(pgdir[i]));
801085e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801085ec:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
801085f3:	8b 45 08             	mov    0x8(%ebp),%eax
801085f6:	01 d0                	add    %edx,%eax
801085f8:	8b 00                	mov    (%eax),%eax
801085fa:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801085ff:	83 ec 0c             	sub    $0xc,%esp
80108602:	50                   	push   %eax
80108603:	e8 b3 f4 ff ff       	call   80107abb <p2v>
80108608:	83 c4 10             	add    $0x10,%esp
8010860b:	89 45 f0             	mov    %eax,-0x10(%ebp)
      kfree(v);
8010860e:	83 ec 0c             	sub    $0xc,%esp
80108611:	ff 75 f0             	pushl  -0x10(%ebp)
80108614:	e8 87 a5 ff ff       	call   80102ba0 <kfree>
80108619:	83 c4 10             	add    $0x10,%esp
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
8010861c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80108620:	81 7d f4 ff 03 00 00 	cmpl   $0x3ff,-0xc(%ebp)
80108627:	76 a8                	jbe    801085d1 <freevm+0x37>
    if(pgdir[i] & PTE_P){
      char * v = p2v(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
80108629:	83 ec 0c             	sub    $0xc,%esp
8010862c:	ff 75 08             	pushl  0x8(%ebp)
8010862f:	e8 6c a5 ff ff       	call   80102ba0 <kfree>
80108634:	83 c4 10             	add    $0x10,%esp
}
80108637:	90                   	nop
80108638:	c9                   	leave  
80108639:	c3                   	ret    

8010863a <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
8010863a:	55                   	push   %ebp
8010863b:	89 e5                	mov    %esp,%ebp
8010863d:	83 ec 18             	sub    $0x18,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80108640:	83 ec 04             	sub    $0x4,%esp
80108643:	6a 00                	push   $0x0
80108645:	ff 75 0c             	pushl  0xc(%ebp)
80108648:	ff 75 08             	pushl  0x8(%ebp)
8010864b:	e8 ed f8 ff ff       	call   80107f3d <walkpgdir>
80108650:	83 c4 10             	add    $0x10,%esp
80108653:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pte == 0)
80108656:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010865a:	75 0d                	jne    80108669 <clearpteu+0x2f>
    panic("clearpteu");
8010865c:	83 ec 0c             	sub    $0xc,%esp
8010865f:	68 d0 8f 10 80       	push   $0x80108fd0
80108664:	e8 f9 7e ff ff       	call   80100562 <panic>
  *pte &= ~PTE_U;
80108669:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010866c:	8b 00                	mov    (%eax),%eax
8010866e:	83 e0 fb             	and    $0xfffffffb,%eax
80108671:	89 c2                	mov    %eax,%edx
80108673:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108676:	89 10                	mov    %edx,(%eax)
}
80108678:	90                   	nop
80108679:	c9                   	leave  
8010867a:	c3                   	ret    

8010867b <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
8010867b:	55                   	push   %ebp
8010867c:	89 e5                	mov    %esp,%ebp
8010867e:	53                   	push   %ebx
8010867f:	83 ec 24             	sub    $0x24,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80108682:	e8 e6 f9 ff ff       	call   8010806d <setupkvm>
80108687:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010868a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010868e:	75 0a                	jne    8010869a <copyuvm+0x1f>
    return 0;
80108690:	b8 00 00 00 00       	mov    $0x0,%eax
80108695:	e9 f8 00 00 00       	jmp    80108792 <copyuvm+0x117>
  for(i = 0; i < sz; i += PGSIZE){
8010869a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801086a1:	e9 c4 00 00 00       	jmp    8010876a <copyuvm+0xef>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
801086a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801086a9:	83 ec 04             	sub    $0x4,%esp
801086ac:	6a 00                	push   $0x0
801086ae:	50                   	push   %eax
801086af:	ff 75 08             	pushl  0x8(%ebp)
801086b2:	e8 86 f8 ff ff       	call   80107f3d <walkpgdir>
801086b7:	83 c4 10             	add    $0x10,%esp
801086ba:	89 45 ec             	mov    %eax,-0x14(%ebp)
801086bd:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
801086c1:	75 0d                	jne    801086d0 <copyuvm+0x55>
      panic("copyuvm: pte should exist");
801086c3:	83 ec 0c             	sub    $0xc,%esp
801086c6:	68 da 8f 10 80       	push   $0x80108fda
801086cb:	e8 92 7e ff ff       	call   80100562 <panic>
    if(!(*pte & PTE_P))
801086d0:	8b 45 ec             	mov    -0x14(%ebp),%eax
801086d3:	8b 00                	mov    (%eax),%eax
801086d5:	83 e0 01             	and    $0x1,%eax
801086d8:	85 c0                	test   %eax,%eax
801086da:	75 0d                	jne    801086e9 <copyuvm+0x6e>
      panic("copyuvm: page not present");
801086dc:	83 ec 0c             	sub    $0xc,%esp
801086df:	68 f4 8f 10 80       	push   $0x80108ff4
801086e4:	e8 79 7e ff ff       	call   80100562 <panic>
    pa = PTE_ADDR(*pte);
801086e9:	8b 45 ec             	mov    -0x14(%ebp),%eax
801086ec:	8b 00                	mov    (%eax),%eax
801086ee:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801086f3:	89 45 e8             	mov    %eax,-0x18(%ebp)
    flags = PTE_FLAGS(*pte);
801086f6:	8b 45 ec             	mov    -0x14(%ebp),%eax
801086f9:	8b 00                	mov    (%eax),%eax
801086fb:	25 ff 0f 00 00       	and    $0xfff,%eax
80108700:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if((mem = kalloc()) == 0)
80108703:	e8 34 a5 ff ff       	call   80102c3c <kalloc>
80108708:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010870b:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
8010870f:	74 6a                	je     8010877b <copyuvm+0x100>
      goto bad;
    memmove(mem, (char*)p2v(pa), PGSIZE);
80108711:	83 ec 0c             	sub    $0xc,%esp
80108714:	ff 75 e8             	pushl  -0x18(%ebp)
80108717:	e8 9f f3 ff ff       	call   80107abb <p2v>
8010871c:	83 c4 10             	add    $0x10,%esp
8010871f:	83 ec 04             	sub    $0x4,%esp
80108722:	68 00 10 00 00       	push   $0x1000
80108727:	50                   	push   %eax
80108728:	ff 75 e0             	pushl  -0x20(%ebp)
8010872b:	e8 4c cf ff ff       	call   8010567c <memmove>
80108730:	83 c4 10             	add    $0x10,%esp
    if(mappages(d, (void*)i, PGSIZE, v2p(mem), flags) < 0)
80108733:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80108736:	83 ec 0c             	sub    $0xc,%esp
80108739:	ff 75 e0             	pushl  -0x20(%ebp)
8010873c:	e8 6d f3 ff ff       	call   80107aae <v2p>
80108741:	83 c4 10             	add    $0x10,%esp
80108744:	89 c2                	mov    %eax,%edx
80108746:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108749:	83 ec 0c             	sub    $0xc,%esp
8010874c:	53                   	push   %ebx
8010874d:	52                   	push   %edx
8010874e:	68 00 10 00 00       	push   $0x1000
80108753:	50                   	push   %eax
80108754:	ff 75 f0             	pushl  -0x10(%ebp)
80108757:	e8 81 f8 ff ff       	call   80107fdd <mappages>
8010875c:	83 c4 20             	add    $0x20,%esp
8010875f:	85 c0                	test   %eax,%eax
80108761:	78 1b                	js     8010877e <copyuvm+0x103>
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80108763:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
8010876a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010876d:	3b 45 0c             	cmp    0xc(%ebp),%eax
80108770:	0f 82 30 ff ff ff    	jb     801086a6 <copyuvm+0x2b>
      goto bad;
    memmove(mem, (char*)p2v(pa), PGSIZE);
    if(mappages(d, (void*)i, PGSIZE, v2p(mem), flags) < 0)
      goto bad;
  }
  return d;
80108776:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108779:	eb 17                	jmp    80108792 <copyuvm+0x117>
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
8010877b:	90                   	nop
8010877c:	eb 01                	jmp    8010877f <copyuvm+0x104>
    memmove(mem, (char*)p2v(pa), PGSIZE);
    if(mappages(d, (void*)i, PGSIZE, v2p(mem), flags) < 0)
      goto bad;
8010877e:	90                   	nop
  }
  return d;

bad:
  freevm(d);
8010877f:	83 ec 0c             	sub    $0xc,%esp
80108782:	ff 75 f0             	pushl  -0x10(%ebp)
80108785:	e8 10 fe ff ff       	call   8010859a <freevm>
8010878a:	83 c4 10             	add    $0x10,%esp
  return 0;
8010878d:	b8 00 00 00 00       	mov    $0x0,%eax
}
80108792:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80108795:	c9                   	leave  
80108796:	c3                   	ret    

80108797 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80108797:	55                   	push   %ebp
80108798:	89 e5                	mov    %esp,%ebp
8010879a:	83 ec 18             	sub    $0x18,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
8010879d:	83 ec 04             	sub    $0x4,%esp
801087a0:	6a 00                	push   $0x0
801087a2:	ff 75 0c             	pushl  0xc(%ebp)
801087a5:	ff 75 08             	pushl  0x8(%ebp)
801087a8:	e8 90 f7 ff ff       	call   80107f3d <walkpgdir>
801087ad:	83 c4 10             	add    $0x10,%esp
801087b0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((*pte & PTE_P) == 0)
801087b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801087b6:	8b 00                	mov    (%eax),%eax
801087b8:	83 e0 01             	and    $0x1,%eax
801087bb:	85 c0                	test   %eax,%eax
801087bd:	75 07                	jne    801087c6 <uva2ka+0x2f>
    return 0;
801087bf:	b8 00 00 00 00       	mov    $0x0,%eax
801087c4:	eb 29                	jmp    801087ef <uva2ka+0x58>
  if((*pte & PTE_U) == 0)
801087c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801087c9:	8b 00                	mov    (%eax),%eax
801087cb:	83 e0 04             	and    $0x4,%eax
801087ce:	85 c0                	test   %eax,%eax
801087d0:	75 07                	jne    801087d9 <uva2ka+0x42>
    return 0;
801087d2:	b8 00 00 00 00       	mov    $0x0,%eax
801087d7:	eb 16                	jmp    801087ef <uva2ka+0x58>
  return (char*)p2v(PTE_ADDR(*pte));
801087d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801087dc:	8b 00                	mov    (%eax),%eax
801087de:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801087e3:	83 ec 0c             	sub    $0xc,%esp
801087e6:	50                   	push   %eax
801087e7:	e8 cf f2 ff ff       	call   80107abb <p2v>
801087ec:	83 c4 10             	add    $0x10,%esp
}
801087ef:	c9                   	leave  
801087f0:	c3                   	ret    

801087f1 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
801087f1:	55                   	push   %ebp
801087f2:	89 e5                	mov    %esp,%ebp
801087f4:	83 ec 18             	sub    $0x18,%esp
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
801087f7:	8b 45 10             	mov    0x10(%ebp),%eax
801087fa:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(len > 0){
801087fd:	eb 7f                	jmp    8010887e <copyout+0x8d>
    va0 = (uint)PGROUNDDOWN(va);
801087ff:	8b 45 0c             	mov    0xc(%ebp),%eax
80108802:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108807:	89 45 ec             	mov    %eax,-0x14(%ebp)
    pa0 = uva2ka(pgdir, (char*)va0);
8010880a:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010880d:	83 ec 08             	sub    $0x8,%esp
80108810:	50                   	push   %eax
80108811:	ff 75 08             	pushl  0x8(%ebp)
80108814:	e8 7e ff ff ff       	call   80108797 <uva2ka>
80108819:	83 c4 10             	add    $0x10,%esp
8010881c:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(pa0 == 0)
8010881f:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
80108823:	75 07                	jne    8010882c <copyout+0x3b>
      return -1;
80108825:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010882a:	eb 61                	jmp    8010888d <copyout+0x9c>
    n = PGSIZE - (va - va0);
8010882c:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010882f:	2b 45 0c             	sub    0xc(%ebp),%eax
80108832:	05 00 10 00 00       	add    $0x1000,%eax
80108837:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(n > len)
8010883a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010883d:	3b 45 14             	cmp    0x14(%ebp),%eax
80108840:	76 06                	jbe    80108848 <copyout+0x57>
      n = len;
80108842:	8b 45 14             	mov    0x14(%ebp),%eax
80108845:	89 45 f0             	mov    %eax,-0x10(%ebp)
    memmove(pa0 + (va - va0), buf, n);
80108848:	8b 45 0c             	mov    0xc(%ebp),%eax
8010884b:	2b 45 ec             	sub    -0x14(%ebp),%eax
8010884e:	89 c2                	mov    %eax,%edx
80108850:	8b 45 e8             	mov    -0x18(%ebp),%eax
80108853:	01 d0                	add    %edx,%eax
80108855:	83 ec 04             	sub    $0x4,%esp
80108858:	ff 75 f0             	pushl  -0x10(%ebp)
8010885b:	ff 75 f4             	pushl  -0xc(%ebp)
8010885e:	50                   	push   %eax
8010885f:	e8 18 ce ff ff       	call   8010567c <memmove>
80108864:	83 c4 10             	add    $0x10,%esp
    len -= n;
80108867:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010886a:	29 45 14             	sub    %eax,0x14(%ebp)
    buf += n;
8010886d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108870:	01 45 f4             	add    %eax,-0xc(%ebp)
    va = va0 + PGSIZE;
80108873:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108876:	05 00 10 00 00       	add    $0x1000,%eax
8010887b:	89 45 0c             	mov    %eax,0xc(%ebp)
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
8010887e:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
80108882:	0f 85 77 ff ff ff    	jne    801087ff <copyout+0xe>
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
80108888:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010888d:	c9                   	leave  
8010888e:	c3                   	ret    
