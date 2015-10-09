
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
80100015:	b8 00 a0 10 00       	mov    $0x10a000,%eax
8010001a:	0f 22 d8             	mov    %eax,%cr3
8010001d:	0f 20 c0             	mov    %cr0,%eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
80100025:	0f 22 c0             	mov    %eax,%cr0
80100028:	bc 10 c8 10 80       	mov    $0x8010c810,%esp
8010002d:	b8 2c 38 10 80       	mov    $0x8010382c,%eax
80100032:	ff e0                	jmp    *%eax

80100034 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100034:	55                   	push   %ebp
80100035:	89 e5                	mov    %esp,%ebp
80100037:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  initlock(&bcache.lock, "bcache");
8010003a:	83 ec 08             	sub    $0x8,%esp
8010003d:	68 2c 87 10 80       	push   $0x8010872c
80100042:	68 40 c8 10 80       	push   $0x8010c840
80100047:	e8 da 51 00 00       	call   80105226 <initlock>
8010004c:	83 c4 10             	add    $0x10,%esp

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
8010004f:	c7 05 50 07 11 80 44 	movl   $0x80110744,0x80110750
80100056:	07 11 80 
  bcache.head.next = &bcache.head;
80100059:	c7 05 54 07 11 80 44 	movl   $0x80110744,0x80110754
80100060:	07 11 80 
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100063:	c7 45 f4 74 c8 10 80 	movl   $0x8010c874,-0xc(%ebp)
8010006a:	eb 3a                	jmp    801000a6 <binit+0x72>
    b->next = bcache.head.next;
8010006c:	8b 15 54 07 11 80    	mov    0x80110754,%edx
80100072:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100075:	89 50 10             	mov    %edx,0x10(%eax)
    b->prev = &bcache.head;
80100078:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010007b:	c7 40 0c 44 07 11 80 	movl   $0x80110744,0xc(%eax)
    b->dev = -1;
80100082:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100085:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
    bcache.head.next->prev = b;
8010008c:	a1 54 07 11 80       	mov    0x80110754,%eax
80100091:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100094:	89 50 0c             	mov    %edx,0xc(%eax)
    bcache.head.next = b;
80100097:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010009a:	a3 54 07 11 80       	mov    %eax,0x80110754

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
8010009f:	81 45 f4 18 02 00 00 	addl   $0x218,-0xc(%ebp)
801000a6:	81 7d f4 44 07 11 80 	cmpl   $0x80110744,-0xc(%ebp)
801000ad:	72 bd                	jb     8010006c <binit+0x38>
    b->prev = &bcache.head;
    b->dev = -1;
    bcache.head.next->prev = b;
    bcache.head.next = b;
  }
}
801000af:	c9                   	leave  
801000b0:	c3                   	ret    

801000b1 <bget>:
// Look through buffer cache for block on device dev.
// If not found, allocate a buffer.
// In either case, return B_BUSY buffer.
static struct buf*
bget(uint dev, uint blockno)
{
801000b1:	55                   	push   %ebp
801000b2:	89 e5                	mov    %esp,%ebp
801000b4:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  acquire(&bcache.lock);
801000b7:	83 ec 0c             	sub    $0xc,%esp
801000ba:	68 40 c8 10 80       	push   $0x8010c840
801000bf:	e8 83 51 00 00       	call   80105247 <acquire>
801000c4:	83 c4 10             	add    $0x10,%esp

 loop:
  // Is the block already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000c7:	a1 54 07 11 80       	mov    0x80110754,%eax
801000cc:	89 45 f4             	mov    %eax,-0xc(%ebp)
801000cf:	eb 67                	jmp    80100138 <bget+0x87>
    if(b->dev == dev && b->blockno == blockno){
801000d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000d4:	8b 40 04             	mov    0x4(%eax),%eax
801000d7:	3b 45 08             	cmp    0x8(%ebp),%eax
801000da:	75 53                	jne    8010012f <bget+0x7e>
801000dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000df:	8b 40 08             	mov    0x8(%eax),%eax
801000e2:	3b 45 0c             	cmp    0xc(%ebp),%eax
801000e5:	75 48                	jne    8010012f <bget+0x7e>
      if(!(b->flags & B_BUSY)){
801000e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000ea:	8b 00                	mov    (%eax),%eax
801000ec:	83 e0 01             	and    $0x1,%eax
801000ef:	85 c0                	test   %eax,%eax
801000f1:	75 27                	jne    8010011a <bget+0x69>
        b->flags |= B_BUSY;
801000f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000f6:	8b 00                	mov    (%eax),%eax
801000f8:	83 c8 01             	or     $0x1,%eax
801000fb:	89 c2                	mov    %eax,%edx
801000fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100100:	89 10                	mov    %edx,(%eax)
        release(&bcache.lock);
80100102:	83 ec 0c             	sub    $0xc,%esp
80100105:	68 40 c8 10 80       	push   $0x8010c840
8010010a:	e8 9e 51 00 00       	call   801052ad <release>
8010010f:	83 c4 10             	add    $0x10,%esp
        return b;
80100112:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100115:	e9 98 00 00 00       	jmp    801001b2 <bget+0x101>
      }
      sleep(b, &bcache.lock);
8010011a:	83 ec 08             	sub    $0x8,%esp
8010011d:	68 40 c8 10 80       	push   $0x8010c840
80100122:	ff 75 f4             	pushl  -0xc(%ebp)
80100125:	e8 f7 4d 00 00       	call   80104f21 <sleep>
8010012a:	83 c4 10             	add    $0x10,%esp
      goto loop;
8010012d:	eb 98                	jmp    801000c7 <bget+0x16>

  acquire(&bcache.lock);

 loop:
  // Is the block already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
8010012f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100132:	8b 40 10             	mov    0x10(%eax),%eax
80100135:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100138:	81 7d f4 44 07 11 80 	cmpl   $0x80110744,-0xc(%ebp)
8010013f:	75 90                	jne    801000d1 <bget+0x20>
  }

  // Not cached; recycle some non-busy and clean buffer.
  // "clean" because B_DIRTY and !B_BUSY means log.c
  // hasn't yet committed the changes to the buffer.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100141:	a1 50 07 11 80       	mov    0x80110750,%eax
80100146:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100149:	eb 51                	jmp    8010019c <bget+0xeb>
    if((b->flags & B_BUSY) == 0 && (b->flags & B_DIRTY) == 0){
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
      b->dev = dev;
80100163:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100166:	8b 55 08             	mov    0x8(%ebp),%edx
80100169:	89 50 04             	mov    %edx,0x4(%eax)
      b->blockno = blockno;
8010016c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010016f:	8b 55 0c             	mov    0xc(%ebp),%edx
80100172:	89 50 08             	mov    %edx,0x8(%eax)
      b->flags = B_BUSY;
80100175:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100178:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
      release(&bcache.lock);
8010017e:	83 ec 0c             	sub    $0xc,%esp
80100181:	68 40 c8 10 80       	push   $0x8010c840
80100186:	e8 22 51 00 00       	call   801052ad <release>
8010018b:	83 c4 10             	add    $0x10,%esp
      return b;
8010018e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100191:	eb 1f                	jmp    801001b2 <bget+0x101>
  }

  // Not cached; recycle some non-busy and clean buffer.
  // "clean" because B_DIRTY and !B_BUSY means log.c
  // hasn't yet committed the changes to the buffer.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100193:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100196:	8b 40 0c             	mov    0xc(%eax),%eax
80100199:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010019c:	81 7d f4 44 07 11 80 	cmpl   $0x80110744,-0xc(%ebp)
801001a3:	75 a6                	jne    8010014b <bget+0x9a>
      b->flags = B_BUSY;
      release(&bcache.lock);
      return b;
    }
  }
  panic("bget: no buffers");
801001a5:	83 ec 0c             	sub    $0xc,%esp
801001a8:	68 33 87 10 80       	push   $0x80108733
801001ad:	e8 aa 03 00 00       	call   8010055c <panic>
}
801001b2:	c9                   	leave  
801001b3:	c3                   	ret    

801001b4 <bread>:

// Return a B_BUSY buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801001b4:	55                   	push   %ebp
801001b5:	89 e5                	mov    %esp,%ebp
801001b7:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  b = bget(dev, blockno);
801001ba:	83 ec 08             	sub    $0x8,%esp
801001bd:	ff 75 0c             	pushl  0xc(%ebp)
801001c0:	ff 75 08             	pushl  0x8(%ebp)
801001c3:	e8 e9 fe ff ff       	call   801000b1 <bget>
801001c8:	83 c4 10             	add    $0x10,%esp
801001cb:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(!(b->flags & B_VALID)) {
801001ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
801001d1:	8b 00                	mov    (%eax),%eax
801001d3:	83 e0 02             	and    $0x2,%eax
801001d6:	85 c0                	test   %eax,%eax
801001d8:	75 0e                	jne    801001e8 <bread+0x34>
    iderw(b);
801001da:	83 ec 0c             	sub    $0xc,%esp
801001dd:	ff 75 f4             	pushl  -0xc(%ebp)
801001e0:	e8 df 26 00 00       	call   801028c4 <iderw>
801001e5:	83 c4 10             	add    $0x10,%esp
  }
  return b;
801001e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801001eb:	c9                   	leave  
801001ec:	c3                   	ret    

801001ed <bwrite>:

// Write b's contents to disk.  Must be B_BUSY.
void
bwrite(struct buf *b)
{
801001ed:	55                   	push   %ebp
801001ee:	89 e5                	mov    %esp,%ebp
801001f0:	83 ec 08             	sub    $0x8,%esp
  if((b->flags & B_BUSY) == 0)
801001f3:	8b 45 08             	mov    0x8(%ebp),%eax
801001f6:	8b 00                	mov    (%eax),%eax
801001f8:	83 e0 01             	and    $0x1,%eax
801001fb:	85 c0                	test   %eax,%eax
801001fd:	75 0d                	jne    8010020c <bwrite+0x1f>
    panic("bwrite");
801001ff:	83 ec 0c             	sub    $0xc,%esp
80100202:	68 44 87 10 80       	push   $0x80108744
80100207:	e8 50 03 00 00       	call   8010055c <panic>
  b->flags |= B_DIRTY;
8010020c:	8b 45 08             	mov    0x8(%ebp),%eax
8010020f:	8b 00                	mov    (%eax),%eax
80100211:	83 c8 04             	or     $0x4,%eax
80100214:	89 c2                	mov    %eax,%edx
80100216:	8b 45 08             	mov    0x8(%ebp),%eax
80100219:	89 10                	mov    %edx,(%eax)
  iderw(b);
8010021b:	83 ec 0c             	sub    $0xc,%esp
8010021e:	ff 75 08             	pushl  0x8(%ebp)
80100221:	e8 9e 26 00 00       	call   801028c4 <iderw>
80100226:	83 c4 10             	add    $0x10,%esp
}
80100229:	c9                   	leave  
8010022a:	c3                   	ret    

8010022b <brelse>:

// Release a B_BUSY buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
8010022b:	55                   	push   %ebp
8010022c:	89 e5                	mov    %esp,%ebp
8010022e:	83 ec 08             	sub    $0x8,%esp
  if((b->flags & B_BUSY) == 0)
80100231:	8b 45 08             	mov    0x8(%ebp),%eax
80100234:	8b 00                	mov    (%eax),%eax
80100236:	83 e0 01             	and    $0x1,%eax
80100239:	85 c0                	test   %eax,%eax
8010023b:	75 0d                	jne    8010024a <brelse+0x1f>
    panic("brelse");
8010023d:	83 ec 0c             	sub    $0xc,%esp
80100240:	68 4b 87 10 80       	push   $0x8010874b
80100245:	e8 12 03 00 00       	call   8010055c <panic>

  acquire(&bcache.lock);
8010024a:	83 ec 0c             	sub    $0xc,%esp
8010024d:	68 40 c8 10 80       	push   $0x8010c840
80100252:	e8 f0 4f 00 00       	call   80105247 <acquire>
80100257:	83 c4 10             	add    $0x10,%esp

  b->next->prev = b->prev;
8010025a:	8b 45 08             	mov    0x8(%ebp),%eax
8010025d:	8b 40 10             	mov    0x10(%eax),%eax
80100260:	8b 55 08             	mov    0x8(%ebp),%edx
80100263:	8b 52 0c             	mov    0xc(%edx),%edx
80100266:	89 50 0c             	mov    %edx,0xc(%eax)
  b->prev->next = b->next;
80100269:	8b 45 08             	mov    0x8(%ebp),%eax
8010026c:	8b 40 0c             	mov    0xc(%eax),%eax
8010026f:	8b 55 08             	mov    0x8(%ebp),%edx
80100272:	8b 52 10             	mov    0x10(%edx),%edx
80100275:	89 50 10             	mov    %edx,0x10(%eax)
  b->next = bcache.head.next;
80100278:	8b 15 54 07 11 80    	mov    0x80110754,%edx
8010027e:	8b 45 08             	mov    0x8(%ebp),%eax
80100281:	89 50 10             	mov    %edx,0x10(%eax)
  b->prev = &bcache.head;
80100284:	8b 45 08             	mov    0x8(%ebp),%eax
80100287:	c7 40 0c 44 07 11 80 	movl   $0x80110744,0xc(%eax)
  bcache.head.next->prev = b;
8010028e:	a1 54 07 11 80       	mov    0x80110754,%eax
80100293:	8b 55 08             	mov    0x8(%ebp),%edx
80100296:	89 50 0c             	mov    %edx,0xc(%eax)
  bcache.head.next = b;
80100299:	8b 45 08             	mov    0x8(%ebp),%eax
8010029c:	a3 54 07 11 80       	mov    %eax,0x80110754

  b->flags &= ~B_BUSY;
801002a1:	8b 45 08             	mov    0x8(%ebp),%eax
801002a4:	8b 00                	mov    (%eax),%eax
801002a6:	83 e0 fe             	and    $0xfffffffe,%eax
801002a9:	89 c2                	mov    %eax,%edx
801002ab:	8b 45 08             	mov    0x8(%ebp),%eax
801002ae:	89 10                	mov    %edx,(%eax)
  wakeup(b);
801002b0:	83 ec 0c             	sub    $0xc,%esp
801002b3:	ff 75 08             	pushl  0x8(%ebp)
801002b6:	e8 72 4d 00 00       	call   8010502d <wakeup>
801002bb:	83 c4 10             	add    $0x10,%esp

  release(&bcache.lock);
801002be:	83 ec 0c             	sub    $0xc,%esp
801002c1:	68 40 c8 10 80       	push   $0x8010c840
801002c6:	e8 e2 4f 00 00       	call   801052ad <release>
801002cb:	83 c4 10             	add    $0x10,%esp
}
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
80100309:	c9                   	leave  
8010030a:	c3                   	ret    

8010030b <cli>:
  asm volatile("movw %0, %%gs" : : "r" (v));
}

static inline void
cli(void)
{
8010030b:	55                   	push   %ebp
8010030c:	89 e5                	mov    %esp,%ebp
  asm volatile("cli");
8010030e:	fa                   	cli    
}
8010030f:	5d                   	pop    %ebp
80100310:	c3                   	ret    

80100311 <printint>:
  int locking;
} cons;

static void
printint(int xx, int base, int sign)
{
80100311:	55                   	push   %ebp
80100312:	89 e5                	mov    %esp,%ebp
80100314:	53                   	push   %ebx
80100315:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
80100318:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010031c:	74 1c                	je     8010033a <printint+0x29>
8010031e:	8b 45 08             	mov    0x8(%ebp),%eax
80100321:	c1 e8 1f             	shr    $0x1f,%eax
80100324:	0f b6 c0             	movzbl %al,%eax
80100327:	89 45 10             	mov    %eax,0x10(%ebp)
8010032a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010032e:	74 0a                	je     8010033a <printint+0x29>
    x = -xx;
80100330:	8b 45 08             	mov    0x8(%ebp),%eax
80100333:	f7 d8                	neg    %eax
80100335:	89 45 f0             	mov    %eax,-0x10(%ebp)
80100338:	eb 06                	jmp    80100340 <printint+0x2f>
  else
    x = xx;
8010033a:	8b 45 08             	mov    0x8(%ebp),%eax
8010033d:	89 45 f0             	mov    %eax,-0x10(%ebp)

  i = 0;
80100340:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
80100347:	8b 4d f4             	mov    -0xc(%ebp),%ecx
8010034a:	8d 41 01             	lea    0x1(%ecx),%eax
8010034d:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100350:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80100353:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100356:	ba 00 00 00 00       	mov    $0x0,%edx
8010035b:	f7 f3                	div    %ebx
8010035d:	89 d0                	mov    %edx,%eax
8010035f:	0f b6 80 04 90 10 80 	movzbl -0x7fef6ffc(%eax),%eax
80100366:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
  }while((x /= base) != 0);
8010036a:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010036d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100370:	ba 00 00 00 00       	mov    $0x0,%edx
80100375:	f7 f3                	div    %ebx
80100377:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010037a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010037e:	75 c7                	jne    80100347 <printint+0x36>

  if(sign)
80100380:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80100384:	74 0e                	je     80100394 <printint+0x83>
    buf[i++] = '-';
80100386:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100389:	8d 50 01             	lea    0x1(%eax),%edx
8010038c:	89 55 f4             	mov    %edx,-0xc(%ebp)
8010038f:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)

  while(--i >= 0)
80100394:	eb 1a                	jmp    801003b0 <printint+0x9f>
    consputc(buf[i]);
80100396:	8d 55 e0             	lea    -0x20(%ebp),%edx
80100399:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010039c:	01 d0                	add    %edx,%eax
8010039e:	0f b6 00             	movzbl (%eax),%eax
801003a1:	0f be c0             	movsbl %al,%eax
801003a4:	83 ec 0c             	sub    $0xc,%esp
801003a7:	50                   	push   %eax
801003a8:	e8 be 03 00 00       	call   8010076b <consputc>
801003ad:	83 c4 10             	add    $0x10,%esp
  }while((x /= base) != 0);

  if(sign)
    buf[i++] = '-';

  while(--i >= 0)
801003b0:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
801003b4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801003b8:	79 dc                	jns    80100396 <printint+0x85>
    consputc(buf[i]);
}
801003ba:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801003bd:	c9                   	leave  
801003be:	c3                   	ret    

801003bf <cprintf>:
//PAGEBREAK: 50

// Print to the console. only understands %d, %x, %p, %s.
void
cprintf(char *fmt, ...)
{
801003bf:	55                   	push   %ebp
801003c0:	89 e5                	mov    %esp,%ebp
801003c2:	83 ec 28             	sub    $0x28,%esp
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
801003c5:	a1 14 b6 10 80       	mov    0x8010b614,%eax
801003ca:	89 45 e8             	mov    %eax,-0x18(%ebp)
  if(locking)
801003cd:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
801003d1:	74 10                	je     801003e3 <cprintf+0x24>
    acquire(&cons.lock);
801003d3:	83 ec 0c             	sub    $0xc,%esp
801003d6:	68 e0 b5 10 80       	push   $0x8010b5e0
801003db:	e8 67 4e 00 00       	call   80105247 <acquire>
801003e0:	83 c4 10             	add    $0x10,%esp

  if (fmt == 0)
801003e3:	8b 45 08             	mov    0x8(%ebp),%eax
801003e6:	85 c0                	test   %eax,%eax
801003e8:	75 0d                	jne    801003f7 <cprintf+0x38>
    panic("null fmt");
801003ea:	83 ec 0c             	sub    $0xc,%esp
801003ed:	68 52 87 10 80       	push   $0x80108752
801003f2:	e8 65 01 00 00       	call   8010055c <panic>

  argp = (uint*)(void*)(&fmt + 1);
801003f7:	8d 45 0c             	lea    0xc(%ebp),%eax
801003fa:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801003fd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80100404:	e9 1b 01 00 00       	jmp    80100524 <cprintf+0x165>
    if(c != '%'){
80100409:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
8010040d:	74 13                	je     80100422 <cprintf+0x63>
      consputc(c);
8010040f:	83 ec 0c             	sub    $0xc,%esp
80100412:	ff 75 e4             	pushl  -0x1c(%ebp)
80100415:	e8 51 03 00 00       	call   8010076b <consputc>
8010041a:	83 c4 10             	add    $0x10,%esp
      continue;
8010041d:	e9 fe 00 00 00       	jmp    80100520 <cprintf+0x161>
    }
    c = fmt[++i] & 0xff;
80100422:	8b 55 08             	mov    0x8(%ebp),%edx
80100425:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100429:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010042c:	01 d0                	add    %edx,%eax
8010042e:	0f b6 00             	movzbl (%eax),%eax
80100431:	0f be c0             	movsbl %al,%eax
80100434:	25 ff 00 00 00       	and    $0xff,%eax
80100439:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(c == 0)
8010043c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
80100440:	75 05                	jne    80100447 <cprintf+0x88>
      break;
80100442:	e9 fd 00 00 00       	jmp    80100544 <cprintf+0x185>
    switch(c){
80100447:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010044a:	83 f8 70             	cmp    $0x70,%eax
8010044d:	74 47                	je     80100496 <cprintf+0xd7>
8010044f:	83 f8 70             	cmp    $0x70,%eax
80100452:	7f 13                	jg     80100467 <cprintf+0xa8>
80100454:	83 f8 25             	cmp    $0x25,%eax
80100457:	0f 84 98 00 00 00    	je     801004f5 <cprintf+0x136>
8010045d:	83 f8 64             	cmp    $0x64,%eax
80100460:	74 14                	je     80100476 <cprintf+0xb7>
80100462:	e9 9d 00 00 00       	jmp    80100504 <cprintf+0x145>
80100467:	83 f8 73             	cmp    $0x73,%eax
8010046a:	74 47                	je     801004b3 <cprintf+0xf4>
8010046c:	83 f8 78             	cmp    $0x78,%eax
8010046f:	74 25                	je     80100496 <cprintf+0xd7>
80100471:	e9 8e 00 00 00       	jmp    80100504 <cprintf+0x145>
    case 'd':
      printint(*argp++, 10, 1);
80100476:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100479:	8d 50 04             	lea    0x4(%eax),%edx
8010047c:	89 55 f0             	mov    %edx,-0x10(%ebp)
8010047f:	8b 00                	mov    (%eax),%eax
80100481:	83 ec 04             	sub    $0x4,%esp
80100484:	6a 01                	push   $0x1
80100486:	6a 0a                	push   $0xa
80100488:	50                   	push   %eax
80100489:	e8 83 fe ff ff       	call   80100311 <printint>
8010048e:	83 c4 10             	add    $0x10,%esp
      break;
80100491:	e9 8a 00 00 00       	jmp    80100520 <cprintf+0x161>
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
80100496:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100499:	8d 50 04             	lea    0x4(%eax),%edx
8010049c:	89 55 f0             	mov    %edx,-0x10(%ebp)
8010049f:	8b 00                	mov    (%eax),%eax
801004a1:	83 ec 04             	sub    $0x4,%esp
801004a4:	6a 00                	push   $0x0
801004a6:	6a 10                	push   $0x10
801004a8:	50                   	push   %eax
801004a9:	e8 63 fe ff ff       	call   80100311 <printint>
801004ae:	83 c4 10             	add    $0x10,%esp
      break;
801004b1:	eb 6d                	jmp    80100520 <cprintf+0x161>
    case 's':
      if((s = (char*)*argp++) == 0)
801004b3:	8b 45 f0             	mov    -0x10(%ebp),%eax
801004b6:	8d 50 04             	lea    0x4(%eax),%edx
801004b9:	89 55 f0             	mov    %edx,-0x10(%ebp)
801004bc:	8b 00                	mov    (%eax),%eax
801004be:	89 45 ec             	mov    %eax,-0x14(%ebp)
801004c1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
801004c5:	75 07                	jne    801004ce <cprintf+0x10f>
        s = "(null)";
801004c7:	c7 45 ec 5b 87 10 80 	movl   $0x8010875b,-0x14(%ebp)
      for(; *s; s++)
801004ce:	eb 19                	jmp    801004e9 <cprintf+0x12a>
        consputc(*s);
801004d0:	8b 45 ec             	mov    -0x14(%ebp),%eax
801004d3:	0f b6 00             	movzbl (%eax),%eax
801004d6:	0f be c0             	movsbl %al,%eax
801004d9:	83 ec 0c             	sub    $0xc,%esp
801004dc:	50                   	push   %eax
801004dd:	e8 89 02 00 00       	call   8010076b <consputc>
801004e2:	83 c4 10             	add    $0x10,%esp
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
        s = "(null)";
      for(; *s; s++)
801004e5:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
801004e9:	8b 45 ec             	mov    -0x14(%ebp),%eax
801004ec:	0f b6 00             	movzbl (%eax),%eax
801004ef:	84 c0                	test   %al,%al
801004f1:	75 dd                	jne    801004d0 <cprintf+0x111>
        consputc(*s);
      break;
801004f3:	eb 2b                	jmp    80100520 <cprintf+0x161>
    case '%':
      consputc('%');
801004f5:	83 ec 0c             	sub    $0xc,%esp
801004f8:	6a 25                	push   $0x25
801004fa:	e8 6c 02 00 00       	call   8010076b <consputc>
801004ff:	83 c4 10             	add    $0x10,%esp
      break;
80100502:	eb 1c                	jmp    80100520 <cprintf+0x161>
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
80100504:	83 ec 0c             	sub    $0xc,%esp
80100507:	6a 25                	push   $0x25
80100509:	e8 5d 02 00 00       	call   8010076b <consputc>
8010050e:	83 c4 10             	add    $0x10,%esp
      consputc(c);
80100511:	83 ec 0c             	sub    $0xc,%esp
80100514:	ff 75 e4             	pushl  -0x1c(%ebp)
80100517:	e8 4f 02 00 00       	call   8010076b <consputc>
8010051c:	83 c4 10             	add    $0x10,%esp
      break;
8010051f:	90                   	nop

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100520:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100524:	8b 55 08             	mov    0x8(%ebp),%edx
80100527:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010052a:	01 d0                	add    %edx,%eax
8010052c:	0f b6 00             	movzbl (%eax),%eax
8010052f:	0f be c0             	movsbl %al,%eax
80100532:	25 ff 00 00 00       	and    $0xff,%eax
80100537:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010053a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
8010053e:	0f 85 c5 fe ff ff    	jne    80100409 <cprintf+0x4a>
      consputc(c);
      break;
    }
  }

  if(locking)
80100544:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
80100548:	74 10                	je     8010055a <cprintf+0x19b>
    release(&cons.lock);
8010054a:	83 ec 0c             	sub    $0xc,%esp
8010054d:	68 e0 b5 10 80       	push   $0x8010b5e0
80100552:	e8 56 4d 00 00       	call   801052ad <release>
80100557:	83 c4 10             	add    $0x10,%esp
}
8010055a:	c9                   	leave  
8010055b:	c3                   	ret    

8010055c <panic>:

void
panic(char *s)
{
8010055c:	55                   	push   %ebp
8010055d:	89 e5                	mov    %esp,%ebp
8010055f:	83 ec 38             	sub    $0x38,%esp
  int i;
  uint pcs[10];
  
  cli();
80100562:	e8 a4 fd ff ff       	call   8010030b <cli>
  cons.locking = 0;
80100567:	c7 05 14 b6 10 80 00 	movl   $0x0,0x8010b614
8010056e:	00 00 00 
  cprintf("cpu%d: panic: ", cpu->id);
80100571:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80100577:	0f b6 00             	movzbl (%eax),%eax
8010057a:	0f b6 c0             	movzbl %al,%eax
8010057d:	83 ec 08             	sub    $0x8,%esp
80100580:	50                   	push   %eax
80100581:	68 62 87 10 80       	push   $0x80108762
80100586:	e8 34 fe ff ff       	call   801003bf <cprintf>
8010058b:	83 c4 10             	add    $0x10,%esp
  cprintf(s);
8010058e:	8b 45 08             	mov    0x8(%ebp),%eax
80100591:	83 ec 0c             	sub    $0xc,%esp
80100594:	50                   	push   %eax
80100595:	e8 25 fe ff ff       	call   801003bf <cprintf>
8010059a:	83 c4 10             	add    $0x10,%esp
  cprintf("\n");
8010059d:	83 ec 0c             	sub    $0xc,%esp
801005a0:	68 71 87 10 80       	push   $0x80108771
801005a5:	e8 15 fe ff ff       	call   801003bf <cprintf>
801005aa:	83 c4 10             	add    $0x10,%esp
  getcallerpcs(&s, pcs);
801005ad:	83 ec 08             	sub    $0x8,%esp
801005b0:	8d 45 cc             	lea    -0x34(%ebp),%eax
801005b3:	50                   	push   %eax
801005b4:	8d 45 08             	lea    0x8(%ebp),%eax
801005b7:	50                   	push   %eax
801005b8:	e8 41 4d 00 00       	call   801052fe <getcallerpcs>
801005bd:	83 c4 10             	add    $0x10,%esp
  for(i=0; i<10; i++)
801005c0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801005c7:	eb 1c                	jmp    801005e5 <panic+0x89>
    cprintf(" %p", pcs[i]);
801005c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801005cc:	8b 44 85 cc          	mov    -0x34(%ebp,%eax,4),%eax
801005d0:	83 ec 08             	sub    $0x8,%esp
801005d3:	50                   	push   %eax
801005d4:	68 73 87 10 80       	push   $0x80108773
801005d9:	e8 e1 fd ff ff       	call   801003bf <cprintf>
801005de:	83 c4 10             	add    $0x10,%esp
  cons.locking = 0;
  cprintf("cpu%d: panic: ", cpu->id);
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
  for(i=0; i<10; i++)
801005e1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801005e5:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
801005e9:	7e de                	jle    801005c9 <panic+0x6d>
    cprintf(" %p", pcs[i]);
  panicked = 1; // freeze other CPU
801005eb:	c7 05 c0 b5 10 80 01 	movl   $0x1,0x8010b5c0
801005f2:	00 00 00 
  for(;;)
    ;
801005f5:	eb fe                	jmp    801005f5 <panic+0x99>

801005f7 <cgaputc>:
#define CRTPORT 0x3d4
static ushort *crt = (ushort*)P2V(0xb8000);  // CGA memory

static void
cgaputc(int c)
{
801005f7:	55                   	push   %ebp
801005f8:	89 e5                	mov    %esp,%ebp
801005fa:	83 ec 18             	sub    $0x18,%esp
  int pos;
  
  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
801005fd:	6a 0e                	push   $0xe
801005ff:	68 d4 03 00 00       	push   $0x3d4
80100604:	e8 e4 fc ff ff       	call   801002ed <outb>
80100609:	83 c4 08             	add    $0x8,%esp
  pos = inb(CRTPORT+1) << 8;
8010060c:	68 d5 03 00 00       	push   $0x3d5
80100611:	e8 ba fc ff ff       	call   801002d0 <inb>
80100616:	83 c4 04             	add    $0x4,%esp
80100619:	0f b6 c0             	movzbl %al,%eax
8010061c:	c1 e0 08             	shl    $0x8,%eax
8010061f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  outb(CRTPORT, 15);
80100622:	6a 0f                	push   $0xf
80100624:	68 d4 03 00 00       	push   $0x3d4
80100629:	e8 bf fc ff ff       	call   801002ed <outb>
8010062e:	83 c4 08             	add    $0x8,%esp
  pos |= inb(CRTPORT+1);
80100631:	68 d5 03 00 00       	push   $0x3d5
80100636:	e8 95 fc ff ff       	call   801002d0 <inb>
8010063b:	83 c4 04             	add    $0x4,%esp
8010063e:	0f b6 c0             	movzbl %al,%eax
80100641:	09 45 f4             	or     %eax,-0xc(%ebp)

  if(c == '\n')
80100644:	83 7d 08 0a          	cmpl   $0xa,0x8(%ebp)
80100648:	75 30                	jne    8010067a <cgaputc+0x83>
    pos += 80 - pos%80;
8010064a:	8b 4d f4             	mov    -0xc(%ebp),%ecx
8010064d:	ba 67 66 66 66       	mov    $0x66666667,%edx
80100652:	89 c8                	mov    %ecx,%eax
80100654:	f7 ea                	imul   %edx
80100656:	c1 fa 05             	sar    $0x5,%edx
80100659:	89 c8                	mov    %ecx,%eax
8010065b:	c1 f8 1f             	sar    $0x1f,%eax
8010065e:	29 c2                	sub    %eax,%edx
80100660:	89 d0                	mov    %edx,%eax
80100662:	c1 e0 02             	shl    $0x2,%eax
80100665:	01 d0                	add    %edx,%eax
80100667:	c1 e0 04             	shl    $0x4,%eax
8010066a:	29 c1                	sub    %eax,%ecx
8010066c:	89 ca                	mov    %ecx,%edx
8010066e:	b8 50 00 00 00       	mov    $0x50,%eax
80100673:	29 d0                	sub    %edx,%eax
80100675:	01 45 f4             	add    %eax,-0xc(%ebp)
80100678:	eb 34                	jmp    801006ae <cgaputc+0xb7>
  else if(c == BACKSPACE){
8010067a:	81 7d 08 00 01 00 00 	cmpl   $0x100,0x8(%ebp)
80100681:	75 0c                	jne    8010068f <cgaputc+0x98>
    if(pos > 0) --pos;
80100683:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80100687:	7e 25                	jle    801006ae <cgaputc+0xb7>
80100689:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
8010068d:	eb 1f                	jmp    801006ae <cgaputc+0xb7>
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
8010068f:	8b 0d 00 90 10 80    	mov    0x80109000,%ecx
80100695:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100698:	8d 50 01             	lea    0x1(%eax),%edx
8010069b:	89 55 f4             	mov    %edx,-0xc(%ebp)
8010069e:	01 c0                	add    %eax,%eax
801006a0:	01 c8                	add    %ecx,%eax
801006a2:	8b 55 08             	mov    0x8(%ebp),%edx
801006a5:	0f b6 d2             	movzbl %dl,%edx
801006a8:	80 ce 07             	or     $0x7,%dh
801006ab:	66 89 10             	mov    %dx,(%eax)
  
  if((pos/80) >= 24){  // Scroll up.
801006ae:	81 7d f4 7f 07 00 00 	cmpl   $0x77f,-0xc(%ebp)
801006b5:	7e 4c                	jle    80100703 <cgaputc+0x10c>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801006b7:	a1 00 90 10 80       	mov    0x80109000,%eax
801006bc:	8d 90 a0 00 00 00    	lea    0xa0(%eax),%edx
801006c2:	a1 00 90 10 80       	mov    0x80109000,%eax
801006c7:	83 ec 04             	sub    $0x4,%esp
801006ca:	68 60 0e 00 00       	push   $0xe60
801006cf:	52                   	push   %edx
801006d0:	50                   	push   %eax
801006d1:	e8 8c 4e 00 00       	call   80105562 <memmove>
801006d6:	83 c4 10             	add    $0x10,%esp
    pos -= 80;
801006d9:	83 6d f4 50          	subl   $0x50,-0xc(%ebp)
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
801006dd:	b8 80 07 00 00       	mov    $0x780,%eax
801006e2:	2b 45 f4             	sub    -0xc(%ebp),%eax
801006e5:	8d 14 00             	lea    (%eax,%eax,1),%edx
801006e8:	a1 00 90 10 80       	mov    0x80109000,%eax
801006ed:	8b 4d f4             	mov    -0xc(%ebp),%ecx
801006f0:	01 c9                	add    %ecx,%ecx
801006f2:	01 c8                	add    %ecx,%eax
801006f4:	83 ec 04             	sub    $0x4,%esp
801006f7:	52                   	push   %edx
801006f8:	6a 00                	push   $0x0
801006fa:	50                   	push   %eax
801006fb:	e8 a3 4d 00 00       	call   801054a3 <memset>
80100700:	83 c4 10             	add    $0x10,%esp
  }
  
  outb(CRTPORT, 14);
80100703:	83 ec 08             	sub    $0x8,%esp
80100706:	6a 0e                	push   $0xe
80100708:	68 d4 03 00 00       	push   $0x3d4
8010070d:	e8 db fb ff ff       	call   801002ed <outb>
80100712:	83 c4 10             	add    $0x10,%esp
  outb(CRTPORT+1, pos>>8);
80100715:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100718:	c1 f8 08             	sar    $0x8,%eax
8010071b:	0f b6 c0             	movzbl %al,%eax
8010071e:	83 ec 08             	sub    $0x8,%esp
80100721:	50                   	push   %eax
80100722:	68 d5 03 00 00       	push   $0x3d5
80100727:	e8 c1 fb ff ff       	call   801002ed <outb>
8010072c:	83 c4 10             	add    $0x10,%esp
  outb(CRTPORT, 15);
8010072f:	83 ec 08             	sub    $0x8,%esp
80100732:	6a 0f                	push   $0xf
80100734:	68 d4 03 00 00       	push   $0x3d4
80100739:	e8 af fb ff ff       	call   801002ed <outb>
8010073e:	83 c4 10             	add    $0x10,%esp
  outb(CRTPORT+1, pos);
80100741:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100744:	0f b6 c0             	movzbl %al,%eax
80100747:	83 ec 08             	sub    $0x8,%esp
8010074a:	50                   	push   %eax
8010074b:	68 d5 03 00 00       	push   $0x3d5
80100750:	e8 98 fb ff ff       	call   801002ed <outb>
80100755:	83 c4 10             	add    $0x10,%esp
  crt[pos] = ' ' | 0x0700;
80100758:	a1 00 90 10 80       	mov    0x80109000,%eax
8010075d:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100760:	01 d2                	add    %edx,%edx
80100762:	01 d0                	add    %edx,%eax
80100764:	66 c7 00 20 07       	movw   $0x720,(%eax)
}
80100769:	c9                   	leave  
8010076a:	c3                   	ret    

8010076b <consputc>:

void
consputc(int c)
{
8010076b:	55                   	push   %ebp
8010076c:	89 e5                	mov    %esp,%ebp
8010076e:	83 ec 08             	sub    $0x8,%esp
  if(panicked){
80100771:	a1 c0 b5 10 80       	mov    0x8010b5c0,%eax
80100776:	85 c0                	test   %eax,%eax
80100778:	74 07                	je     80100781 <consputc+0x16>
    cli();
8010077a:	e8 8c fb ff ff       	call   8010030b <cli>
    for(;;)
      ;
8010077f:	eb fe                	jmp    8010077f <consputc+0x14>
  }

  if(c == BACKSPACE){
80100781:	81 7d 08 00 01 00 00 	cmpl   $0x100,0x8(%ebp)
80100788:	75 29                	jne    801007b3 <consputc+0x48>
    uartputc('\b'); uartputc(' '); uartputc('\b');
8010078a:	83 ec 0c             	sub    $0xc,%esp
8010078d:	6a 08                	push   $0x8
8010078f:	e8 2c 66 00 00       	call   80106dc0 <uartputc>
80100794:	83 c4 10             	add    $0x10,%esp
80100797:	83 ec 0c             	sub    $0xc,%esp
8010079a:	6a 20                	push   $0x20
8010079c:	e8 1f 66 00 00       	call   80106dc0 <uartputc>
801007a1:	83 c4 10             	add    $0x10,%esp
801007a4:	83 ec 0c             	sub    $0xc,%esp
801007a7:	6a 08                	push   $0x8
801007a9:	e8 12 66 00 00       	call   80106dc0 <uartputc>
801007ae:	83 c4 10             	add    $0x10,%esp
801007b1:	eb 0e                	jmp    801007c1 <consputc+0x56>
  } else
    uartputc(c);
801007b3:	83 ec 0c             	sub    $0xc,%esp
801007b6:	ff 75 08             	pushl  0x8(%ebp)
801007b9:	e8 02 66 00 00       	call   80106dc0 <uartputc>
801007be:	83 c4 10             	add    $0x10,%esp
  cgaputc(c);
801007c1:	83 ec 0c             	sub    $0xc,%esp
801007c4:	ff 75 08             	pushl  0x8(%ebp)
801007c7:	e8 2b fe ff ff       	call   801005f7 <cgaputc>
801007cc:	83 c4 10             	add    $0x10,%esp
}
801007cf:	c9                   	leave  
801007d0:	c3                   	ret    

801007d1 <consoleintr>:

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
801007d1:	55                   	push   %ebp
801007d2:	89 e5                	mov    %esp,%ebp
801007d4:	83 ec 18             	sub    $0x18,%esp
  int c;

  acquire(&input.lock);
801007d7:	83 ec 0c             	sub    $0xc,%esp
801007da:	68 80 09 11 80       	push   $0x80110980
801007df:	e8 63 4a 00 00       	call   80105247 <acquire>
801007e4:	83 c4 10             	add    $0x10,%esp
  while((c = getc()) >= 0){
801007e7:	e9 43 01 00 00       	jmp    8010092f <consoleintr+0x15e>
    switch(c){
801007ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
801007ef:	83 f8 10             	cmp    $0x10,%eax
801007f2:	74 1e                	je     80100812 <consoleintr+0x41>
801007f4:	83 f8 10             	cmp    $0x10,%eax
801007f7:	7f 0a                	jg     80100803 <consoleintr+0x32>
801007f9:	83 f8 08             	cmp    $0x8,%eax
801007fc:	74 67                	je     80100865 <consoleintr+0x94>
801007fe:	e9 93 00 00 00       	jmp    80100896 <consoleintr+0xc5>
80100803:	83 f8 15             	cmp    $0x15,%eax
80100806:	74 31                	je     80100839 <consoleintr+0x68>
80100808:	83 f8 7f             	cmp    $0x7f,%eax
8010080b:	74 58                	je     80100865 <consoleintr+0x94>
8010080d:	e9 84 00 00 00       	jmp    80100896 <consoleintr+0xc5>
    case C('P'):  // Process listing.
      procdump();
80100812:	e8 e3 48 00 00       	call   801050fa <procdump>
      break;
80100817:	e9 13 01 00 00       	jmp    8010092f <consoleintr+0x15e>
    case C('U'):  // Kill line.
      while(input.e != input.w &&
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
8010081c:	a1 3c 0a 11 80       	mov    0x80110a3c,%eax
80100821:	83 e8 01             	sub    $0x1,%eax
80100824:	a3 3c 0a 11 80       	mov    %eax,0x80110a3c
        consputc(BACKSPACE);
80100829:	83 ec 0c             	sub    $0xc,%esp
8010082c:	68 00 01 00 00       	push   $0x100
80100831:	e8 35 ff ff ff       	call   8010076b <consputc>
80100836:	83 c4 10             	add    $0x10,%esp
    switch(c){
    case C('P'):  // Process listing.
      procdump();
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
80100839:	8b 15 3c 0a 11 80    	mov    0x80110a3c,%edx
8010083f:	a1 38 0a 11 80       	mov    0x80110a38,%eax
80100844:	39 c2                	cmp    %eax,%edx
80100846:	74 18                	je     80100860 <consoleintr+0x8f>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100848:	a1 3c 0a 11 80       	mov    0x80110a3c,%eax
8010084d:	83 e8 01             	sub    $0x1,%eax
80100850:	83 e0 7f             	and    $0x7f,%eax
80100853:	05 80 09 11 80       	add    $0x80110980,%eax
80100858:	0f b6 40 34          	movzbl 0x34(%eax),%eax
    switch(c){
    case C('P'):  // Process listing.
      procdump();
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
8010085c:	3c 0a                	cmp    $0xa,%al
8010085e:	75 bc                	jne    8010081c <consoleintr+0x4b>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
        consputc(BACKSPACE);
      }
      break;
80100860:	e9 ca 00 00 00       	jmp    8010092f <consoleintr+0x15e>
    case C('H'): case '\x7f':  // Backspace
      if(input.e != input.w){
80100865:	8b 15 3c 0a 11 80    	mov    0x80110a3c,%edx
8010086b:	a1 38 0a 11 80       	mov    0x80110a38,%eax
80100870:	39 c2                	cmp    %eax,%edx
80100872:	74 1d                	je     80100891 <consoleintr+0xc0>
        input.e--;
80100874:	a1 3c 0a 11 80       	mov    0x80110a3c,%eax
80100879:	83 e8 01             	sub    $0x1,%eax
8010087c:	a3 3c 0a 11 80       	mov    %eax,0x80110a3c
        consputc(BACKSPACE);
80100881:	83 ec 0c             	sub    $0xc,%esp
80100884:	68 00 01 00 00       	push   $0x100
80100889:	e8 dd fe ff ff       	call   8010076b <consputc>
8010088e:	83 c4 10             	add    $0x10,%esp
      }
      break;
80100891:	e9 99 00 00 00       	jmp    8010092f <consoleintr+0x15e>
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100896:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010089a:	0f 84 8e 00 00 00    	je     8010092e <consoleintr+0x15d>
801008a0:	8b 15 3c 0a 11 80    	mov    0x80110a3c,%edx
801008a6:	a1 34 0a 11 80       	mov    0x80110a34,%eax
801008ab:	29 c2                	sub    %eax,%edx
801008ad:	89 d0                	mov    %edx,%eax
801008af:	83 f8 7f             	cmp    $0x7f,%eax
801008b2:	77 7a                	ja     8010092e <consoleintr+0x15d>
        c = (c == '\r') ? '\n' : c;
801008b4:	83 7d f4 0d          	cmpl   $0xd,-0xc(%ebp)
801008b8:	74 05                	je     801008bf <consoleintr+0xee>
801008ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
801008bd:	eb 05                	jmp    801008c4 <consoleintr+0xf3>
801008bf:	b8 0a 00 00 00       	mov    $0xa,%eax
801008c4:	89 45 f4             	mov    %eax,-0xc(%ebp)
        input.buf[input.e++ % INPUT_BUF] = c;
801008c7:	a1 3c 0a 11 80       	mov    0x80110a3c,%eax
801008cc:	8d 50 01             	lea    0x1(%eax),%edx
801008cf:	89 15 3c 0a 11 80    	mov    %edx,0x80110a3c
801008d5:	83 e0 7f             	and    $0x7f,%eax
801008d8:	89 c2                	mov    %eax,%edx
801008da:	8b 45 f4             	mov    -0xc(%ebp),%eax
801008dd:	89 c1                	mov    %eax,%ecx
801008df:	8d 82 80 09 11 80    	lea    -0x7feef680(%edx),%eax
801008e5:	88 48 34             	mov    %cl,0x34(%eax)
        consputc(c);
801008e8:	83 ec 0c             	sub    $0xc,%esp
801008eb:	ff 75 f4             	pushl  -0xc(%ebp)
801008ee:	e8 78 fe ff ff       	call   8010076b <consputc>
801008f3:	83 c4 10             	add    $0x10,%esp
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801008f6:	83 7d f4 0a          	cmpl   $0xa,-0xc(%ebp)
801008fa:	74 18                	je     80100914 <consoleintr+0x143>
801008fc:	83 7d f4 04          	cmpl   $0x4,-0xc(%ebp)
80100900:	74 12                	je     80100914 <consoleintr+0x143>
80100902:	a1 3c 0a 11 80       	mov    0x80110a3c,%eax
80100907:	8b 15 34 0a 11 80    	mov    0x80110a34,%edx
8010090d:	83 ea 80             	sub    $0xffffff80,%edx
80100910:	39 d0                	cmp    %edx,%eax
80100912:	75 1a                	jne    8010092e <consoleintr+0x15d>
          input.w = input.e;
80100914:	a1 3c 0a 11 80       	mov    0x80110a3c,%eax
80100919:	a3 38 0a 11 80       	mov    %eax,0x80110a38
          wakeup(&input.r);
8010091e:	83 ec 0c             	sub    $0xc,%esp
80100921:	68 34 0a 11 80       	push   $0x80110a34
80100926:	e8 02 47 00 00       	call   8010502d <wakeup>
8010092b:	83 c4 10             	add    $0x10,%esp
        }
      }
      break;
8010092e:	90                   	nop
consoleintr(int (*getc)(void))
{
  int c;

  acquire(&input.lock);
  while((c = getc()) >= 0){
8010092f:	8b 45 08             	mov    0x8(%ebp),%eax
80100932:	ff d0                	call   *%eax
80100934:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100937:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010093b:	0f 89 ab fe ff ff    	jns    801007ec <consoleintr+0x1b>
        }
      }
      break;
    }
  }
  release(&input.lock);
80100941:	83 ec 0c             	sub    $0xc,%esp
80100944:	68 80 09 11 80       	push   $0x80110980
80100949:	e8 5f 49 00 00       	call   801052ad <release>
8010094e:	83 c4 10             	add    $0x10,%esp
}
80100951:	c9                   	leave  
80100952:	c3                   	ret    

80100953 <consoleread>:

int
consoleread(struct inode *ip, char *dst, int n)
{
80100953:	55                   	push   %ebp
80100954:	89 e5                	mov    %esp,%ebp
80100956:	83 ec 18             	sub    $0x18,%esp
  uint target;
  int c;

  iunlock(ip);
80100959:	83 ec 0c             	sub    $0xc,%esp
8010095c:	ff 75 08             	pushl  0x8(%ebp)
8010095f:	e8 22 11 00 00       	call   80101a86 <iunlock>
80100964:	83 c4 10             	add    $0x10,%esp
  target = n;
80100967:	8b 45 10             	mov    0x10(%ebp),%eax
8010096a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  acquire(&input.lock);
8010096d:	83 ec 0c             	sub    $0xc,%esp
80100970:	68 80 09 11 80       	push   $0x80110980
80100975:	e8 cd 48 00 00       	call   80105247 <acquire>
8010097a:	83 c4 10             	add    $0x10,%esp
  while(n > 0){
8010097d:	e9 b4 00 00 00       	jmp    80100a36 <consoleread+0xe3>
    while(input.r == input.w){
80100982:	eb 4a                	jmp    801009ce <consoleread+0x7b>
      if(proc->killed){
80100984:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010098a:	8b 40 24             	mov    0x24(%eax),%eax
8010098d:	85 c0                	test   %eax,%eax
8010098f:	74 28                	je     801009b9 <consoleread+0x66>
        release(&input.lock);
80100991:	83 ec 0c             	sub    $0xc,%esp
80100994:	68 80 09 11 80       	push   $0x80110980
80100999:	e8 0f 49 00 00       	call   801052ad <release>
8010099e:	83 c4 10             	add    $0x10,%esp
        ilock(ip);
801009a1:	83 ec 0c             	sub    $0xc,%esp
801009a4:	ff 75 08             	pushl  0x8(%ebp)
801009a7:	e8 7d 0f 00 00       	call   80101929 <ilock>
801009ac:	83 c4 10             	add    $0x10,%esp
        return -1;
801009af:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801009b4:	e9 af 00 00 00       	jmp    80100a68 <consoleread+0x115>
      }
      sleep(&input.r, &input.lock);
801009b9:	83 ec 08             	sub    $0x8,%esp
801009bc:	68 80 09 11 80       	push   $0x80110980
801009c1:	68 34 0a 11 80       	push   $0x80110a34
801009c6:	e8 56 45 00 00       	call   80104f21 <sleep>
801009cb:	83 c4 10             	add    $0x10,%esp

  iunlock(ip);
  target = n;
  acquire(&input.lock);
  while(n > 0){
    while(input.r == input.w){
801009ce:	8b 15 34 0a 11 80    	mov    0x80110a34,%edx
801009d4:	a1 38 0a 11 80       	mov    0x80110a38,%eax
801009d9:	39 c2                	cmp    %eax,%edx
801009db:	74 a7                	je     80100984 <consoleread+0x31>
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &input.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
801009dd:	a1 34 0a 11 80       	mov    0x80110a34,%eax
801009e2:	8d 50 01             	lea    0x1(%eax),%edx
801009e5:	89 15 34 0a 11 80    	mov    %edx,0x80110a34
801009eb:	83 e0 7f             	and    $0x7f,%eax
801009ee:	05 80 09 11 80       	add    $0x80110980,%eax
801009f3:	0f b6 40 34          	movzbl 0x34(%eax),%eax
801009f7:	0f be c0             	movsbl %al,%eax
801009fa:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(c == C('D')){  // EOF
801009fd:	83 7d f0 04          	cmpl   $0x4,-0x10(%ebp)
80100a01:	75 19                	jne    80100a1c <consoleread+0xc9>
      if(n < target){
80100a03:	8b 45 10             	mov    0x10(%ebp),%eax
80100a06:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80100a09:	73 0f                	jae    80100a1a <consoleread+0xc7>
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
80100a0b:	a1 34 0a 11 80       	mov    0x80110a34,%eax
80100a10:	83 e8 01             	sub    $0x1,%eax
80100a13:	a3 34 0a 11 80       	mov    %eax,0x80110a34
      }
      break;
80100a18:	eb 26                	jmp    80100a40 <consoleread+0xed>
80100a1a:	eb 24                	jmp    80100a40 <consoleread+0xed>
    }
    *dst++ = c;
80100a1c:	8b 45 0c             	mov    0xc(%ebp),%eax
80100a1f:	8d 50 01             	lea    0x1(%eax),%edx
80100a22:	89 55 0c             	mov    %edx,0xc(%ebp)
80100a25:	8b 55 f0             	mov    -0x10(%ebp),%edx
80100a28:	88 10                	mov    %dl,(%eax)
    --n;
80100a2a:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    if(c == '\n')
80100a2e:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
80100a32:	75 02                	jne    80100a36 <consoleread+0xe3>
      break;
80100a34:	eb 0a                	jmp    80100a40 <consoleread+0xed>
  int c;

  iunlock(ip);
  target = n;
  acquire(&input.lock);
  while(n > 0){
80100a36:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80100a3a:	0f 8f 42 ff ff ff    	jg     80100982 <consoleread+0x2f>
    *dst++ = c;
    --n;
    if(c == '\n')
      break;
  }
  release(&input.lock);
80100a40:	83 ec 0c             	sub    $0xc,%esp
80100a43:	68 80 09 11 80       	push   $0x80110980
80100a48:	e8 60 48 00 00       	call   801052ad <release>
80100a4d:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80100a50:	83 ec 0c             	sub    $0xc,%esp
80100a53:	ff 75 08             	pushl  0x8(%ebp)
80100a56:	e8 ce 0e 00 00       	call   80101929 <ilock>
80100a5b:	83 c4 10             	add    $0x10,%esp

  return target - n;
80100a5e:	8b 45 10             	mov    0x10(%ebp),%eax
80100a61:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100a64:	29 c2                	sub    %eax,%edx
80100a66:	89 d0                	mov    %edx,%eax
}
80100a68:	c9                   	leave  
80100a69:	c3                   	ret    

80100a6a <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100a6a:	55                   	push   %ebp
80100a6b:	89 e5                	mov    %esp,%ebp
80100a6d:	83 ec 18             	sub    $0x18,%esp
  int i;

  iunlock(ip);
80100a70:	83 ec 0c             	sub    $0xc,%esp
80100a73:	ff 75 08             	pushl  0x8(%ebp)
80100a76:	e8 0b 10 00 00       	call   80101a86 <iunlock>
80100a7b:	83 c4 10             	add    $0x10,%esp
  acquire(&cons.lock);
80100a7e:	83 ec 0c             	sub    $0xc,%esp
80100a81:	68 e0 b5 10 80       	push   $0x8010b5e0
80100a86:	e8 bc 47 00 00       	call   80105247 <acquire>
80100a8b:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < n; i++)
80100a8e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80100a95:	eb 21                	jmp    80100ab8 <consolewrite+0x4e>
    consputc(buf[i] & 0xff);
80100a97:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100a9a:	8b 45 0c             	mov    0xc(%ebp),%eax
80100a9d:	01 d0                	add    %edx,%eax
80100a9f:	0f b6 00             	movzbl (%eax),%eax
80100aa2:	0f be c0             	movsbl %al,%eax
80100aa5:	0f b6 c0             	movzbl %al,%eax
80100aa8:	83 ec 0c             	sub    $0xc,%esp
80100aab:	50                   	push   %eax
80100aac:	e8 ba fc ff ff       	call   8010076b <consputc>
80100ab1:	83 c4 10             	add    $0x10,%esp
{
  int i;

  iunlock(ip);
  acquire(&cons.lock);
  for(i = 0; i < n; i++)
80100ab4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100ab8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100abb:	3b 45 10             	cmp    0x10(%ebp),%eax
80100abe:	7c d7                	jl     80100a97 <consolewrite+0x2d>
    consputc(buf[i] & 0xff);
  release(&cons.lock);
80100ac0:	83 ec 0c             	sub    $0xc,%esp
80100ac3:	68 e0 b5 10 80       	push   $0x8010b5e0
80100ac8:	e8 e0 47 00 00       	call   801052ad <release>
80100acd:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80100ad0:	83 ec 0c             	sub    $0xc,%esp
80100ad3:	ff 75 08             	pushl  0x8(%ebp)
80100ad6:	e8 4e 0e 00 00       	call   80101929 <ilock>
80100adb:	83 c4 10             	add    $0x10,%esp

  return n;
80100ade:	8b 45 10             	mov    0x10(%ebp),%eax
}
80100ae1:	c9                   	leave  
80100ae2:	c3                   	ret    

80100ae3 <consoleinit>:

void
consoleinit(void)
{
80100ae3:	55                   	push   %ebp
80100ae4:	89 e5                	mov    %esp,%ebp
80100ae6:	83 ec 08             	sub    $0x8,%esp
  initlock(&cons.lock, "console");
80100ae9:	83 ec 08             	sub    $0x8,%esp
80100aec:	68 77 87 10 80       	push   $0x80108777
80100af1:	68 e0 b5 10 80       	push   $0x8010b5e0
80100af6:	e8 2b 47 00 00       	call   80105226 <initlock>
80100afb:	83 c4 10             	add    $0x10,%esp
  initlock(&input.lock, "input");
80100afe:	83 ec 08             	sub    $0x8,%esp
80100b01:	68 7f 87 10 80       	push   $0x8010877f
80100b06:	68 80 09 11 80       	push   $0x80110980
80100b0b:	e8 16 47 00 00       	call   80105226 <initlock>
80100b10:	83 c4 10             	add    $0x10,%esp

  devsw[CONSOLE].write = consolewrite;
80100b13:	c7 05 0c 14 11 80 6a 	movl   $0x80100a6a,0x8011140c
80100b1a:	0a 10 80 
  devsw[CONSOLE].read = consoleread;
80100b1d:	c7 05 08 14 11 80 53 	movl   $0x80100953,0x80111408
80100b24:	09 10 80 
  cons.locking = 1;
80100b27:	c7 05 14 b6 10 80 01 	movl   $0x1,0x8010b614
80100b2e:	00 00 00 

  picenable(IRQ_KBD);
80100b31:	83 ec 0c             	sub    $0xc,%esp
80100b34:	6a 01                	push   $0x1
80100b36:	e8 86 33 00 00       	call   80103ec1 <picenable>
80100b3b:	83 c4 10             	add    $0x10,%esp
  ioapicenable(IRQ_KBD, 0);
80100b3e:	83 ec 08             	sub    $0x8,%esp
80100b41:	6a 00                	push   $0x0
80100b43:	6a 01                	push   $0x1
80100b45:	e8 43 1f 00 00       	call   80102a8d <ioapicenable>
80100b4a:	83 c4 10             	add    $0x10,%esp
}
80100b4d:	c9                   	leave  
80100b4e:	c3                   	ret    

80100b4f <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100b4f:	55                   	push   %ebp
80100b50:	89 e5                	mov    %esp,%ebp
80100b52:	81 ec 18 01 00 00    	sub    $0x118,%esp
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;

  begin_op();
80100b58:	e8 90 29 00 00       	call   801034ed <begin_op>
  if((ip = namei(path)) == 0){
80100b5d:	83 ec 0c             	sub    $0xc,%esp
80100b60:	ff 75 08             	pushl  0x8(%ebp)
80100b63:	e8 7c 19 00 00       	call   801024e4 <namei>
80100b68:	83 c4 10             	add    $0x10,%esp
80100b6b:	89 45 d8             	mov    %eax,-0x28(%ebp)
80100b6e:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
80100b72:	75 0f                	jne    80100b83 <exec+0x34>
    end_op();
80100b74:	e8 02 2a 00 00       	call   8010357b <end_op>
    return -1;
80100b79:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100b7e:	e9 b9 03 00 00       	jmp    80100f3c <exec+0x3ed>
  }
  ilock(ip);
80100b83:	83 ec 0c             	sub    $0xc,%esp
80100b86:	ff 75 d8             	pushl  -0x28(%ebp)
80100b89:	e8 9b 0d 00 00       	call   80101929 <ilock>
80100b8e:	83 c4 10             	add    $0x10,%esp
  pgdir = 0;
80100b91:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) < sizeof(elf))
80100b98:	6a 34                	push   $0x34
80100b9a:	6a 00                	push   $0x0
80100b9c:	8d 85 0c ff ff ff    	lea    -0xf4(%ebp),%eax
80100ba2:	50                   	push   %eax
80100ba3:	ff 75 d8             	pushl  -0x28(%ebp)
80100ba6:	e8 e6 12 00 00       	call   80101e91 <readi>
80100bab:	83 c4 10             	add    $0x10,%esp
80100bae:	83 f8 33             	cmp    $0x33,%eax
80100bb1:	77 05                	ja     80100bb8 <exec+0x69>
    goto bad;
80100bb3:	e9 52 03 00 00       	jmp    80100f0a <exec+0x3bb>
  if(elf.magic != ELF_MAGIC)
80100bb8:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100bbe:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
80100bc3:	74 05                	je     80100bca <exec+0x7b>
    goto bad;
80100bc5:	e9 40 03 00 00       	jmp    80100f0a <exec+0x3bb>

  if((pgdir = setupkvm()) == 0)
80100bca:	e8 41 73 00 00       	call   80107f10 <setupkvm>
80100bcf:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80100bd2:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
80100bd6:	75 05                	jne    80100bdd <exec+0x8e>
    goto bad;
80100bd8:	e9 2d 03 00 00       	jmp    80100f0a <exec+0x3bb>

  // Load program into memory.
  sz = 0;
80100bdd:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100be4:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
80100beb:	8b 85 28 ff ff ff    	mov    -0xd8(%ebp),%eax
80100bf1:	89 45 e8             	mov    %eax,-0x18(%ebp)
80100bf4:	e9 ae 00 00 00       	jmp    80100ca7 <exec+0x158>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100bf9:	8b 45 e8             	mov    -0x18(%ebp),%eax
80100bfc:	6a 20                	push   $0x20
80100bfe:	50                   	push   %eax
80100bff:	8d 85 ec fe ff ff    	lea    -0x114(%ebp),%eax
80100c05:	50                   	push   %eax
80100c06:	ff 75 d8             	pushl  -0x28(%ebp)
80100c09:	e8 83 12 00 00       	call   80101e91 <readi>
80100c0e:	83 c4 10             	add    $0x10,%esp
80100c11:	83 f8 20             	cmp    $0x20,%eax
80100c14:	74 05                	je     80100c1b <exec+0xcc>
      goto bad;
80100c16:	e9 ef 02 00 00       	jmp    80100f0a <exec+0x3bb>
    if(ph.type != ELF_PROG_LOAD)
80100c1b:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
80100c21:	83 f8 01             	cmp    $0x1,%eax
80100c24:	74 02                	je     80100c28 <exec+0xd9>
      continue;
80100c26:	eb 72                	jmp    80100c9a <exec+0x14b>
    if(ph.memsz < ph.filesz)
80100c28:	8b 95 00 ff ff ff    	mov    -0x100(%ebp),%edx
80100c2e:	8b 85 fc fe ff ff    	mov    -0x104(%ebp),%eax
80100c34:	39 c2                	cmp    %eax,%edx
80100c36:	73 05                	jae    80100c3d <exec+0xee>
      goto bad;
80100c38:	e9 cd 02 00 00       	jmp    80100f0a <exec+0x3bb>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100c3d:	8b 95 f4 fe ff ff    	mov    -0x10c(%ebp),%edx
80100c43:	8b 85 00 ff ff ff    	mov    -0x100(%ebp),%eax
80100c49:	01 d0                	add    %edx,%eax
80100c4b:	83 ec 04             	sub    $0x4,%esp
80100c4e:	50                   	push   %eax
80100c4f:	ff 75 e0             	pushl  -0x20(%ebp)
80100c52:	ff 75 d4             	pushl  -0x2c(%ebp)
80100c55:	e8 59 76 00 00       	call   801082b3 <allocuvm>
80100c5a:	83 c4 10             	add    $0x10,%esp
80100c5d:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100c60:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80100c64:	75 05                	jne    80100c6b <exec+0x11c>
      goto bad;
80100c66:	e9 9f 02 00 00       	jmp    80100f0a <exec+0x3bb>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100c6b:	8b 95 fc fe ff ff    	mov    -0x104(%ebp),%edx
80100c71:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100c77:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
80100c7d:	83 ec 0c             	sub    $0xc,%esp
80100c80:	52                   	push   %edx
80100c81:	50                   	push   %eax
80100c82:	ff 75 d8             	pushl  -0x28(%ebp)
80100c85:	51                   	push   %ecx
80100c86:	ff 75 d4             	pushl  -0x2c(%ebp)
80100c89:	e8 4e 75 00 00       	call   801081dc <loaduvm>
80100c8e:	83 c4 20             	add    $0x20,%esp
80100c91:	85 c0                	test   %eax,%eax
80100c93:	79 05                	jns    80100c9a <exec+0x14b>
      goto bad;
80100c95:	e9 70 02 00 00       	jmp    80100f0a <exec+0x3bb>
  if((pgdir = setupkvm()) == 0)
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100c9a:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
80100c9e:	8b 45 e8             	mov    -0x18(%ebp),%eax
80100ca1:	83 c0 20             	add    $0x20,%eax
80100ca4:	89 45 e8             	mov    %eax,-0x18(%ebp)
80100ca7:	0f b7 85 38 ff ff ff 	movzwl -0xc8(%ebp),%eax
80100cae:	0f b7 c0             	movzwl %ax,%eax
80100cb1:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80100cb4:	0f 8f 3f ff ff ff    	jg     80100bf9 <exec+0xaa>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
      goto bad;
  }
  iunlockput(ip);
80100cba:	83 ec 0c             	sub    $0xc,%esp
80100cbd:	ff 75 d8             	pushl  -0x28(%ebp)
80100cc0:	e8 21 0f 00 00       	call   80101be6 <iunlockput>
80100cc5:	83 c4 10             	add    $0x10,%esp
  end_op();
80100cc8:	e8 ae 28 00 00       	call   8010357b <end_op>
  ip = 0;
80100ccd:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
80100cd4:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100cd7:	05 ff 0f 00 00       	add    $0xfff,%eax
80100cdc:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80100ce1:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100ce4:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100ce7:	05 00 20 00 00       	add    $0x2000,%eax
80100cec:	83 ec 04             	sub    $0x4,%esp
80100cef:	50                   	push   %eax
80100cf0:	ff 75 e0             	pushl  -0x20(%ebp)
80100cf3:	ff 75 d4             	pushl  -0x2c(%ebp)
80100cf6:	e8 b8 75 00 00       	call   801082b3 <allocuvm>
80100cfb:	83 c4 10             	add    $0x10,%esp
80100cfe:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100d01:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80100d05:	75 05                	jne    80100d0c <exec+0x1bd>
    goto bad;
80100d07:	e9 fe 01 00 00       	jmp    80100f0a <exec+0x3bb>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100d0c:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100d0f:	2d 00 20 00 00       	sub    $0x2000,%eax
80100d14:	83 ec 08             	sub    $0x8,%esp
80100d17:	50                   	push   %eax
80100d18:	ff 75 d4             	pushl  -0x2c(%ebp)
80100d1b:	e8 b8 77 00 00       	call   801084d8 <clearpteu>
80100d20:	83 c4 10             	add    $0x10,%esp
  sp = sz;
80100d23:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100d26:	89 45 dc             	mov    %eax,-0x24(%ebp)

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100d29:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80100d30:	e9 98 00 00 00       	jmp    80100dcd <exec+0x27e>
    if(argc >= MAXARG)
80100d35:	83 7d e4 1f          	cmpl   $0x1f,-0x1c(%ebp)
80100d39:	76 05                	jbe    80100d40 <exec+0x1f1>
      goto bad;
80100d3b:	e9 ca 01 00 00       	jmp    80100f0a <exec+0x3bb>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100d40:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100d43:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100d4a:	8b 45 0c             	mov    0xc(%ebp),%eax
80100d4d:	01 d0                	add    %edx,%eax
80100d4f:	8b 00                	mov    (%eax),%eax
80100d51:	83 ec 0c             	sub    $0xc,%esp
80100d54:	50                   	push   %eax
80100d55:	e8 98 49 00 00       	call   801056f2 <strlen>
80100d5a:	83 c4 10             	add    $0x10,%esp
80100d5d:	89 c2                	mov    %eax,%edx
80100d5f:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100d62:	29 d0                	sub    %edx,%eax
80100d64:	83 e8 01             	sub    $0x1,%eax
80100d67:	83 e0 fc             	and    $0xfffffffc,%eax
80100d6a:	89 45 dc             	mov    %eax,-0x24(%ebp)
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100d6d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100d70:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100d77:	8b 45 0c             	mov    0xc(%ebp),%eax
80100d7a:	01 d0                	add    %edx,%eax
80100d7c:	8b 00                	mov    (%eax),%eax
80100d7e:	83 ec 0c             	sub    $0xc,%esp
80100d81:	50                   	push   %eax
80100d82:	e8 6b 49 00 00       	call   801056f2 <strlen>
80100d87:	83 c4 10             	add    $0x10,%esp
80100d8a:	83 c0 01             	add    $0x1,%eax
80100d8d:	89 c1                	mov    %eax,%ecx
80100d8f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100d92:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100d99:	8b 45 0c             	mov    0xc(%ebp),%eax
80100d9c:	01 d0                	add    %edx,%eax
80100d9e:	8b 00                	mov    (%eax),%eax
80100da0:	51                   	push   %ecx
80100da1:	50                   	push   %eax
80100da2:	ff 75 dc             	pushl  -0x24(%ebp)
80100da5:	ff 75 d4             	pushl  -0x2c(%ebp)
80100da8:	e8 e1 78 00 00       	call   8010868e <copyout>
80100dad:	83 c4 10             	add    $0x10,%esp
80100db0:	85 c0                	test   %eax,%eax
80100db2:	79 05                	jns    80100db9 <exec+0x26a>
      goto bad;
80100db4:	e9 51 01 00 00       	jmp    80100f0a <exec+0x3bb>
    ustack[3+argc] = sp;
80100db9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100dbc:	8d 50 03             	lea    0x3(%eax),%edx
80100dbf:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100dc2:	89 84 95 40 ff ff ff 	mov    %eax,-0xc0(%ebp,%edx,4)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100dc9:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
80100dcd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100dd0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100dd7:	8b 45 0c             	mov    0xc(%ebp),%eax
80100dda:	01 d0                	add    %edx,%eax
80100ddc:	8b 00                	mov    (%eax),%eax
80100dde:	85 c0                	test   %eax,%eax
80100de0:	0f 85 4f ff ff ff    	jne    80100d35 <exec+0x1e6>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
  }
  ustack[3+argc] = 0;
80100de6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100de9:	83 c0 03             	add    $0x3,%eax
80100dec:	c7 84 85 40 ff ff ff 	movl   $0x0,-0xc0(%ebp,%eax,4)
80100df3:	00 00 00 00 

  ustack[0] = 0xffffffff;  // fake return PC
80100df7:	c7 85 40 ff ff ff ff 	movl   $0xffffffff,-0xc0(%ebp)
80100dfe:	ff ff ff 
  ustack[1] = argc;
80100e01:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100e04:	89 85 44 ff ff ff    	mov    %eax,-0xbc(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100e0a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100e0d:	83 c0 01             	add    $0x1,%eax
80100e10:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100e17:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100e1a:	29 d0                	sub    %edx,%eax
80100e1c:	89 85 48 ff ff ff    	mov    %eax,-0xb8(%ebp)

  sp -= (3+argc+1) * 4;
80100e22:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100e25:	83 c0 04             	add    $0x4,%eax
80100e28:	c1 e0 02             	shl    $0x2,%eax
80100e2b:	29 45 dc             	sub    %eax,-0x24(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100e2e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100e31:	83 c0 04             	add    $0x4,%eax
80100e34:	c1 e0 02             	shl    $0x2,%eax
80100e37:	50                   	push   %eax
80100e38:	8d 85 40 ff ff ff    	lea    -0xc0(%ebp),%eax
80100e3e:	50                   	push   %eax
80100e3f:	ff 75 dc             	pushl  -0x24(%ebp)
80100e42:	ff 75 d4             	pushl  -0x2c(%ebp)
80100e45:	e8 44 78 00 00       	call   8010868e <copyout>
80100e4a:	83 c4 10             	add    $0x10,%esp
80100e4d:	85 c0                	test   %eax,%eax
80100e4f:	79 05                	jns    80100e56 <exec+0x307>
    goto bad;
80100e51:	e9 b4 00 00 00       	jmp    80100f0a <exec+0x3bb>

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100e56:	8b 45 08             	mov    0x8(%ebp),%eax
80100e59:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100e5c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100e5f:	89 45 f0             	mov    %eax,-0x10(%ebp)
80100e62:	eb 17                	jmp    80100e7b <exec+0x32c>
    if(*s == '/')
80100e64:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100e67:	0f b6 00             	movzbl (%eax),%eax
80100e6a:	3c 2f                	cmp    $0x2f,%al
80100e6c:	75 09                	jne    80100e77 <exec+0x328>
      last = s+1;
80100e6e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100e71:	83 c0 01             	add    $0x1,%eax
80100e74:	89 45 f0             	mov    %eax,-0x10(%ebp)
  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100e77:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100e7b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100e7e:	0f b6 00             	movzbl (%eax),%eax
80100e81:	84 c0                	test   %al,%al
80100e83:	75 df                	jne    80100e64 <exec+0x315>
    if(*s == '/')
      last = s+1;
  safestrcpy(proc->name, last, sizeof(proc->name));
80100e85:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100e8b:	83 c0 6c             	add    $0x6c,%eax
80100e8e:	83 ec 04             	sub    $0x4,%esp
80100e91:	6a 10                	push   $0x10
80100e93:	ff 75 f0             	pushl  -0x10(%ebp)
80100e96:	50                   	push   %eax
80100e97:	e8 0c 48 00 00       	call   801056a8 <safestrcpy>
80100e9c:	83 c4 10             	add    $0x10,%esp

  // Commit to the user image.
  oldpgdir = proc->pgdir;
80100e9f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100ea5:	8b 40 04             	mov    0x4(%eax),%eax
80100ea8:	89 45 d0             	mov    %eax,-0x30(%ebp)
  proc->pgdir = pgdir;
80100eab:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100eb1:	8b 55 d4             	mov    -0x2c(%ebp),%edx
80100eb4:	89 50 04             	mov    %edx,0x4(%eax)
  proc->sz = sz;
80100eb7:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100ebd:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100ec0:	89 10                	mov    %edx,(%eax)
  proc->tf->eip = elf.entry;  // main
80100ec2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100ec8:	8b 40 18             	mov    0x18(%eax),%eax
80100ecb:	8b 95 24 ff ff ff    	mov    -0xdc(%ebp),%edx
80100ed1:	89 50 38             	mov    %edx,0x38(%eax)
  proc->tf->esp = sp;
80100ed4:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100eda:	8b 40 18             	mov    0x18(%eax),%eax
80100edd:	8b 55 dc             	mov    -0x24(%ebp),%edx
80100ee0:	89 50 44             	mov    %edx,0x44(%eax)
  switchuvm(proc);
80100ee3:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100ee9:	83 ec 0c             	sub    $0xc,%esp
80100eec:	50                   	push   %eax
80100eed:	e8 03 71 00 00       	call   80107ff5 <switchuvm>
80100ef2:	83 c4 10             	add    $0x10,%esp
  freevm(oldpgdir);
80100ef5:	83 ec 0c             	sub    $0xc,%esp
80100ef8:	ff 75 d0             	pushl  -0x30(%ebp)
80100efb:	e8 39 75 00 00       	call   80108439 <freevm>
80100f00:	83 c4 10             	add    $0x10,%esp
  return 0;
80100f03:	b8 00 00 00 00       	mov    $0x0,%eax
80100f08:	eb 32                	jmp    80100f3c <exec+0x3ed>

 bad:
  if(pgdir)
80100f0a:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
80100f0e:	74 0e                	je     80100f1e <exec+0x3cf>
    freevm(pgdir);
80100f10:	83 ec 0c             	sub    $0xc,%esp
80100f13:	ff 75 d4             	pushl  -0x2c(%ebp)
80100f16:	e8 1e 75 00 00       	call   80108439 <freevm>
80100f1b:	83 c4 10             	add    $0x10,%esp
  if(ip){
80100f1e:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
80100f22:	74 13                	je     80100f37 <exec+0x3e8>
    iunlockput(ip);
80100f24:	83 ec 0c             	sub    $0xc,%esp
80100f27:	ff 75 d8             	pushl  -0x28(%ebp)
80100f2a:	e8 b7 0c 00 00       	call   80101be6 <iunlockput>
80100f2f:	83 c4 10             	add    $0x10,%esp
    end_op();
80100f32:	e8 44 26 00 00       	call   8010357b <end_op>
  }
  return -1;
80100f37:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100f3c:	c9                   	leave  
80100f3d:	c3                   	ret    

80100f3e <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100f3e:	55                   	push   %ebp
80100f3f:	89 e5                	mov    %esp,%ebp
80100f41:	83 ec 08             	sub    $0x8,%esp
  initlock(&ftable.lock, "ftable");
80100f44:	83 ec 08             	sub    $0x8,%esp
80100f47:	68 85 87 10 80       	push   $0x80108785
80100f4c:	68 40 0a 11 80       	push   $0x80110a40
80100f51:	e8 d0 42 00 00       	call   80105226 <initlock>
80100f56:	83 c4 10             	add    $0x10,%esp
}
80100f59:	c9                   	leave  
80100f5a:	c3                   	ret    

80100f5b <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100f5b:	55                   	push   %ebp
80100f5c:	89 e5                	mov    %esp,%ebp
80100f5e:	83 ec 18             	sub    $0x18,%esp
  struct file *f;

  acquire(&ftable.lock);
80100f61:	83 ec 0c             	sub    $0xc,%esp
80100f64:	68 40 0a 11 80       	push   $0x80110a40
80100f69:	e8 d9 42 00 00       	call   80105247 <acquire>
80100f6e:	83 c4 10             	add    $0x10,%esp
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100f71:	c7 45 f4 74 0a 11 80 	movl   $0x80110a74,-0xc(%ebp)
80100f78:	eb 2d                	jmp    80100fa7 <filealloc+0x4c>
    if(f->ref == 0){
80100f7a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100f7d:	8b 40 04             	mov    0x4(%eax),%eax
80100f80:	85 c0                	test   %eax,%eax
80100f82:	75 1f                	jne    80100fa3 <filealloc+0x48>
      f->ref = 1;
80100f84:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100f87:	c7 40 04 01 00 00 00 	movl   $0x1,0x4(%eax)
      release(&ftable.lock);
80100f8e:	83 ec 0c             	sub    $0xc,%esp
80100f91:	68 40 0a 11 80       	push   $0x80110a40
80100f96:	e8 12 43 00 00       	call   801052ad <release>
80100f9b:	83 c4 10             	add    $0x10,%esp
      return f;
80100f9e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100fa1:	eb 22                	jmp    80100fc5 <filealloc+0x6a>
filealloc(void)
{
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100fa3:	83 45 f4 18          	addl   $0x18,-0xc(%ebp)
80100fa7:	81 7d f4 d4 13 11 80 	cmpl   $0x801113d4,-0xc(%ebp)
80100fae:	72 ca                	jb     80100f7a <filealloc+0x1f>
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
80100fb0:	83 ec 0c             	sub    $0xc,%esp
80100fb3:	68 40 0a 11 80       	push   $0x80110a40
80100fb8:	e8 f0 42 00 00       	call   801052ad <release>
80100fbd:	83 c4 10             	add    $0x10,%esp
  return 0;
80100fc0:	b8 00 00 00 00       	mov    $0x0,%eax
}
80100fc5:	c9                   	leave  
80100fc6:	c3                   	ret    

80100fc7 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100fc7:	55                   	push   %ebp
80100fc8:	89 e5                	mov    %esp,%ebp
80100fca:	83 ec 08             	sub    $0x8,%esp
  acquire(&ftable.lock);
80100fcd:	83 ec 0c             	sub    $0xc,%esp
80100fd0:	68 40 0a 11 80       	push   $0x80110a40
80100fd5:	e8 6d 42 00 00       	call   80105247 <acquire>
80100fda:	83 c4 10             	add    $0x10,%esp
  if(f->ref < 1)
80100fdd:	8b 45 08             	mov    0x8(%ebp),%eax
80100fe0:	8b 40 04             	mov    0x4(%eax),%eax
80100fe3:	85 c0                	test   %eax,%eax
80100fe5:	7f 0d                	jg     80100ff4 <filedup+0x2d>
    panic("filedup");
80100fe7:	83 ec 0c             	sub    $0xc,%esp
80100fea:	68 8c 87 10 80       	push   $0x8010878c
80100fef:	e8 68 f5 ff ff       	call   8010055c <panic>
  f->ref++;
80100ff4:	8b 45 08             	mov    0x8(%ebp),%eax
80100ff7:	8b 40 04             	mov    0x4(%eax),%eax
80100ffa:	8d 50 01             	lea    0x1(%eax),%edx
80100ffd:	8b 45 08             	mov    0x8(%ebp),%eax
80101000:	89 50 04             	mov    %edx,0x4(%eax)
  release(&ftable.lock);
80101003:	83 ec 0c             	sub    $0xc,%esp
80101006:	68 40 0a 11 80       	push   $0x80110a40
8010100b:	e8 9d 42 00 00       	call   801052ad <release>
80101010:	83 c4 10             	add    $0x10,%esp
  return f;
80101013:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101016:	c9                   	leave  
80101017:	c3                   	ret    

80101018 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80101018:	55                   	push   %ebp
80101019:	89 e5                	mov    %esp,%ebp
8010101b:	83 ec 28             	sub    $0x28,%esp
  struct file ff;

  acquire(&ftable.lock);
8010101e:	83 ec 0c             	sub    $0xc,%esp
80101021:	68 40 0a 11 80       	push   $0x80110a40
80101026:	e8 1c 42 00 00       	call   80105247 <acquire>
8010102b:	83 c4 10             	add    $0x10,%esp
  if(f->ref < 1)
8010102e:	8b 45 08             	mov    0x8(%ebp),%eax
80101031:	8b 40 04             	mov    0x4(%eax),%eax
80101034:	85 c0                	test   %eax,%eax
80101036:	7f 0d                	jg     80101045 <fileclose+0x2d>
    panic("fileclose");
80101038:	83 ec 0c             	sub    $0xc,%esp
8010103b:	68 94 87 10 80       	push   $0x80108794
80101040:	e8 17 f5 ff ff       	call   8010055c <panic>
  if(--f->ref > 0){
80101045:	8b 45 08             	mov    0x8(%ebp),%eax
80101048:	8b 40 04             	mov    0x4(%eax),%eax
8010104b:	8d 50 ff             	lea    -0x1(%eax),%edx
8010104e:	8b 45 08             	mov    0x8(%ebp),%eax
80101051:	89 50 04             	mov    %edx,0x4(%eax)
80101054:	8b 45 08             	mov    0x8(%ebp),%eax
80101057:	8b 40 04             	mov    0x4(%eax),%eax
8010105a:	85 c0                	test   %eax,%eax
8010105c:	7e 15                	jle    80101073 <fileclose+0x5b>
    release(&ftable.lock);
8010105e:	83 ec 0c             	sub    $0xc,%esp
80101061:	68 40 0a 11 80       	push   $0x80110a40
80101066:	e8 42 42 00 00       	call   801052ad <release>
8010106b:	83 c4 10             	add    $0x10,%esp
8010106e:	e9 8b 00 00 00       	jmp    801010fe <fileclose+0xe6>
    return;
  }
  ff = *f;
80101073:	8b 45 08             	mov    0x8(%ebp),%eax
80101076:	8b 10                	mov    (%eax),%edx
80101078:	89 55 e0             	mov    %edx,-0x20(%ebp)
8010107b:	8b 50 04             	mov    0x4(%eax),%edx
8010107e:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101081:	8b 50 08             	mov    0x8(%eax),%edx
80101084:	89 55 e8             	mov    %edx,-0x18(%ebp)
80101087:	8b 50 0c             	mov    0xc(%eax),%edx
8010108a:	89 55 ec             	mov    %edx,-0x14(%ebp)
8010108d:	8b 50 10             	mov    0x10(%eax),%edx
80101090:	89 55 f0             	mov    %edx,-0x10(%ebp)
80101093:	8b 40 14             	mov    0x14(%eax),%eax
80101096:	89 45 f4             	mov    %eax,-0xc(%ebp)
  f->ref = 0;
80101099:	8b 45 08             	mov    0x8(%ebp),%eax
8010109c:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  f->type = FD_NONE;
801010a3:	8b 45 08             	mov    0x8(%ebp),%eax
801010a6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  release(&ftable.lock);
801010ac:	83 ec 0c             	sub    $0xc,%esp
801010af:	68 40 0a 11 80       	push   $0x80110a40
801010b4:	e8 f4 41 00 00       	call   801052ad <release>
801010b9:	83 c4 10             	add    $0x10,%esp
  
  if(ff.type == FD_PIPE)
801010bc:	8b 45 e0             	mov    -0x20(%ebp),%eax
801010bf:	83 f8 01             	cmp    $0x1,%eax
801010c2:	75 19                	jne    801010dd <fileclose+0xc5>
    pipeclose(ff.pipe, ff.writable);
801010c4:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
801010c8:	0f be d0             	movsbl %al,%edx
801010cb:	8b 45 ec             	mov    -0x14(%ebp),%eax
801010ce:	83 ec 08             	sub    $0x8,%esp
801010d1:	52                   	push   %edx
801010d2:	50                   	push   %eax
801010d3:	e8 50 30 00 00       	call   80104128 <pipeclose>
801010d8:	83 c4 10             	add    $0x10,%esp
801010db:	eb 21                	jmp    801010fe <fileclose+0xe6>
  else if(ff.type == FD_INODE){
801010dd:	8b 45 e0             	mov    -0x20(%ebp),%eax
801010e0:	83 f8 02             	cmp    $0x2,%eax
801010e3:	75 19                	jne    801010fe <fileclose+0xe6>
    begin_op();
801010e5:	e8 03 24 00 00       	call   801034ed <begin_op>
    iput(ff.ip);
801010ea:	8b 45 f0             	mov    -0x10(%ebp),%eax
801010ed:	83 ec 0c             	sub    $0xc,%esp
801010f0:	50                   	push   %eax
801010f1:	e8 01 0a 00 00       	call   80101af7 <iput>
801010f6:	83 c4 10             	add    $0x10,%esp
    end_op();
801010f9:	e8 7d 24 00 00       	call   8010357b <end_op>
  }
}
801010fe:	c9                   	leave  
801010ff:	c3                   	ret    

80101100 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80101100:	55                   	push   %ebp
80101101:	89 e5                	mov    %esp,%ebp
80101103:	83 ec 08             	sub    $0x8,%esp
  if(f->type == FD_INODE){
80101106:	8b 45 08             	mov    0x8(%ebp),%eax
80101109:	8b 00                	mov    (%eax),%eax
8010110b:	83 f8 02             	cmp    $0x2,%eax
8010110e:	75 40                	jne    80101150 <filestat+0x50>
    ilock(f->ip);
80101110:	8b 45 08             	mov    0x8(%ebp),%eax
80101113:	8b 40 10             	mov    0x10(%eax),%eax
80101116:	83 ec 0c             	sub    $0xc,%esp
80101119:	50                   	push   %eax
8010111a:	e8 0a 08 00 00       	call   80101929 <ilock>
8010111f:	83 c4 10             	add    $0x10,%esp
    stati(f->ip, st);
80101122:	8b 45 08             	mov    0x8(%ebp),%eax
80101125:	8b 40 10             	mov    0x10(%eax),%eax
80101128:	83 ec 08             	sub    $0x8,%esp
8010112b:	ff 75 0c             	pushl  0xc(%ebp)
8010112e:	50                   	push   %eax
8010112f:	e8 18 0d 00 00       	call   80101e4c <stati>
80101134:	83 c4 10             	add    $0x10,%esp
    iunlock(f->ip);
80101137:	8b 45 08             	mov    0x8(%ebp),%eax
8010113a:	8b 40 10             	mov    0x10(%eax),%eax
8010113d:	83 ec 0c             	sub    $0xc,%esp
80101140:	50                   	push   %eax
80101141:	e8 40 09 00 00       	call   80101a86 <iunlock>
80101146:	83 c4 10             	add    $0x10,%esp
    return 0;
80101149:	b8 00 00 00 00       	mov    $0x0,%eax
8010114e:	eb 05                	jmp    80101155 <filestat+0x55>
  }
  return -1;
80101150:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80101155:	c9                   	leave  
80101156:	c3                   	ret    

80101157 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80101157:	55                   	push   %ebp
80101158:	89 e5                	mov    %esp,%ebp
8010115a:	83 ec 18             	sub    $0x18,%esp
  int r;

  if(f->readable == 0)
8010115d:	8b 45 08             	mov    0x8(%ebp),%eax
80101160:	0f b6 40 08          	movzbl 0x8(%eax),%eax
80101164:	84 c0                	test   %al,%al
80101166:	75 0a                	jne    80101172 <fileread+0x1b>
    return -1;
80101168:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010116d:	e9 9b 00 00 00       	jmp    8010120d <fileread+0xb6>
  if(f->type == FD_PIPE)
80101172:	8b 45 08             	mov    0x8(%ebp),%eax
80101175:	8b 00                	mov    (%eax),%eax
80101177:	83 f8 01             	cmp    $0x1,%eax
8010117a:	75 1a                	jne    80101196 <fileread+0x3f>
    return piperead(f->pipe, addr, n);
8010117c:	8b 45 08             	mov    0x8(%ebp),%eax
8010117f:	8b 40 0c             	mov    0xc(%eax),%eax
80101182:	83 ec 04             	sub    $0x4,%esp
80101185:	ff 75 10             	pushl  0x10(%ebp)
80101188:	ff 75 0c             	pushl  0xc(%ebp)
8010118b:	50                   	push   %eax
8010118c:	e8 44 31 00 00       	call   801042d5 <piperead>
80101191:	83 c4 10             	add    $0x10,%esp
80101194:	eb 77                	jmp    8010120d <fileread+0xb6>
  if(f->type == FD_INODE){
80101196:	8b 45 08             	mov    0x8(%ebp),%eax
80101199:	8b 00                	mov    (%eax),%eax
8010119b:	83 f8 02             	cmp    $0x2,%eax
8010119e:	75 60                	jne    80101200 <fileread+0xa9>
    ilock(f->ip);
801011a0:	8b 45 08             	mov    0x8(%ebp),%eax
801011a3:	8b 40 10             	mov    0x10(%eax),%eax
801011a6:	83 ec 0c             	sub    $0xc,%esp
801011a9:	50                   	push   %eax
801011aa:	e8 7a 07 00 00       	call   80101929 <ilock>
801011af:	83 c4 10             	add    $0x10,%esp
    if((r = readi(f->ip, addr, f->off, n)) > 0)
801011b2:	8b 4d 10             	mov    0x10(%ebp),%ecx
801011b5:	8b 45 08             	mov    0x8(%ebp),%eax
801011b8:	8b 50 14             	mov    0x14(%eax),%edx
801011bb:	8b 45 08             	mov    0x8(%ebp),%eax
801011be:	8b 40 10             	mov    0x10(%eax),%eax
801011c1:	51                   	push   %ecx
801011c2:	52                   	push   %edx
801011c3:	ff 75 0c             	pushl  0xc(%ebp)
801011c6:	50                   	push   %eax
801011c7:	e8 c5 0c 00 00       	call   80101e91 <readi>
801011cc:	83 c4 10             	add    $0x10,%esp
801011cf:	89 45 f4             	mov    %eax,-0xc(%ebp)
801011d2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801011d6:	7e 11                	jle    801011e9 <fileread+0x92>
      f->off += r;
801011d8:	8b 45 08             	mov    0x8(%ebp),%eax
801011db:	8b 50 14             	mov    0x14(%eax),%edx
801011de:	8b 45 f4             	mov    -0xc(%ebp),%eax
801011e1:	01 c2                	add    %eax,%edx
801011e3:	8b 45 08             	mov    0x8(%ebp),%eax
801011e6:	89 50 14             	mov    %edx,0x14(%eax)
    iunlock(f->ip);
801011e9:	8b 45 08             	mov    0x8(%ebp),%eax
801011ec:	8b 40 10             	mov    0x10(%eax),%eax
801011ef:	83 ec 0c             	sub    $0xc,%esp
801011f2:	50                   	push   %eax
801011f3:	e8 8e 08 00 00       	call   80101a86 <iunlock>
801011f8:	83 c4 10             	add    $0x10,%esp
    return r;
801011fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801011fe:	eb 0d                	jmp    8010120d <fileread+0xb6>
  }
  panic("fileread");
80101200:	83 ec 0c             	sub    $0xc,%esp
80101203:	68 9e 87 10 80       	push   $0x8010879e
80101208:	e8 4f f3 ff ff       	call   8010055c <panic>
}
8010120d:	c9                   	leave  
8010120e:	c3                   	ret    

8010120f <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
8010120f:	55                   	push   %ebp
80101210:	89 e5                	mov    %esp,%ebp
80101212:	53                   	push   %ebx
80101213:	83 ec 14             	sub    $0x14,%esp
  int r;

  if(f->writable == 0)
80101216:	8b 45 08             	mov    0x8(%ebp),%eax
80101219:	0f b6 40 09          	movzbl 0x9(%eax),%eax
8010121d:	84 c0                	test   %al,%al
8010121f:	75 0a                	jne    8010122b <filewrite+0x1c>
    return -1;
80101221:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101226:	e9 1a 01 00 00       	jmp    80101345 <filewrite+0x136>
  if(f->type == FD_PIPE)
8010122b:	8b 45 08             	mov    0x8(%ebp),%eax
8010122e:	8b 00                	mov    (%eax),%eax
80101230:	83 f8 01             	cmp    $0x1,%eax
80101233:	75 1d                	jne    80101252 <filewrite+0x43>
    return pipewrite(f->pipe, addr, n);
80101235:	8b 45 08             	mov    0x8(%ebp),%eax
80101238:	8b 40 0c             	mov    0xc(%eax),%eax
8010123b:	83 ec 04             	sub    $0x4,%esp
8010123e:	ff 75 10             	pushl  0x10(%ebp)
80101241:	ff 75 0c             	pushl  0xc(%ebp)
80101244:	50                   	push   %eax
80101245:	e8 87 2f 00 00       	call   801041d1 <pipewrite>
8010124a:	83 c4 10             	add    $0x10,%esp
8010124d:	e9 f3 00 00 00       	jmp    80101345 <filewrite+0x136>
  if(f->type == FD_INODE){
80101252:	8b 45 08             	mov    0x8(%ebp),%eax
80101255:	8b 00                	mov    (%eax),%eax
80101257:	83 f8 02             	cmp    $0x2,%eax
8010125a:	0f 85 d8 00 00 00    	jne    80101338 <filewrite+0x129>
    // the maximum log transaction size, including
    // i-node, indirect block, allocation blocks,
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
80101260:	c7 45 ec 00 1a 00 00 	movl   $0x1a00,-0x14(%ebp)
    int i = 0;
80101267:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while(i < n){
8010126e:	e9 a5 00 00 00       	jmp    80101318 <filewrite+0x109>
      int n1 = n - i;
80101273:	8b 45 10             	mov    0x10(%ebp),%eax
80101276:	2b 45 f4             	sub    -0xc(%ebp),%eax
80101279:	89 45 f0             	mov    %eax,-0x10(%ebp)
      if(n1 > max)
8010127c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010127f:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80101282:	7e 06                	jle    8010128a <filewrite+0x7b>
        n1 = max;
80101284:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101287:	89 45 f0             	mov    %eax,-0x10(%ebp)

      begin_op();
8010128a:	e8 5e 22 00 00       	call   801034ed <begin_op>
      ilock(f->ip);
8010128f:	8b 45 08             	mov    0x8(%ebp),%eax
80101292:	8b 40 10             	mov    0x10(%eax),%eax
80101295:	83 ec 0c             	sub    $0xc,%esp
80101298:	50                   	push   %eax
80101299:	e8 8b 06 00 00       	call   80101929 <ilock>
8010129e:	83 c4 10             	add    $0x10,%esp
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
801012a1:	8b 4d f0             	mov    -0x10(%ebp),%ecx
801012a4:	8b 45 08             	mov    0x8(%ebp),%eax
801012a7:	8b 50 14             	mov    0x14(%eax),%edx
801012aa:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801012ad:	8b 45 0c             	mov    0xc(%ebp),%eax
801012b0:	01 c3                	add    %eax,%ebx
801012b2:	8b 45 08             	mov    0x8(%ebp),%eax
801012b5:	8b 40 10             	mov    0x10(%eax),%eax
801012b8:	51                   	push   %ecx
801012b9:	52                   	push   %edx
801012ba:	53                   	push   %ebx
801012bb:	50                   	push   %eax
801012bc:	e8 2a 0d 00 00       	call   80101feb <writei>
801012c1:	83 c4 10             	add    $0x10,%esp
801012c4:	89 45 e8             	mov    %eax,-0x18(%ebp)
801012c7:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
801012cb:	7e 11                	jle    801012de <filewrite+0xcf>
        f->off += r;
801012cd:	8b 45 08             	mov    0x8(%ebp),%eax
801012d0:	8b 50 14             	mov    0x14(%eax),%edx
801012d3:	8b 45 e8             	mov    -0x18(%ebp),%eax
801012d6:	01 c2                	add    %eax,%edx
801012d8:	8b 45 08             	mov    0x8(%ebp),%eax
801012db:	89 50 14             	mov    %edx,0x14(%eax)
      iunlock(f->ip);
801012de:	8b 45 08             	mov    0x8(%ebp),%eax
801012e1:	8b 40 10             	mov    0x10(%eax),%eax
801012e4:	83 ec 0c             	sub    $0xc,%esp
801012e7:	50                   	push   %eax
801012e8:	e8 99 07 00 00       	call   80101a86 <iunlock>
801012ed:	83 c4 10             	add    $0x10,%esp
      end_op();
801012f0:	e8 86 22 00 00       	call   8010357b <end_op>

      if(r < 0)
801012f5:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
801012f9:	79 02                	jns    801012fd <filewrite+0xee>
        break;
801012fb:	eb 27                	jmp    80101324 <filewrite+0x115>
      if(r != n1)
801012fd:	8b 45 e8             	mov    -0x18(%ebp),%eax
80101300:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80101303:	74 0d                	je     80101312 <filewrite+0x103>
        panic("short filewrite");
80101305:	83 ec 0c             	sub    $0xc,%esp
80101308:	68 a7 87 10 80       	push   $0x801087a7
8010130d:	e8 4a f2 ff ff       	call   8010055c <panic>
      i += r;
80101312:	8b 45 e8             	mov    -0x18(%ebp),%eax
80101315:	01 45 f4             	add    %eax,-0xc(%ebp)
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101318:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010131b:	3b 45 10             	cmp    0x10(%ebp),%eax
8010131e:	0f 8c 4f ff ff ff    	jl     80101273 <filewrite+0x64>
        break;
      if(r != n1)
        panic("short filewrite");
      i += r;
    }
    return i == n ? n : -1;
80101324:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101327:	3b 45 10             	cmp    0x10(%ebp),%eax
8010132a:	75 05                	jne    80101331 <filewrite+0x122>
8010132c:	8b 45 10             	mov    0x10(%ebp),%eax
8010132f:	eb 14                	jmp    80101345 <filewrite+0x136>
80101331:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101336:	eb 0d                	jmp    80101345 <filewrite+0x136>
  }
  panic("filewrite");
80101338:	83 ec 0c             	sub    $0xc,%esp
8010133b:	68 b7 87 10 80       	push   $0x801087b7
80101340:	e8 17 f2 ff ff       	call   8010055c <panic>
}
80101345:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101348:	c9                   	leave  
80101349:	c3                   	ret    

8010134a <readsb>:
struct superblock sb;   // there should be one per dev, but we run with one dev

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
8010134a:	55                   	push   %ebp
8010134b:	89 e5                	mov    %esp,%ebp
8010134d:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  
  bp = bread(dev, 1);
80101350:	8b 45 08             	mov    0x8(%ebp),%eax
80101353:	83 ec 08             	sub    $0x8,%esp
80101356:	6a 01                	push   $0x1
80101358:	50                   	push   %eax
80101359:	e8 56 ee ff ff       	call   801001b4 <bread>
8010135e:	83 c4 10             	add    $0x10,%esp
80101361:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memmove(sb, bp->data, sizeof(*sb));
80101364:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101367:	83 c0 18             	add    $0x18,%eax
8010136a:	83 ec 04             	sub    $0x4,%esp
8010136d:	6a 1c                	push   $0x1c
8010136f:	50                   	push   %eax
80101370:	ff 75 0c             	pushl  0xc(%ebp)
80101373:	e8 ea 41 00 00       	call   80105562 <memmove>
80101378:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
8010137b:	83 ec 0c             	sub    $0xc,%esp
8010137e:	ff 75 f4             	pushl  -0xc(%ebp)
80101381:	e8 a5 ee ff ff       	call   8010022b <brelse>
80101386:	83 c4 10             	add    $0x10,%esp
}
80101389:	c9                   	leave  
8010138a:	c3                   	ret    

8010138b <bzero>:

// Zero a block.
static void
bzero(int dev, int bno)
{
8010138b:	55                   	push   %ebp
8010138c:	89 e5                	mov    %esp,%ebp
8010138e:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  
  bp = bread(dev, bno);
80101391:	8b 55 0c             	mov    0xc(%ebp),%edx
80101394:	8b 45 08             	mov    0x8(%ebp),%eax
80101397:	83 ec 08             	sub    $0x8,%esp
8010139a:	52                   	push   %edx
8010139b:	50                   	push   %eax
8010139c:	e8 13 ee ff ff       	call   801001b4 <bread>
801013a1:	83 c4 10             	add    $0x10,%esp
801013a4:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(bp->data, 0, BSIZE);
801013a7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801013aa:	83 c0 18             	add    $0x18,%eax
801013ad:	83 ec 04             	sub    $0x4,%esp
801013b0:	68 00 02 00 00       	push   $0x200
801013b5:	6a 00                	push   $0x0
801013b7:	50                   	push   %eax
801013b8:	e8 e6 40 00 00       	call   801054a3 <memset>
801013bd:	83 c4 10             	add    $0x10,%esp
  log_write(bp);
801013c0:	83 ec 0c             	sub    $0xc,%esp
801013c3:	ff 75 f4             	pushl  -0xc(%ebp)
801013c6:	e8 59 23 00 00       	call   80103724 <log_write>
801013cb:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
801013ce:	83 ec 0c             	sub    $0xc,%esp
801013d1:	ff 75 f4             	pushl  -0xc(%ebp)
801013d4:	e8 52 ee ff ff       	call   8010022b <brelse>
801013d9:	83 c4 10             	add    $0x10,%esp
}
801013dc:	c9                   	leave  
801013dd:	c3                   	ret    

801013de <balloc>:
// Blocks. 

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
801013de:	55                   	push   %ebp
801013df:	89 e5                	mov    %esp,%ebp
801013e1:	83 ec 18             	sub    $0x18,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
801013e4:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(b = 0; b < sb.size; b += BPB){
801013eb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801013f2:	e9 13 01 00 00       	jmp    8010150a <balloc+0x12c>
    bp = bread(dev, BBLOCK(b, sb));
801013f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801013fa:	8d 90 ff 0f 00 00    	lea    0xfff(%eax),%edx
80101400:	85 c0                	test   %eax,%eax
80101402:	0f 48 c2             	cmovs  %edx,%eax
80101405:	c1 f8 0c             	sar    $0xc,%eax
80101408:	89 c2                	mov    %eax,%edx
8010140a:	a1 98 14 11 80       	mov    0x80111498,%eax
8010140f:	01 d0                	add    %edx,%eax
80101411:	83 ec 08             	sub    $0x8,%esp
80101414:	50                   	push   %eax
80101415:	ff 75 08             	pushl  0x8(%ebp)
80101418:	e8 97 ed ff ff       	call   801001b4 <bread>
8010141d:	83 c4 10             	add    $0x10,%esp
80101420:	89 45 ec             	mov    %eax,-0x14(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101423:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
8010142a:	e9 a6 00 00 00       	jmp    801014d5 <balloc+0xf7>
      m = 1 << (bi % 8);
8010142f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101432:	99                   	cltd   
80101433:	c1 ea 1d             	shr    $0x1d,%edx
80101436:	01 d0                	add    %edx,%eax
80101438:	83 e0 07             	and    $0x7,%eax
8010143b:	29 d0                	sub    %edx,%eax
8010143d:	ba 01 00 00 00       	mov    $0x1,%edx
80101442:	89 c1                	mov    %eax,%ecx
80101444:	d3 e2                	shl    %cl,%edx
80101446:	89 d0                	mov    %edx,%eax
80101448:	89 45 e8             	mov    %eax,-0x18(%ebp)
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010144b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010144e:	8d 50 07             	lea    0x7(%eax),%edx
80101451:	85 c0                	test   %eax,%eax
80101453:	0f 48 c2             	cmovs  %edx,%eax
80101456:	c1 f8 03             	sar    $0x3,%eax
80101459:	89 c2                	mov    %eax,%edx
8010145b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010145e:	0f b6 44 10 18       	movzbl 0x18(%eax,%edx,1),%eax
80101463:	0f b6 c0             	movzbl %al,%eax
80101466:	23 45 e8             	and    -0x18(%ebp),%eax
80101469:	85 c0                	test   %eax,%eax
8010146b:	75 64                	jne    801014d1 <balloc+0xf3>
        bp->data[bi/8] |= m;  // Mark block in use.
8010146d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101470:	8d 50 07             	lea    0x7(%eax),%edx
80101473:	85 c0                	test   %eax,%eax
80101475:	0f 48 c2             	cmovs  %edx,%eax
80101478:	c1 f8 03             	sar    $0x3,%eax
8010147b:	8b 55 ec             	mov    -0x14(%ebp),%edx
8010147e:	0f b6 54 02 18       	movzbl 0x18(%edx,%eax,1),%edx
80101483:	89 d1                	mov    %edx,%ecx
80101485:	8b 55 e8             	mov    -0x18(%ebp),%edx
80101488:	09 ca                	or     %ecx,%edx
8010148a:	89 d1                	mov    %edx,%ecx
8010148c:	8b 55 ec             	mov    -0x14(%ebp),%edx
8010148f:	88 4c 02 18          	mov    %cl,0x18(%edx,%eax,1)
        log_write(bp);
80101493:	83 ec 0c             	sub    $0xc,%esp
80101496:	ff 75 ec             	pushl  -0x14(%ebp)
80101499:	e8 86 22 00 00       	call   80103724 <log_write>
8010149e:	83 c4 10             	add    $0x10,%esp
        brelse(bp);
801014a1:	83 ec 0c             	sub    $0xc,%esp
801014a4:	ff 75 ec             	pushl  -0x14(%ebp)
801014a7:	e8 7f ed ff ff       	call   8010022b <brelse>
801014ac:	83 c4 10             	add    $0x10,%esp
        bzero(dev, b + bi);
801014af:	8b 55 f4             	mov    -0xc(%ebp),%edx
801014b2:	8b 45 f0             	mov    -0x10(%ebp),%eax
801014b5:	01 c2                	add    %eax,%edx
801014b7:	8b 45 08             	mov    0x8(%ebp),%eax
801014ba:	83 ec 08             	sub    $0x8,%esp
801014bd:	52                   	push   %edx
801014be:	50                   	push   %eax
801014bf:	e8 c7 fe ff ff       	call   8010138b <bzero>
801014c4:	83 c4 10             	add    $0x10,%esp
        return b + bi;
801014c7:	8b 55 f4             	mov    -0xc(%ebp),%edx
801014ca:	8b 45 f0             	mov    -0x10(%ebp),%eax
801014cd:	01 d0                	add    %edx,%eax
801014cf:	eb 56                	jmp    80101527 <balloc+0x149>
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801014d1:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
801014d5:	81 7d f0 ff 0f 00 00 	cmpl   $0xfff,-0x10(%ebp)
801014dc:	7f 17                	jg     801014f5 <balloc+0x117>
801014de:	8b 55 f4             	mov    -0xc(%ebp),%edx
801014e1:	8b 45 f0             	mov    -0x10(%ebp),%eax
801014e4:	01 d0                	add    %edx,%eax
801014e6:	89 c2                	mov    %eax,%edx
801014e8:	a1 80 14 11 80       	mov    0x80111480,%eax
801014ed:	39 c2                	cmp    %eax,%edx
801014ef:	0f 82 3a ff ff ff    	jb     8010142f <balloc+0x51>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
801014f5:	83 ec 0c             	sub    $0xc,%esp
801014f8:	ff 75 ec             	pushl  -0x14(%ebp)
801014fb:	e8 2b ed ff ff       	call   8010022b <brelse>
80101500:	83 c4 10             	add    $0x10,%esp
{
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80101503:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
8010150a:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010150d:	a1 80 14 11 80       	mov    0x80111480,%eax
80101512:	39 c2                	cmp    %eax,%edx
80101514:	0f 82 dd fe ff ff    	jb     801013f7 <balloc+0x19>
        return b + bi;
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
8010151a:	83 ec 0c             	sub    $0xc,%esp
8010151d:	68 c4 87 10 80       	push   $0x801087c4
80101522:	e8 35 f0 ff ff       	call   8010055c <panic>
}
80101527:	c9                   	leave  
80101528:	c3                   	ret    

80101529 <bfree>:

// Free a disk block.
static void
bfree(int dev, uint b)
{
80101529:	55                   	push   %ebp
8010152a:	89 e5                	mov    %esp,%ebp
8010152c:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  int bi, m;

  readsb(dev, &sb);
8010152f:	83 ec 08             	sub    $0x8,%esp
80101532:	68 80 14 11 80       	push   $0x80111480
80101537:	ff 75 08             	pushl  0x8(%ebp)
8010153a:	e8 0b fe ff ff       	call   8010134a <readsb>
8010153f:	83 c4 10             	add    $0x10,%esp
  bp = bread(dev, BBLOCK(b, sb));
80101542:	8b 45 0c             	mov    0xc(%ebp),%eax
80101545:	c1 e8 0c             	shr    $0xc,%eax
80101548:	89 c2                	mov    %eax,%edx
8010154a:	a1 98 14 11 80       	mov    0x80111498,%eax
8010154f:	01 c2                	add    %eax,%edx
80101551:	8b 45 08             	mov    0x8(%ebp),%eax
80101554:	83 ec 08             	sub    $0x8,%esp
80101557:	52                   	push   %edx
80101558:	50                   	push   %eax
80101559:	e8 56 ec ff ff       	call   801001b4 <bread>
8010155e:	83 c4 10             	add    $0x10,%esp
80101561:	89 45 f4             	mov    %eax,-0xc(%ebp)
  bi = b % BPB;
80101564:	8b 45 0c             	mov    0xc(%ebp),%eax
80101567:	25 ff 0f 00 00       	and    $0xfff,%eax
8010156c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  m = 1 << (bi % 8);
8010156f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101572:	99                   	cltd   
80101573:	c1 ea 1d             	shr    $0x1d,%edx
80101576:	01 d0                	add    %edx,%eax
80101578:	83 e0 07             	and    $0x7,%eax
8010157b:	29 d0                	sub    %edx,%eax
8010157d:	ba 01 00 00 00       	mov    $0x1,%edx
80101582:	89 c1                	mov    %eax,%ecx
80101584:	d3 e2                	shl    %cl,%edx
80101586:	89 d0                	mov    %edx,%eax
80101588:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((bp->data[bi/8] & m) == 0)
8010158b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010158e:	8d 50 07             	lea    0x7(%eax),%edx
80101591:	85 c0                	test   %eax,%eax
80101593:	0f 48 c2             	cmovs  %edx,%eax
80101596:	c1 f8 03             	sar    $0x3,%eax
80101599:	89 c2                	mov    %eax,%edx
8010159b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010159e:	0f b6 44 10 18       	movzbl 0x18(%eax,%edx,1),%eax
801015a3:	0f b6 c0             	movzbl %al,%eax
801015a6:	23 45 ec             	and    -0x14(%ebp),%eax
801015a9:	85 c0                	test   %eax,%eax
801015ab:	75 0d                	jne    801015ba <bfree+0x91>
    panic("freeing free block");
801015ad:	83 ec 0c             	sub    $0xc,%esp
801015b0:	68 da 87 10 80       	push   $0x801087da
801015b5:	e8 a2 ef ff ff       	call   8010055c <panic>
  bp->data[bi/8] &= ~m;
801015ba:	8b 45 f0             	mov    -0x10(%ebp),%eax
801015bd:	8d 50 07             	lea    0x7(%eax),%edx
801015c0:	85 c0                	test   %eax,%eax
801015c2:	0f 48 c2             	cmovs  %edx,%eax
801015c5:	c1 f8 03             	sar    $0x3,%eax
801015c8:	8b 55 f4             	mov    -0xc(%ebp),%edx
801015cb:	0f b6 54 02 18       	movzbl 0x18(%edx,%eax,1),%edx
801015d0:	89 d1                	mov    %edx,%ecx
801015d2:	8b 55 ec             	mov    -0x14(%ebp),%edx
801015d5:	f7 d2                	not    %edx
801015d7:	21 ca                	and    %ecx,%edx
801015d9:	89 d1                	mov    %edx,%ecx
801015db:	8b 55 f4             	mov    -0xc(%ebp),%edx
801015de:	88 4c 02 18          	mov    %cl,0x18(%edx,%eax,1)
  log_write(bp);
801015e2:	83 ec 0c             	sub    $0xc,%esp
801015e5:	ff 75 f4             	pushl  -0xc(%ebp)
801015e8:	e8 37 21 00 00       	call   80103724 <log_write>
801015ed:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
801015f0:	83 ec 0c             	sub    $0xc,%esp
801015f3:	ff 75 f4             	pushl  -0xc(%ebp)
801015f6:	e8 30 ec ff ff       	call   8010022b <brelse>
801015fb:	83 c4 10             	add    $0x10,%esp
}
801015fe:	c9                   	leave  
801015ff:	c3                   	ret    

80101600 <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit(int dev)
{
80101600:	55                   	push   %ebp
80101601:	89 e5                	mov    %esp,%ebp
80101603:	57                   	push   %edi
80101604:	56                   	push   %esi
80101605:	53                   	push   %ebx
80101606:	83 ec 1c             	sub    $0x1c,%esp
  initlock(&icache.lock, "icache");
80101609:	83 ec 08             	sub    $0x8,%esp
8010160c:	68 ed 87 10 80       	push   $0x801087ed
80101611:	68 c0 14 11 80       	push   $0x801114c0
80101616:	e8 0b 3c 00 00       	call   80105226 <initlock>
8010161b:	83 c4 10             	add    $0x10,%esp
  readsb(dev, &sb);
8010161e:	83 ec 08             	sub    $0x8,%esp
80101621:	68 80 14 11 80       	push   $0x80111480
80101626:	ff 75 08             	pushl  0x8(%ebp)
80101629:	e8 1c fd ff ff       	call   8010134a <readsb>
8010162e:	83 c4 10             	add    $0x10,%esp
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d inodestart %d bmap start %d\n", sb.size,
80101631:	a1 98 14 11 80       	mov    0x80111498,%eax
80101636:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101639:	8b 3d 94 14 11 80    	mov    0x80111494,%edi
8010163f:	8b 35 90 14 11 80    	mov    0x80111490,%esi
80101645:	8b 1d 8c 14 11 80    	mov    0x8011148c,%ebx
8010164b:	8b 0d 88 14 11 80    	mov    0x80111488,%ecx
80101651:	8b 15 84 14 11 80    	mov    0x80111484,%edx
80101657:	a1 80 14 11 80       	mov    0x80111480,%eax
8010165c:	ff 75 e4             	pushl  -0x1c(%ebp)
8010165f:	57                   	push   %edi
80101660:	56                   	push   %esi
80101661:	53                   	push   %ebx
80101662:	51                   	push   %ecx
80101663:	52                   	push   %edx
80101664:	50                   	push   %eax
80101665:	68 f4 87 10 80       	push   $0x801087f4
8010166a:	e8 50 ed ff ff       	call   801003bf <cprintf>
8010166f:	83 c4 20             	add    $0x20,%esp
          sb.nblocks, sb.ninodes, sb.nlog, sb.logstart, sb.inodestart, sb.bmapstart);
}
80101672:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101675:	5b                   	pop    %ebx
80101676:	5e                   	pop    %esi
80101677:	5f                   	pop    %edi
80101678:	5d                   	pop    %ebp
80101679:	c3                   	ret    

8010167a <ialloc>:
//PAGEBREAK!
// Allocate a new inode with the given type on device dev.
// A free inode has a type of zero.
struct inode*
ialloc(uint dev, short type)
{
8010167a:	55                   	push   %ebp
8010167b:	89 e5                	mov    %esp,%ebp
8010167d:	83 ec 28             	sub    $0x28,%esp
80101680:	8b 45 0c             	mov    0xc(%ebp),%eax
80101683:	66 89 45 e4          	mov    %ax,-0x1c(%ebp)
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
80101687:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
8010168e:	e9 9e 00 00 00       	jmp    80101731 <ialloc+0xb7>
    bp = bread(dev, IBLOCK(inum, sb));
80101693:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101696:	c1 e8 03             	shr    $0x3,%eax
80101699:	89 c2                	mov    %eax,%edx
8010169b:	a1 94 14 11 80       	mov    0x80111494,%eax
801016a0:	01 d0                	add    %edx,%eax
801016a2:	83 ec 08             	sub    $0x8,%esp
801016a5:	50                   	push   %eax
801016a6:	ff 75 08             	pushl  0x8(%ebp)
801016a9:	e8 06 eb ff ff       	call   801001b4 <bread>
801016ae:	83 c4 10             	add    $0x10,%esp
801016b1:	89 45 f0             	mov    %eax,-0x10(%ebp)
    dip = (struct dinode*)bp->data + inum%IPB;
801016b4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801016b7:	8d 50 18             	lea    0x18(%eax),%edx
801016ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
801016bd:	83 e0 07             	and    $0x7,%eax
801016c0:	c1 e0 06             	shl    $0x6,%eax
801016c3:	01 d0                	add    %edx,%eax
801016c5:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(dip->type == 0){  // a free inode
801016c8:	8b 45 ec             	mov    -0x14(%ebp),%eax
801016cb:	0f b7 00             	movzwl (%eax),%eax
801016ce:	66 85 c0             	test   %ax,%ax
801016d1:	75 4c                	jne    8010171f <ialloc+0xa5>
      memset(dip, 0, sizeof(*dip));
801016d3:	83 ec 04             	sub    $0x4,%esp
801016d6:	6a 40                	push   $0x40
801016d8:	6a 00                	push   $0x0
801016da:	ff 75 ec             	pushl  -0x14(%ebp)
801016dd:	e8 c1 3d 00 00       	call   801054a3 <memset>
801016e2:	83 c4 10             	add    $0x10,%esp
      dip->type = type;
801016e5:	8b 45 ec             	mov    -0x14(%ebp),%eax
801016e8:	0f b7 55 e4          	movzwl -0x1c(%ebp),%edx
801016ec:	66 89 10             	mov    %dx,(%eax)
      log_write(bp);   // mark it allocated on the disk
801016ef:	83 ec 0c             	sub    $0xc,%esp
801016f2:	ff 75 f0             	pushl  -0x10(%ebp)
801016f5:	e8 2a 20 00 00       	call   80103724 <log_write>
801016fa:	83 c4 10             	add    $0x10,%esp
      brelse(bp);
801016fd:	83 ec 0c             	sub    $0xc,%esp
80101700:	ff 75 f0             	pushl  -0x10(%ebp)
80101703:	e8 23 eb ff ff       	call   8010022b <brelse>
80101708:	83 c4 10             	add    $0x10,%esp
      return iget(dev, inum);
8010170b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010170e:	83 ec 08             	sub    $0x8,%esp
80101711:	50                   	push   %eax
80101712:	ff 75 08             	pushl  0x8(%ebp)
80101715:	e8 f6 00 00 00       	call   80101810 <iget>
8010171a:	83 c4 10             	add    $0x10,%esp
8010171d:	eb 2f                	jmp    8010174e <ialloc+0xd4>
    }
    brelse(bp);
8010171f:	83 ec 0c             	sub    $0xc,%esp
80101722:	ff 75 f0             	pushl  -0x10(%ebp)
80101725:	e8 01 eb ff ff       	call   8010022b <brelse>
8010172a:	83 c4 10             	add    $0x10,%esp
{
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
8010172d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80101731:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101734:	a1 88 14 11 80       	mov    0x80111488,%eax
80101739:	39 c2                	cmp    %eax,%edx
8010173b:	0f 82 52 ff ff ff    	jb     80101693 <ialloc+0x19>
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
80101741:	83 ec 0c             	sub    $0xc,%esp
80101744:	68 47 88 10 80       	push   $0x80108847
80101749:	e8 0e ee ff ff       	call   8010055c <panic>
}
8010174e:	c9                   	leave  
8010174f:	c3                   	ret    

80101750 <iupdate>:

// Copy a modified in-memory inode to disk.
void
iupdate(struct inode *ip)
{
80101750:	55                   	push   %ebp
80101751:	89 e5                	mov    %esp,%ebp
80101753:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101756:	8b 45 08             	mov    0x8(%ebp),%eax
80101759:	8b 40 04             	mov    0x4(%eax),%eax
8010175c:	c1 e8 03             	shr    $0x3,%eax
8010175f:	89 c2                	mov    %eax,%edx
80101761:	a1 94 14 11 80       	mov    0x80111494,%eax
80101766:	01 c2                	add    %eax,%edx
80101768:	8b 45 08             	mov    0x8(%ebp),%eax
8010176b:	8b 00                	mov    (%eax),%eax
8010176d:	83 ec 08             	sub    $0x8,%esp
80101770:	52                   	push   %edx
80101771:	50                   	push   %eax
80101772:	e8 3d ea ff ff       	call   801001b4 <bread>
80101777:	83 c4 10             	add    $0x10,%esp
8010177a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  dip = (struct dinode*)bp->data + ip->inum%IPB;
8010177d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101780:	8d 50 18             	lea    0x18(%eax),%edx
80101783:	8b 45 08             	mov    0x8(%ebp),%eax
80101786:	8b 40 04             	mov    0x4(%eax),%eax
80101789:	83 e0 07             	and    $0x7,%eax
8010178c:	c1 e0 06             	shl    $0x6,%eax
8010178f:	01 d0                	add    %edx,%eax
80101791:	89 45 f0             	mov    %eax,-0x10(%ebp)
  dip->type = ip->type;
80101794:	8b 45 08             	mov    0x8(%ebp),%eax
80101797:	0f b7 50 10          	movzwl 0x10(%eax),%edx
8010179b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010179e:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
801017a1:	8b 45 08             	mov    0x8(%ebp),%eax
801017a4:	0f b7 50 12          	movzwl 0x12(%eax),%edx
801017a8:	8b 45 f0             	mov    -0x10(%ebp),%eax
801017ab:	66 89 50 02          	mov    %dx,0x2(%eax)
  dip->minor = ip->minor;
801017af:	8b 45 08             	mov    0x8(%ebp),%eax
801017b2:	0f b7 50 14          	movzwl 0x14(%eax),%edx
801017b6:	8b 45 f0             	mov    -0x10(%ebp),%eax
801017b9:	66 89 50 04          	mov    %dx,0x4(%eax)
  dip->nlink = ip->nlink;
801017bd:	8b 45 08             	mov    0x8(%ebp),%eax
801017c0:	0f b7 50 16          	movzwl 0x16(%eax),%edx
801017c4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801017c7:	66 89 50 06          	mov    %dx,0x6(%eax)
  dip->size = ip->size;
801017cb:	8b 45 08             	mov    0x8(%ebp),%eax
801017ce:	8b 50 18             	mov    0x18(%eax),%edx
801017d1:	8b 45 f0             	mov    -0x10(%ebp),%eax
801017d4:	89 50 08             	mov    %edx,0x8(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801017d7:	8b 45 08             	mov    0x8(%ebp),%eax
801017da:	8d 50 1c             	lea    0x1c(%eax),%edx
801017dd:	8b 45 f0             	mov    -0x10(%ebp),%eax
801017e0:	83 c0 0c             	add    $0xc,%eax
801017e3:	83 ec 04             	sub    $0x4,%esp
801017e6:	6a 34                	push   $0x34
801017e8:	52                   	push   %edx
801017e9:	50                   	push   %eax
801017ea:	e8 73 3d 00 00       	call   80105562 <memmove>
801017ef:	83 c4 10             	add    $0x10,%esp
  log_write(bp);
801017f2:	83 ec 0c             	sub    $0xc,%esp
801017f5:	ff 75 f4             	pushl  -0xc(%ebp)
801017f8:	e8 27 1f 00 00       	call   80103724 <log_write>
801017fd:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
80101800:	83 ec 0c             	sub    $0xc,%esp
80101803:	ff 75 f4             	pushl  -0xc(%ebp)
80101806:	e8 20 ea ff ff       	call   8010022b <brelse>
8010180b:	83 c4 10             	add    $0x10,%esp
}
8010180e:	c9                   	leave  
8010180f:	c3                   	ret    

80101810 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101810:	55                   	push   %ebp
80101811:	89 e5                	mov    %esp,%ebp
80101813:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip, *empty;

  acquire(&icache.lock);
80101816:	83 ec 0c             	sub    $0xc,%esp
80101819:	68 c0 14 11 80       	push   $0x801114c0
8010181e:	e8 24 3a 00 00       	call   80105247 <acquire>
80101823:	83 c4 10             	add    $0x10,%esp

  // Is the inode already cached?
  empty = 0;
80101826:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010182d:	c7 45 f4 f4 14 11 80 	movl   $0x801114f4,-0xc(%ebp)
80101834:	eb 5d                	jmp    80101893 <iget+0x83>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101836:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101839:	8b 40 08             	mov    0x8(%eax),%eax
8010183c:	85 c0                	test   %eax,%eax
8010183e:	7e 39                	jle    80101879 <iget+0x69>
80101840:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101843:	8b 00                	mov    (%eax),%eax
80101845:	3b 45 08             	cmp    0x8(%ebp),%eax
80101848:	75 2f                	jne    80101879 <iget+0x69>
8010184a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010184d:	8b 40 04             	mov    0x4(%eax),%eax
80101850:	3b 45 0c             	cmp    0xc(%ebp),%eax
80101853:	75 24                	jne    80101879 <iget+0x69>
      ip->ref++;
80101855:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101858:	8b 40 08             	mov    0x8(%eax),%eax
8010185b:	8d 50 01             	lea    0x1(%eax),%edx
8010185e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101861:	89 50 08             	mov    %edx,0x8(%eax)
      release(&icache.lock);
80101864:	83 ec 0c             	sub    $0xc,%esp
80101867:	68 c0 14 11 80       	push   $0x801114c0
8010186c:	e8 3c 3a 00 00       	call   801052ad <release>
80101871:	83 c4 10             	add    $0x10,%esp
      return ip;
80101874:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101877:	eb 74                	jmp    801018ed <iget+0xdd>
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101879:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010187d:	75 10                	jne    8010188f <iget+0x7f>
8010187f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101882:	8b 40 08             	mov    0x8(%eax),%eax
80101885:	85 c0                	test   %eax,%eax
80101887:	75 06                	jne    8010188f <iget+0x7f>
      empty = ip;
80101889:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010188c:	89 45 f0             	mov    %eax,-0x10(%ebp)

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010188f:	83 45 f4 50          	addl   $0x50,-0xc(%ebp)
80101893:	81 7d f4 94 24 11 80 	cmpl   $0x80112494,-0xc(%ebp)
8010189a:	72 9a                	jb     80101836 <iget+0x26>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
8010189c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801018a0:	75 0d                	jne    801018af <iget+0x9f>
    panic("iget: no inodes");
801018a2:	83 ec 0c             	sub    $0xc,%esp
801018a5:	68 59 88 10 80       	push   $0x80108859
801018aa:	e8 ad ec ff ff       	call   8010055c <panic>

  ip = empty;
801018af:	8b 45 f0             	mov    -0x10(%ebp),%eax
801018b2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  ip->dev = dev;
801018b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801018b8:	8b 55 08             	mov    0x8(%ebp),%edx
801018bb:	89 10                	mov    %edx,(%eax)
  ip->inum = inum;
801018bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801018c0:	8b 55 0c             	mov    0xc(%ebp),%edx
801018c3:	89 50 04             	mov    %edx,0x4(%eax)
  ip->ref = 1;
801018c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801018c9:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%eax)
  ip->flags = 0;
801018d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801018d3:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  release(&icache.lock);
801018da:	83 ec 0c             	sub    $0xc,%esp
801018dd:	68 c0 14 11 80       	push   $0x801114c0
801018e2:	e8 c6 39 00 00       	call   801052ad <release>
801018e7:	83 c4 10             	add    $0x10,%esp

  return ip;
801018ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801018ed:	c9                   	leave  
801018ee:	c3                   	ret    

801018ef <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
801018ef:	55                   	push   %ebp
801018f0:	89 e5                	mov    %esp,%ebp
801018f2:	83 ec 08             	sub    $0x8,%esp
  acquire(&icache.lock);
801018f5:	83 ec 0c             	sub    $0xc,%esp
801018f8:	68 c0 14 11 80       	push   $0x801114c0
801018fd:	e8 45 39 00 00       	call   80105247 <acquire>
80101902:	83 c4 10             	add    $0x10,%esp
  ip->ref++;
80101905:	8b 45 08             	mov    0x8(%ebp),%eax
80101908:	8b 40 08             	mov    0x8(%eax),%eax
8010190b:	8d 50 01             	lea    0x1(%eax),%edx
8010190e:	8b 45 08             	mov    0x8(%ebp),%eax
80101911:	89 50 08             	mov    %edx,0x8(%eax)
  release(&icache.lock);
80101914:	83 ec 0c             	sub    $0xc,%esp
80101917:	68 c0 14 11 80       	push   $0x801114c0
8010191c:	e8 8c 39 00 00       	call   801052ad <release>
80101921:	83 c4 10             	add    $0x10,%esp
  return ip;
80101924:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101927:	c9                   	leave  
80101928:	c3                   	ret    

80101929 <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void
ilock(struct inode *ip)
{
80101929:	55                   	push   %ebp
8010192a:	89 e5                	mov    %esp,%ebp
8010192c:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
8010192f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80101933:	74 0a                	je     8010193f <ilock+0x16>
80101935:	8b 45 08             	mov    0x8(%ebp),%eax
80101938:	8b 40 08             	mov    0x8(%eax),%eax
8010193b:	85 c0                	test   %eax,%eax
8010193d:	7f 0d                	jg     8010194c <ilock+0x23>
    panic("ilock");
8010193f:	83 ec 0c             	sub    $0xc,%esp
80101942:	68 69 88 10 80       	push   $0x80108869
80101947:	e8 10 ec ff ff       	call   8010055c <panic>

  acquire(&icache.lock);
8010194c:	83 ec 0c             	sub    $0xc,%esp
8010194f:	68 c0 14 11 80       	push   $0x801114c0
80101954:	e8 ee 38 00 00       	call   80105247 <acquire>
80101959:	83 c4 10             	add    $0x10,%esp
  while(ip->flags & I_BUSY)
8010195c:	eb 13                	jmp    80101971 <ilock+0x48>
    sleep(ip, &icache.lock);
8010195e:	83 ec 08             	sub    $0x8,%esp
80101961:	68 c0 14 11 80       	push   $0x801114c0
80101966:	ff 75 08             	pushl  0x8(%ebp)
80101969:	e8 b3 35 00 00       	call   80104f21 <sleep>
8010196e:	83 c4 10             	add    $0x10,%esp

  if(ip == 0 || ip->ref < 1)
    panic("ilock");

  acquire(&icache.lock);
  while(ip->flags & I_BUSY)
80101971:	8b 45 08             	mov    0x8(%ebp),%eax
80101974:	8b 40 0c             	mov    0xc(%eax),%eax
80101977:	83 e0 01             	and    $0x1,%eax
8010197a:	85 c0                	test   %eax,%eax
8010197c:	75 e0                	jne    8010195e <ilock+0x35>
    sleep(ip, &icache.lock);
  ip->flags |= I_BUSY;
8010197e:	8b 45 08             	mov    0x8(%ebp),%eax
80101981:	8b 40 0c             	mov    0xc(%eax),%eax
80101984:	83 c8 01             	or     $0x1,%eax
80101987:	89 c2                	mov    %eax,%edx
80101989:	8b 45 08             	mov    0x8(%ebp),%eax
8010198c:	89 50 0c             	mov    %edx,0xc(%eax)
  release(&icache.lock);
8010198f:	83 ec 0c             	sub    $0xc,%esp
80101992:	68 c0 14 11 80       	push   $0x801114c0
80101997:	e8 11 39 00 00       	call   801052ad <release>
8010199c:	83 c4 10             	add    $0x10,%esp

  if(!(ip->flags & I_VALID)){
8010199f:	8b 45 08             	mov    0x8(%ebp),%eax
801019a2:	8b 40 0c             	mov    0xc(%eax),%eax
801019a5:	83 e0 02             	and    $0x2,%eax
801019a8:	85 c0                	test   %eax,%eax
801019aa:	0f 85 d4 00 00 00    	jne    80101a84 <ilock+0x15b>
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801019b0:	8b 45 08             	mov    0x8(%ebp),%eax
801019b3:	8b 40 04             	mov    0x4(%eax),%eax
801019b6:	c1 e8 03             	shr    $0x3,%eax
801019b9:	89 c2                	mov    %eax,%edx
801019bb:	a1 94 14 11 80       	mov    0x80111494,%eax
801019c0:	01 c2                	add    %eax,%edx
801019c2:	8b 45 08             	mov    0x8(%ebp),%eax
801019c5:	8b 00                	mov    (%eax),%eax
801019c7:	83 ec 08             	sub    $0x8,%esp
801019ca:	52                   	push   %edx
801019cb:	50                   	push   %eax
801019cc:	e8 e3 e7 ff ff       	call   801001b4 <bread>
801019d1:	83 c4 10             	add    $0x10,%esp
801019d4:	89 45 f4             	mov    %eax,-0xc(%ebp)
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801019d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801019da:	8d 50 18             	lea    0x18(%eax),%edx
801019dd:	8b 45 08             	mov    0x8(%ebp),%eax
801019e0:	8b 40 04             	mov    0x4(%eax),%eax
801019e3:	83 e0 07             	and    $0x7,%eax
801019e6:	c1 e0 06             	shl    $0x6,%eax
801019e9:	01 d0                	add    %edx,%eax
801019eb:	89 45 f0             	mov    %eax,-0x10(%ebp)
    ip->type = dip->type;
801019ee:	8b 45 f0             	mov    -0x10(%ebp),%eax
801019f1:	0f b7 10             	movzwl (%eax),%edx
801019f4:	8b 45 08             	mov    0x8(%ebp),%eax
801019f7:	66 89 50 10          	mov    %dx,0x10(%eax)
    ip->major = dip->major;
801019fb:	8b 45 f0             	mov    -0x10(%ebp),%eax
801019fe:	0f b7 50 02          	movzwl 0x2(%eax),%edx
80101a02:	8b 45 08             	mov    0x8(%ebp),%eax
80101a05:	66 89 50 12          	mov    %dx,0x12(%eax)
    ip->minor = dip->minor;
80101a09:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101a0c:	0f b7 50 04          	movzwl 0x4(%eax),%edx
80101a10:	8b 45 08             	mov    0x8(%ebp),%eax
80101a13:	66 89 50 14          	mov    %dx,0x14(%eax)
    ip->nlink = dip->nlink;
80101a17:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101a1a:	0f b7 50 06          	movzwl 0x6(%eax),%edx
80101a1e:	8b 45 08             	mov    0x8(%ebp),%eax
80101a21:	66 89 50 16          	mov    %dx,0x16(%eax)
    ip->size = dip->size;
80101a25:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101a28:	8b 50 08             	mov    0x8(%eax),%edx
80101a2b:	8b 45 08             	mov    0x8(%ebp),%eax
80101a2e:	89 50 18             	mov    %edx,0x18(%eax)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101a31:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101a34:	8d 50 0c             	lea    0xc(%eax),%edx
80101a37:	8b 45 08             	mov    0x8(%ebp),%eax
80101a3a:	83 c0 1c             	add    $0x1c,%eax
80101a3d:	83 ec 04             	sub    $0x4,%esp
80101a40:	6a 34                	push   $0x34
80101a42:	52                   	push   %edx
80101a43:	50                   	push   %eax
80101a44:	e8 19 3b 00 00       	call   80105562 <memmove>
80101a49:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
80101a4c:	83 ec 0c             	sub    $0xc,%esp
80101a4f:	ff 75 f4             	pushl  -0xc(%ebp)
80101a52:	e8 d4 e7 ff ff       	call   8010022b <brelse>
80101a57:	83 c4 10             	add    $0x10,%esp
    ip->flags |= I_VALID;
80101a5a:	8b 45 08             	mov    0x8(%ebp),%eax
80101a5d:	8b 40 0c             	mov    0xc(%eax),%eax
80101a60:	83 c8 02             	or     $0x2,%eax
80101a63:	89 c2                	mov    %eax,%edx
80101a65:	8b 45 08             	mov    0x8(%ebp),%eax
80101a68:	89 50 0c             	mov    %edx,0xc(%eax)
    if(ip->type == 0)
80101a6b:	8b 45 08             	mov    0x8(%ebp),%eax
80101a6e:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80101a72:	66 85 c0             	test   %ax,%ax
80101a75:	75 0d                	jne    80101a84 <ilock+0x15b>
      panic("ilock: no type");
80101a77:	83 ec 0c             	sub    $0xc,%esp
80101a7a:	68 6f 88 10 80       	push   $0x8010886f
80101a7f:	e8 d8 ea ff ff       	call   8010055c <panic>
  }
}
80101a84:	c9                   	leave  
80101a85:	c3                   	ret    

80101a86 <iunlock>:

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
80101a86:	55                   	push   %ebp
80101a87:	89 e5                	mov    %esp,%ebp
80101a89:	83 ec 08             	sub    $0x8,%esp
  if(ip == 0 || !(ip->flags & I_BUSY) || ip->ref < 1)
80101a8c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80101a90:	74 17                	je     80101aa9 <iunlock+0x23>
80101a92:	8b 45 08             	mov    0x8(%ebp),%eax
80101a95:	8b 40 0c             	mov    0xc(%eax),%eax
80101a98:	83 e0 01             	and    $0x1,%eax
80101a9b:	85 c0                	test   %eax,%eax
80101a9d:	74 0a                	je     80101aa9 <iunlock+0x23>
80101a9f:	8b 45 08             	mov    0x8(%ebp),%eax
80101aa2:	8b 40 08             	mov    0x8(%eax),%eax
80101aa5:	85 c0                	test   %eax,%eax
80101aa7:	7f 0d                	jg     80101ab6 <iunlock+0x30>
    panic("iunlock");
80101aa9:	83 ec 0c             	sub    $0xc,%esp
80101aac:	68 7e 88 10 80       	push   $0x8010887e
80101ab1:	e8 a6 ea ff ff       	call   8010055c <panic>

  acquire(&icache.lock);
80101ab6:	83 ec 0c             	sub    $0xc,%esp
80101ab9:	68 c0 14 11 80       	push   $0x801114c0
80101abe:	e8 84 37 00 00       	call   80105247 <acquire>
80101ac3:	83 c4 10             	add    $0x10,%esp
  ip->flags &= ~I_BUSY;
80101ac6:	8b 45 08             	mov    0x8(%ebp),%eax
80101ac9:	8b 40 0c             	mov    0xc(%eax),%eax
80101acc:	83 e0 fe             	and    $0xfffffffe,%eax
80101acf:	89 c2                	mov    %eax,%edx
80101ad1:	8b 45 08             	mov    0x8(%ebp),%eax
80101ad4:	89 50 0c             	mov    %edx,0xc(%eax)
  wakeup(ip);
80101ad7:	83 ec 0c             	sub    $0xc,%esp
80101ada:	ff 75 08             	pushl  0x8(%ebp)
80101add:	e8 4b 35 00 00       	call   8010502d <wakeup>
80101ae2:	83 c4 10             	add    $0x10,%esp
  release(&icache.lock);
80101ae5:	83 ec 0c             	sub    $0xc,%esp
80101ae8:	68 c0 14 11 80       	push   $0x801114c0
80101aed:	e8 bb 37 00 00       	call   801052ad <release>
80101af2:	83 c4 10             	add    $0x10,%esp
}
80101af5:	c9                   	leave  
80101af6:	c3                   	ret    

80101af7 <iput>:
// to it, free the inode (and its content) on disk.
// All calls to iput() must be inside a transaction in
// case it has to free the inode.
void
iput(struct inode *ip)
{
80101af7:	55                   	push   %ebp
80101af8:	89 e5                	mov    %esp,%ebp
80101afa:	83 ec 08             	sub    $0x8,%esp
  acquire(&icache.lock);
80101afd:	83 ec 0c             	sub    $0xc,%esp
80101b00:	68 c0 14 11 80       	push   $0x801114c0
80101b05:	e8 3d 37 00 00       	call   80105247 <acquire>
80101b0a:	83 c4 10             	add    $0x10,%esp
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
80101b0d:	8b 45 08             	mov    0x8(%ebp),%eax
80101b10:	8b 40 08             	mov    0x8(%eax),%eax
80101b13:	83 f8 01             	cmp    $0x1,%eax
80101b16:	0f 85 a9 00 00 00    	jne    80101bc5 <iput+0xce>
80101b1c:	8b 45 08             	mov    0x8(%ebp),%eax
80101b1f:	8b 40 0c             	mov    0xc(%eax),%eax
80101b22:	83 e0 02             	and    $0x2,%eax
80101b25:	85 c0                	test   %eax,%eax
80101b27:	0f 84 98 00 00 00    	je     80101bc5 <iput+0xce>
80101b2d:	8b 45 08             	mov    0x8(%ebp),%eax
80101b30:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80101b34:	66 85 c0             	test   %ax,%ax
80101b37:	0f 85 88 00 00 00    	jne    80101bc5 <iput+0xce>
    // inode has no links and no other references: truncate and free.
    if(ip->flags & I_BUSY)
80101b3d:	8b 45 08             	mov    0x8(%ebp),%eax
80101b40:	8b 40 0c             	mov    0xc(%eax),%eax
80101b43:	83 e0 01             	and    $0x1,%eax
80101b46:	85 c0                	test   %eax,%eax
80101b48:	74 0d                	je     80101b57 <iput+0x60>
      panic("iput busy");
80101b4a:	83 ec 0c             	sub    $0xc,%esp
80101b4d:	68 86 88 10 80       	push   $0x80108886
80101b52:	e8 05 ea ff ff       	call   8010055c <panic>
    ip->flags |= I_BUSY;
80101b57:	8b 45 08             	mov    0x8(%ebp),%eax
80101b5a:	8b 40 0c             	mov    0xc(%eax),%eax
80101b5d:	83 c8 01             	or     $0x1,%eax
80101b60:	89 c2                	mov    %eax,%edx
80101b62:	8b 45 08             	mov    0x8(%ebp),%eax
80101b65:	89 50 0c             	mov    %edx,0xc(%eax)
    release(&icache.lock);
80101b68:	83 ec 0c             	sub    $0xc,%esp
80101b6b:	68 c0 14 11 80       	push   $0x801114c0
80101b70:	e8 38 37 00 00       	call   801052ad <release>
80101b75:	83 c4 10             	add    $0x10,%esp
    itrunc(ip);
80101b78:	83 ec 0c             	sub    $0xc,%esp
80101b7b:	ff 75 08             	pushl  0x8(%ebp)
80101b7e:	e8 a6 01 00 00       	call   80101d29 <itrunc>
80101b83:	83 c4 10             	add    $0x10,%esp
    ip->type = 0;
80101b86:	8b 45 08             	mov    0x8(%ebp),%eax
80101b89:	66 c7 40 10 00 00    	movw   $0x0,0x10(%eax)
    iupdate(ip);
80101b8f:	83 ec 0c             	sub    $0xc,%esp
80101b92:	ff 75 08             	pushl  0x8(%ebp)
80101b95:	e8 b6 fb ff ff       	call   80101750 <iupdate>
80101b9a:	83 c4 10             	add    $0x10,%esp
    acquire(&icache.lock);
80101b9d:	83 ec 0c             	sub    $0xc,%esp
80101ba0:	68 c0 14 11 80       	push   $0x801114c0
80101ba5:	e8 9d 36 00 00       	call   80105247 <acquire>
80101baa:	83 c4 10             	add    $0x10,%esp
    ip->flags = 0;
80101bad:	8b 45 08             	mov    0x8(%ebp),%eax
80101bb0:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    wakeup(ip);
80101bb7:	83 ec 0c             	sub    $0xc,%esp
80101bba:	ff 75 08             	pushl  0x8(%ebp)
80101bbd:	e8 6b 34 00 00       	call   8010502d <wakeup>
80101bc2:	83 c4 10             	add    $0x10,%esp
  }
  ip->ref--;
80101bc5:	8b 45 08             	mov    0x8(%ebp),%eax
80101bc8:	8b 40 08             	mov    0x8(%eax),%eax
80101bcb:	8d 50 ff             	lea    -0x1(%eax),%edx
80101bce:	8b 45 08             	mov    0x8(%ebp),%eax
80101bd1:	89 50 08             	mov    %edx,0x8(%eax)
  release(&icache.lock);
80101bd4:	83 ec 0c             	sub    $0xc,%esp
80101bd7:	68 c0 14 11 80       	push   $0x801114c0
80101bdc:	e8 cc 36 00 00       	call   801052ad <release>
80101be1:	83 c4 10             	add    $0x10,%esp
}
80101be4:	c9                   	leave  
80101be5:	c3                   	ret    

80101be6 <iunlockput>:

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
80101be6:	55                   	push   %ebp
80101be7:	89 e5                	mov    %esp,%ebp
80101be9:	83 ec 08             	sub    $0x8,%esp
  iunlock(ip);
80101bec:	83 ec 0c             	sub    $0xc,%esp
80101bef:	ff 75 08             	pushl  0x8(%ebp)
80101bf2:	e8 8f fe ff ff       	call   80101a86 <iunlock>
80101bf7:	83 c4 10             	add    $0x10,%esp
  iput(ip);
80101bfa:	83 ec 0c             	sub    $0xc,%esp
80101bfd:	ff 75 08             	pushl  0x8(%ebp)
80101c00:	e8 f2 fe ff ff       	call   80101af7 <iput>
80101c05:	83 c4 10             	add    $0x10,%esp
}
80101c08:	c9                   	leave  
80101c09:	c3                   	ret    

80101c0a <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101c0a:	55                   	push   %ebp
80101c0b:	89 e5                	mov    %esp,%ebp
80101c0d:	53                   	push   %ebx
80101c0e:	83 ec 14             	sub    $0x14,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
80101c11:	83 7d 0c 0b          	cmpl   $0xb,0xc(%ebp)
80101c15:	77 42                	ja     80101c59 <bmap+0x4f>
    if((addr = ip->addrs[bn]) == 0)
80101c17:	8b 45 08             	mov    0x8(%ebp),%eax
80101c1a:	8b 55 0c             	mov    0xc(%ebp),%edx
80101c1d:	83 c2 04             	add    $0x4,%edx
80101c20:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
80101c24:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101c27:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101c2b:	75 24                	jne    80101c51 <bmap+0x47>
      ip->addrs[bn] = addr = balloc(ip->dev);
80101c2d:	8b 45 08             	mov    0x8(%ebp),%eax
80101c30:	8b 00                	mov    (%eax),%eax
80101c32:	83 ec 0c             	sub    $0xc,%esp
80101c35:	50                   	push   %eax
80101c36:	e8 a3 f7 ff ff       	call   801013de <balloc>
80101c3b:	83 c4 10             	add    $0x10,%esp
80101c3e:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101c41:	8b 45 08             	mov    0x8(%ebp),%eax
80101c44:	8b 55 0c             	mov    0xc(%ebp),%edx
80101c47:	8d 4a 04             	lea    0x4(%edx),%ecx
80101c4a:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101c4d:	89 54 88 0c          	mov    %edx,0xc(%eax,%ecx,4)
    return addr;
80101c51:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101c54:	e9 cb 00 00 00       	jmp    80101d24 <bmap+0x11a>
  }
  bn -= NDIRECT;
80101c59:	83 6d 0c 0c          	subl   $0xc,0xc(%ebp)

  if(bn < NINDIRECT){
80101c5d:	83 7d 0c 7f          	cmpl   $0x7f,0xc(%ebp)
80101c61:	0f 87 b0 00 00 00    	ja     80101d17 <bmap+0x10d>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
80101c67:	8b 45 08             	mov    0x8(%ebp),%eax
80101c6a:	8b 40 4c             	mov    0x4c(%eax),%eax
80101c6d:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101c70:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101c74:	75 1d                	jne    80101c93 <bmap+0x89>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101c76:	8b 45 08             	mov    0x8(%ebp),%eax
80101c79:	8b 00                	mov    (%eax),%eax
80101c7b:	83 ec 0c             	sub    $0xc,%esp
80101c7e:	50                   	push   %eax
80101c7f:	e8 5a f7 ff ff       	call   801013de <balloc>
80101c84:	83 c4 10             	add    $0x10,%esp
80101c87:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101c8a:	8b 45 08             	mov    0x8(%ebp),%eax
80101c8d:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101c90:	89 50 4c             	mov    %edx,0x4c(%eax)
    bp = bread(ip->dev, addr);
80101c93:	8b 45 08             	mov    0x8(%ebp),%eax
80101c96:	8b 00                	mov    (%eax),%eax
80101c98:	83 ec 08             	sub    $0x8,%esp
80101c9b:	ff 75 f4             	pushl  -0xc(%ebp)
80101c9e:	50                   	push   %eax
80101c9f:	e8 10 e5 ff ff       	call   801001b4 <bread>
80101ca4:	83 c4 10             	add    $0x10,%esp
80101ca7:	89 45 f0             	mov    %eax,-0x10(%ebp)
    a = (uint*)bp->data;
80101caa:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101cad:	83 c0 18             	add    $0x18,%eax
80101cb0:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if((addr = a[bn]) == 0){
80101cb3:	8b 45 0c             	mov    0xc(%ebp),%eax
80101cb6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101cbd:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101cc0:	01 d0                	add    %edx,%eax
80101cc2:	8b 00                	mov    (%eax),%eax
80101cc4:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101cc7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101ccb:	75 37                	jne    80101d04 <bmap+0xfa>
      a[bn] = addr = balloc(ip->dev);
80101ccd:	8b 45 0c             	mov    0xc(%ebp),%eax
80101cd0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101cd7:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101cda:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
80101cdd:	8b 45 08             	mov    0x8(%ebp),%eax
80101ce0:	8b 00                	mov    (%eax),%eax
80101ce2:	83 ec 0c             	sub    $0xc,%esp
80101ce5:	50                   	push   %eax
80101ce6:	e8 f3 f6 ff ff       	call   801013de <balloc>
80101ceb:	83 c4 10             	add    $0x10,%esp
80101cee:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101cf1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101cf4:	89 03                	mov    %eax,(%ebx)
      log_write(bp);
80101cf6:	83 ec 0c             	sub    $0xc,%esp
80101cf9:	ff 75 f0             	pushl  -0x10(%ebp)
80101cfc:	e8 23 1a 00 00       	call   80103724 <log_write>
80101d01:	83 c4 10             	add    $0x10,%esp
    }
    brelse(bp);
80101d04:	83 ec 0c             	sub    $0xc,%esp
80101d07:	ff 75 f0             	pushl  -0x10(%ebp)
80101d0a:	e8 1c e5 ff ff       	call   8010022b <brelse>
80101d0f:	83 c4 10             	add    $0x10,%esp
    return addr;
80101d12:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101d15:	eb 0d                	jmp    80101d24 <bmap+0x11a>
  }

  panic("bmap: out of range");
80101d17:	83 ec 0c             	sub    $0xc,%esp
80101d1a:	68 90 88 10 80       	push   $0x80108890
80101d1f:	e8 38 e8 ff ff       	call   8010055c <panic>
}
80101d24:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101d27:	c9                   	leave  
80101d28:	c3                   	ret    

80101d29 <itrunc>:
// to it (no directory entries referring to it)
// and has no in-memory reference to it (is
// not an open file or current directory).
static void
itrunc(struct inode *ip)
{
80101d29:	55                   	push   %ebp
80101d2a:	89 e5                	mov    %esp,%ebp
80101d2c:	83 ec 18             	sub    $0x18,%esp
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101d2f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80101d36:	eb 45                	jmp    80101d7d <itrunc+0x54>
    if(ip->addrs[i]){
80101d38:	8b 45 08             	mov    0x8(%ebp),%eax
80101d3b:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101d3e:	83 c2 04             	add    $0x4,%edx
80101d41:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
80101d45:	85 c0                	test   %eax,%eax
80101d47:	74 30                	je     80101d79 <itrunc+0x50>
      bfree(ip->dev, ip->addrs[i]);
80101d49:	8b 45 08             	mov    0x8(%ebp),%eax
80101d4c:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101d4f:	83 c2 04             	add    $0x4,%edx
80101d52:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
80101d56:	8b 55 08             	mov    0x8(%ebp),%edx
80101d59:	8b 12                	mov    (%edx),%edx
80101d5b:	83 ec 08             	sub    $0x8,%esp
80101d5e:	50                   	push   %eax
80101d5f:	52                   	push   %edx
80101d60:	e8 c4 f7 ff ff       	call   80101529 <bfree>
80101d65:	83 c4 10             	add    $0x10,%esp
      ip->addrs[i] = 0;
80101d68:	8b 45 08             	mov    0x8(%ebp),%eax
80101d6b:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101d6e:	83 c2 04             	add    $0x4,%edx
80101d71:	c7 44 90 0c 00 00 00 	movl   $0x0,0xc(%eax,%edx,4)
80101d78:	00 
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101d79:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80101d7d:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
80101d81:	7e b5                	jle    80101d38 <itrunc+0xf>
      bfree(ip->dev, ip->addrs[i]);
      ip->addrs[i] = 0;
    }
  }
  
  if(ip->addrs[NDIRECT]){
80101d83:	8b 45 08             	mov    0x8(%ebp),%eax
80101d86:	8b 40 4c             	mov    0x4c(%eax),%eax
80101d89:	85 c0                	test   %eax,%eax
80101d8b:	0f 84 a1 00 00 00    	je     80101e32 <itrunc+0x109>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101d91:	8b 45 08             	mov    0x8(%ebp),%eax
80101d94:	8b 50 4c             	mov    0x4c(%eax),%edx
80101d97:	8b 45 08             	mov    0x8(%ebp),%eax
80101d9a:	8b 00                	mov    (%eax),%eax
80101d9c:	83 ec 08             	sub    $0x8,%esp
80101d9f:	52                   	push   %edx
80101da0:	50                   	push   %eax
80101da1:	e8 0e e4 ff ff       	call   801001b4 <bread>
80101da6:	83 c4 10             	add    $0x10,%esp
80101da9:	89 45 ec             	mov    %eax,-0x14(%ebp)
    a = (uint*)bp->data;
80101dac:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101daf:	83 c0 18             	add    $0x18,%eax
80101db2:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for(j = 0; j < NINDIRECT; j++){
80101db5:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
80101dbc:	eb 3c                	jmp    80101dfa <itrunc+0xd1>
      if(a[j])
80101dbe:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101dc1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101dc8:	8b 45 e8             	mov    -0x18(%ebp),%eax
80101dcb:	01 d0                	add    %edx,%eax
80101dcd:	8b 00                	mov    (%eax),%eax
80101dcf:	85 c0                	test   %eax,%eax
80101dd1:	74 23                	je     80101df6 <itrunc+0xcd>
        bfree(ip->dev, a[j]);
80101dd3:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101dd6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101ddd:	8b 45 e8             	mov    -0x18(%ebp),%eax
80101de0:	01 d0                	add    %edx,%eax
80101de2:	8b 00                	mov    (%eax),%eax
80101de4:	8b 55 08             	mov    0x8(%ebp),%edx
80101de7:	8b 12                	mov    (%edx),%edx
80101de9:	83 ec 08             	sub    $0x8,%esp
80101dec:	50                   	push   %eax
80101ded:	52                   	push   %edx
80101dee:	e8 36 f7 ff ff       	call   80101529 <bfree>
80101df3:	83 c4 10             	add    $0x10,%esp
  }
  
  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    a = (uint*)bp->data;
    for(j = 0; j < NINDIRECT; j++){
80101df6:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
80101dfa:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101dfd:	83 f8 7f             	cmp    $0x7f,%eax
80101e00:	76 bc                	jbe    80101dbe <itrunc+0x95>
      if(a[j])
        bfree(ip->dev, a[j]);
    }
    brelse(bp);
80101e02:	83 ec 0c             	sub    $0xc,%esp
80101e05:	ff 75 ec             	pushl  -0x14(%ebp)
80101e08:	e8 1e e4 ff ff       	call   8010022b <brelse>
80101e0d:	83 c4 10             	add    $0x10,%esp
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101e10:	8b 45 08             	mov    0x8(%ebp),%eax
80101e13:	8b 40 4c             	mov    0x4c(%eax),%eax
80101e16:	8b 55 08             	mov    0x8(%ebp),%edx
80101e19:	8b 12                	mov    (%edx),%edx
80101e1b:	83 ec 08             	sub    $0x8,%esp
80101e1e:	50                   	push   %eax
80101e1f:	52                   	push   %edx
80101e20:	e8 04 f7 ff ff       	call   80101529 <bfree>
80101e25:	83 c4 10             	add    $0x10,%esp
    ip->addrs[NDIRECT] = 0;
80101e28:	8b 45 08             	mov    0x8(%ebp),%eax
80101e2b:	c7 40 4c 00 00 00 00 	movl   $0x0,0x4c(%eax)
  }

  ip->size = 0;
80101e32:	8b 45 08             	mov    0x8(%ebp),%eax
80101e35:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
  iupdate(ip);
80101e3c:	83 ec 0c             	sub    $0xc,%esp
80101e3f:	ff 75 08             	pushl  0x8(%ebp)
80101e42:	e8 09 f9 ff ff       	call   80101750 <iupdate>
80101e47:	83 c4 10             	add    $0x10,%esp
}
80101e4a:	c9                   	leave  
80101e4b:	c3                   	ret    

80101e4c <stati>:

// Copy stat information from inode.
void
stati(struct inode *ip, struct stat *st)
{
80101e4c:	55                   	push   %ebp
80101e4d:	89 e5                	mov    %esp,%ebp
  st->dev = ip->dev;
80101e4f:	8b 45 08             	mov    0x8(%ebp),%eax
80101e52:	8b 00                	mov    (%eax),%eax
80101e54:	89 c2                	mov    %eax,%edx
80101e56:	8b 45 0c             	mov    0xc(%ebp),%eax
80101e59:	89 50 04             	mov    %edx,0x4(%eax)
  st->ino = ip->inum;
80101e5c:	8b 45 08             	mov    0x8(%ebp),%eax
80101e5f:	8b 50 04             	mov    0x4(%eax),%edx
80101e62:	8b 45 0c             	mov    0xc(%ebp),%eax
80101e65:	89 50 08             	mov    %edx,0x8(%eax)
  st->type = ip->type;
80101e68:	8b 45 08             	mov    0x8(%ebp),%eax
80101e6b:	0f b7 50 10          	movzwl 0x10(%eax),%edx
80101e6f:	8b 45 0c             	mov    0xc(%ebp),%eax
80101e72:	66 89 10             	mov    %dx,(%eax)
  st->nlink = ip->nlink;
80101e75:	8b 45 08             	mov    0x8(%ebp),%eax
80101e78:	0f b7 50 16          	movzwl 0x16(%eax),%edx
80101e7c:	8b 45 0c             	mov    0xc(%ebp),%eax
80101e7f:	66 89 50 0c          	mov    %dx,0xc(%eax)
  st->size = ip->size;
80101e83:	8b 45 08             	mov    0x8(%ebp),%eax
80101e86:	8b 50 18             	mov    0x18(%eax),%edx
80101e89:	8b 45 0c             	mov    0xc(%ebp),%eax
80101e8c:	89 50 10             	mov    %edx,0x10(%eax)
}
80101e8f:	5d                   	pop    %ebp
80101e90:	c3                   	ret    

80101e91 <readi>:

//PAGEBREAK!
// Read data from inode.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101e91:	55                   	push   %ebp
80101e92:	89 e5                	mov    %esp,%ebp
80101e94:	83 ec 18             	sub    $0x18,%esp
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101e97:	8b 45 08             	mov    0x8(%ebp),%eax
80101e9a:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80101e9e:	66 83 f8 03          	cmp    $0x3,%ax
80101ea2:	75 5c                	jne    80101f00 <readi+0x6f>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101ea4:	8b 45 08             	mov    0x8(%ebp),%eax
80101ea7:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101eab:	66 85 c0             	test   %ax,%ax
80101eae:	78 20                	js     80101ed0 <readi+0x3f>
80101eb0:	8b 45 08             	mov    0x8(%ebp),%eax
80101eb3:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101eb7:	66 83 f8 09          	cmp    $0x9,%ax
80101ebb:	7f 13                	jg     80101ed0 <readi+0x3f>
80101ebd:	8b 45 08             	mov    0x8(%ebp),%eax
80101ec0:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101ec4:	98                   	cwtl   
80101ec5:	8b 04 c5 00 14 11 80 	mov    -0x7feeec00(,%eax,8),%eax
80101ecc:	85 c0                	test   %eax,%eax
80101ece:	75 0a                	jne    80101eda <readi+0x49>
      return -1;
80101ed0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101ed5:	e9 0f 01 00 00       	jmp    80101fe9 <readi+0x158>
    return devsw[ip->major].read(ip, dst, n);
80101eda:	8b 45 08             	mov    0x8(%ebp),%eax
80101edd:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101ee1:	98                   	cwtl   
80101ee2:	8b 04 c5 00 14 11 80 	mov    -0x7feeec00(,%eax,8),%eax
80101ee9:	8b 55 14             	mov    0x14(%ebp),%edx
80101eec:	83 ec 04             	sub    $0x4,%esp
80101eef:	52                   	push   %edx
80101ef0:	ff 75 0c             	pushl  0xc(%ebp)
80101ef3:	ff 75 08             	pushl  0x8(%ebp)
80101ef6:	ff d0                	call   *%eax
80101ef8:	83 c4 10             	add    $0x10,%esp
80101efb:	e9 e9 00 00 00       	jmp    80101fe9 <readi+0x158>
  }

  if(off > ip->size || off + n < off)
80101f00:	8b 45 08             	mov    0x8(%ebp),%eax
80101f03:	8b 40 18             	mov    0x18(%eax),%eax
80101f06:	3b 45 10             	cmp    0x10(%ebp),%eax
80101f09:	72 0d                	jb     80101f18 <readi+0x87>
80101f0b:	8b 55 10             	mov    0x10(%ebp),%edx
80101f0e:	8b 45 14             	mov    0x14(%ebp),%eax
80101f11:	01 d0                	add    %edx,%eax
80101f13:	3b 45 10             	cmp    0x10(%ebp),%eax
80101f16:	73 0a                	jae    80101f22 <readi+0x91>
    return -1;
80101f18:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101f1d:	e9 c7 00 00 00       	jmp    80101fe9 <readi+0x158>
  if(off + n > ip->size)
80101f22:	8b 55 10             	mov    0x10(%ebp),%edx
80101f25:	8b 45 14             	mov    0x14(%ebp),%eax
80101f28:	01 c2                	add    %eax,%edx
80101f2a:	8b 45 08             	mov    0x8(%ebp),%eax
80101f2d:	8b 40 18             	mov    0x18(%eax),%eax
80101f30:	39 c2                	cmp    %eax,%edx
80101f32:	76 0c                	jbe    80101f40 <readi+0xaf>
    n = ip->size - off;
80101f34:	8b 45 08             	mov    0x8(%ebp),%eax
80101f37:	8b 40 18             	mov    0x18(%eax),%eax
80101f3a:	2b 45 10             	sub    0x10(%ebp),%eax
80101f3d:	89 45 14             	mov    %eax,0x14(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101f40:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80101f47:	e9 8e 00 00 00       	jmp    80101fda <readi+0x149>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101f4c:	8b 45 10             	mov    0x10(%ebp),%eax
80101f4f:	c1 e8 09             	shr    $0x9,%eax
80101f52:	83 ec 08             	sub    $0x8,%esp
80101f55:	50                   	push   %eax
80101f56:	ff 75 08             	pushl  0x8(%ebp)
80101f59:	e8 ac fc ff ff       	call   80101c0a <bmap>
80101f5e:	83 c4 10             	add    $0x10,%esp
80101f61:	89 c2                	mov    %eax,%edx
80101f63:	8b 45 08             	mov    0x8(%ebp),%eax
80101f66:	8b 00                	mov    (%eax),%eax
80101f68:	83 ec 08             	sub    $0x8,%esp
80101f6b:	52                   	push   %edx
80101f6c:	50                   	push   %eax
80101f6d:	e8 42 e2 ff ff       	call   801001b4 <bread>
80101f72:	83 c4 10             	add    $0x10,%esp
80101f75:	89 45 f0             	mov    %eax,-0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101f78:	8b 45 10             	mov    0x10(%ebp),%eax
80101f7b:	25 ff 01 00 00       	and    $0x1ff,%eax
80101f80:	ba 00 02 00 00       	mov    $0x200,%edx
80101f85:	29 c2                	sub    %eax,%edx
80101f87:	8b 45 14             	mov    0x14(%ebp),%eax
80101f8a:	2b 45 f4             	sub    -0xc(%ebp),%eax
80101f8d:	39 c2                	cmp    %eax,%edx
80101f8f:	0f 46 c2             	cmovbe %edx,%eax
80101f92:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(dst, bp->data + off%BSIZE, m);
80101f95:	8b 45 10             	mov    0x10(%ebp),%eax
80101f98:	25 ff 01 00 00       	and    $0x1ff,%eax
80101f9d:	8d 50 10             	lea    0x10(%eax),%edx
80101fa0:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101fa3:	01 d0                	add    %edx,%eax
80101fa5:	83 c0 08             	add    $0x8,%eax
80101fa8:	83 ec 04             	sub    $0x4,%esp
80101fab:	ff 75 ec             	pushl  -0x14(%ebp)
80101fae:	50                   	push   %eax
80101faf:	ff 75 0c             	pushl  0xc(%ebp)
80101fb2:	e8 ab 35 00 00       	call   80105562 <memmove>
80101fb7:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
80101fba:	83 ec 0c             	sub    $0xc,%esp
80101fbd:	ff 75 f0             	pushl  -0x10(%ebp)
80101fc0:	e8 66 e2 ff ff       	call   8010022b <brelse>
80101fc5:	83 c4 10             	add    $0x10,%esp
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101fc8:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101fcb:	01 45 f4             	add    %eax,-0xc(%ebp)
80101fce:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101fd1:	01 45 10             	add    %eax,0x10(%ebp)
80101fd4:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101fd7:	01 45 0c             	add    %eax,0xc(%ebp)
80101fda:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101fdd:	3b 45 14             	cmp    0x14(%ebp),%eax
80101fe0:	0f 82 66 ff ff ff    	jb     80101f4c <readi+0xbb>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
80101fe6:	8b 45 14             	mov    0x14(%ebp),%eax
}
80101fe9:	c9                   	leave  
80101fea:	c3                   	ret    

80101feb <writei>:

// PAGEBREAK!
// Write data to inode.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101feb:	55                   	push   %ebp
80101fec:	89 e5                	mov    %esp,%ebp
80101fee:	83 ec 18             	sub    $0x18,%esp
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101ff1:	8b 45 08             	mov    0x8(%ebp),%eax
80101ff4:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80101ff8:	66 83 f8 03          	cmp    $0x3,%ax
80101ffc:	75 5c                	jne    8010205a <writei+0x6f>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101ffe:	8b 45 08             	mov    0x8(%ebp),%eax
80102001:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80102005:	66 85 c0             	test   %ax,%ax
80102008:	78 20                	js     8010202a <writei+0x3f>
8010200a:	8b 45 08             	mov    0x8(%ebp),%eax
8010200d:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80102011:	66 83 f8 09          	cmp    $0x9,%ax
80102015:	7f 13                	jg     8010202a <writei+0x3f>
80102017:	8b 45 08             	mov    0x8(%ebp),%eax
8010201a:	0f b7 40 12          	movzwl 0x12(%eax),%eax
8010201e:	98                   	cwtl   
8010201f:	8b 04 c5 04 14 11 80 	mov    -0x7feeebfc(,%eax,8),%eax
80102026:	85 c0                	test   %eax,%eax
80102028:	75 0a                	jne    80102034 <writei+0x49>
      return -1;
8010202a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010202f:	e9 40 01 00 00       	jmp    80102174 <writei+0x189>
    return devsw[ip->major].write(ip, src, n);
80102034:	8b 45 08             	mov    0x8(%ebp),%eax
80102037:	0f b7 40 12          	movzwl 0x12(%eax),%eax
8010203b:	98                   	cwtl   
8010203c:	8b 04 c5 04 14 11 80 	mov    -0x7feeebfc(,%eax,8),%eax
80102043:	8b 55 14             	mov    0x14(%ebp),%edx
80102046:	83 ec 04             	sub    $0x4,%esp
80102049:	52                   	push   %edx
8010204a:	ff 75 0c             	pushl  0xc(%ebp)
8010204d:	ff 75 08             	pushl  0x8(%ebp)
80102050:	ff d0                	call   *%eax
80102052:	83 c4 10             	add    $0x10,%esp
80102055:	e9 1a 01 00 00       	jmp    80102174 <writei+0x189>
  }

  if(off > ip->size || off + n < off)
8010205a:	8b 45 08             	mov    0x8(%ebp),%eax
8010205d:	8b 40 18             	mov    0x18(%eax),%eax
80102060:	3b 45 10             	cmp    0x10(%ebp),%eax
80102063:	72 0d                	jb     80102072 <writei+0x87>
80102065:	8b 55 10             	mov    0x10(%ebp),%edx
80102068:	8b 45 14             	mov    0x14(%ebp),%eax
8010206b:	01 d0                	add    %edx,%eax
8010206d:	3b 45 10             	cmp    0x10(%ebp),%eax
80102070:	73 0a                	jae    8010207c <writei+0x91>
    return -1;
80102072:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102077:	e9 f8 00 00 00       	jmp    80102174 <writei+0x189>
  if(off + n > MAXFILE*BSIZE)
8010207c:	8b 55 10             	mov    0x10(%ebp),%edx
8010207f:	8b 45 14             	mov    0x14(%ebp),%eax
80102082:	01 d0                	add    %edx,%eax
80102084:	3d 00 18 01 00       	cmp    $0x11800,%eax
80102089:	76 0a                	jbe    80102095 <writei+0xaa>
    return -1;
8010208b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102090:	e9 df 00 00 00       	jmp    80102174 <writei+0x189>

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80102095:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010209c:	e9 9c 00 00 00       	jmp    8010213d <writei+0x152>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801020a1:	8b 45 10             	mov    0x10(%ebp),%eax
801020a4:	c1 e8 09             	shr    $0x9,%eax
801020a7:	83 ec 08             	sub    $0x8,%esp
801020aa:	50                   	push   %eax
801020ab:	ff 75 08             	pushl  0x8(%ebp)
801020ae:	e8 57 fb ff ff       	call   80101c0a <bmap>
801020b3:	83 c4 10             	add    $0x10,%esp
801020b6:	89 c2                	mov    %eax,%edx
801020b8:	8b 45 08             	mov    0x8(%ebp),%eax
801020bb:	8b 00                	mov    (%eax),%eax
801020bd:	83 ec 08             	sub    $0x8,%esp
801020c0:	52                   	push   %edx
801020c1:	50                   	push   %eax
801020c2:	e8 ed e0 ff ff       	call   801001b4 <bread>
801020c7:	83 c4 10             	add    $0x10,%esp
801020ca:	89 45 f0             	mov    %eax,-0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
801020cd:	8b 45 10             	mov    0x10(%ebp),%eax
801020d0:	25 ff 01 00 00       	and    $0x1ff,%eax
801020d5:	ba 00 02 00 00       	mov    $0x200,%edx
801020da:	29 c2                	sub    %eax,%edx
801020dc:	8b 45 14             	mov    0x14(%ebp),%eax
801020df:	2b 45 f4             	sub    -0xc(%ebp),%eax
801020e2:	39 c2                	cmp    %eax,%edx
801020e4:	0f 46 c2             	cmovbe %edx,%eax
801020e7:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(bp->data + off%BSIZE, src, m);
801020ea:	8b 45 10             	mov    0x10(%ebp),%eax
801020ed:	25 ff 01 00 00       	and    $0x1ff,%eax
801020f2:	8d 50 10             	lea    0x10(%eax),%edx
801020f5:	8b 45 f0             	mov    -0x10(%ebp),%eax
801020f8:	01 d0                	add    %edx,%eax
801020fa:	83 c0 08             	add    $0x8,%eax
801020fd:	83 ec 04             	sub    $0x4,%esp
80102100:	ff 75 ec             	pushl  -0x14(%ebp)
80102103:	ff 75 0c             	pushl  0xc(%ebp)
80102106:	50                   	push   %eax
80102107:	e8 56 34 00 00       	call   80105562 <memmove>
8010210c:	83 c4 10             	add    $0x10,%esp
    log_write(bp);
8010210f:	83 ec 0c             	sub    $0xc,%esp
80102112:	ff 75 f0             	pushl  -0x10(%ebp)
80102115:	e8 0a 16 00 00       	call   80103724 <log_write>
8010211a:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
8010211d:	83 ec 0c             	sub    $0xc,%esp
80102120:	ff 75 f0             	pushl  -0x10(%ebp)
80102123:	e8 03 e1 ff ff       	call   8010022b <brelse>
80102128:	83 c4 10             	add    $0x10,%esp
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
8010212b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010212e:	01 45 f4             	add    %eax,-0xc(%ebp)
80102131:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102134:	01 45 10             	add    %eax,0x10(%ebp)
80102137:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010213a:	01 45 0c             	add    %eax,0xc(%ebp)
8010213d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102140:	3b 45 14             	cmp    0x14(%ebp),%eax
80102143:	0f 82 58 ff ff ff    	jb     801020a1 <writei+0xb6>
    memmove(bp->data + off%BSIZE, src, m);
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
80102149:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
8010214d:	74 22                	je     80102171 <writei+0x186>
8010214f:	8b 45 08             	mov    0x8(%ebp),%eax
80102152:	8b 40 18             	mov    0x18(%eax),%eax
80102155:	3b 45 10             	cmp    0x10(%ebp),%eax
80102158:	73 17                	jae    80102171 <writei+0x186>
    ip->size = off;
8010215a:	8b 45 08             	mov    0x8(%ebp),%eax
8010215d:	8b 55 10             	mov    0x10(%ebp),%edx
80102160:	89 50 18             	mov    %edx,0x18(%eax)
    iupdate(ip);
80102163:	83 ec 0c             	sub    $0xc,%esp
80102166:	ff 75 08             	pushl  0x8(%ebp)
80102169:	e8 e2 f5 ff ff       	call   80101750 <iupdate>
8010216e:	83 c4 10             	add    $0x10,%esp
  }
  return n;
80102171:	8b 45 14             	mov    0x14(%ebp),%eax
}
80102174:	c9                   	leave  
80102175:	c3                   	ret    

80102176 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80102176:	55                   	push   %ebp
80102177:	89 e5                	mov    %esp,%ebp
80102179:	83 ec 08             	sub    $0x8,%esp
  return strncmp(s, t, DIRSIZ);
8010217c:	83 ec 04             	sub    $0x4,%esp
8010217f:	6a 0e                	push   $0xe
80102181:	ff 75 0c             	pushl  0xc(%ebp)
80102184:	ff 75 08             	pushl  0x8(%ebp)
80102187:	e8 6e 34 00 00       	call   801055fa <strncmp>
8010218c:	83 c4 10             	add    $0x10,%esp
}
8010218f:	c9                   	leave  
80102190:	c3                   	ret    

80102191 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80102191:	55                   	push   %ebp
80102192:	89 e5                	mov    %esp,%ebp
80102194:	83 ec 28             	sub    $0x28,%esp
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80102197:	8b 45 08             	mov    0x8(%ebp),%eax
8010219a:	0f b7 40 10          	movzwl 0x10(%eax),%eax
8010219e:	66 83 f8 01          	cmp    $0x1,%ax
801021a2:	74 0d                	je     801021b1 <dirlookup+0x20>
    panic("dirlookup not DIR");
801021a4:	83 ec 0c             	sub    $0xc,%esp
801021a7:	68 a3 88 10 80       	push   $0x801088a3
801021ac:	e8 ab e3 ff ff       	call   8010055c <panic>

  for(off = 0; off < dp->size; off += sizeof(de)){
801021b1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801021b8:	eb 7c                	jmp    80102236 <dirlookup+0xa5>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801021ba:	6a 10                	push   $0x10
801021bc:	ff 75 f4             	pushl  -0xc(%ebp)
801021bf:	8d 45 e0             	lea    -0x20(%ebp),%eax
801021c2:	50                   	push   %eax
801021c3:	ff 75 08             	pushl  0x8(%ebp)
801021c6:	e8 c6 fc ff ff       	call   80101e91 <readi>
801021cb:	83 c4 10             	add    $0x10,%esp
801021ce:	83 f8 10             	cmp    $0x10,%eax
801021d1:	74 0d                	je     801021e0 <dirlookup+0x4f>
      panic("dirlink read");
801021d3:	83 ec 0c             	sub    $0xc,%esp
801021d6:	68 b5 88 10 80       	push   $0x801088b5
801021db:	e8 7c e3 ff ff       	call   8010055c <panic>
    if(de.inum == 0)
801021e0:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
801021e4:	66 85 c0             	test   %ax,%ax
801021e7:	75 02                	jne    801021eb <dirlookup+0x5a>
      continue;
801021e9:	eb 47                	jmp    80102232 <dirlookup+0xa1>
    if(namecmp(name, de.name) == 0){
801021eb:	83 ec 08             	sub    $0x8,%esp
801021ee:	8d 45 e0             	lea    -0x20(%ebp),%eax
801021f1:	83 c0 02             	add    $0x2,%eax
801021f4:	50                   	push   %eax
801021f5:	ff 75 0c             	pushl  0xc(%ebp)
801021f8:	e8 79 ff ff ff       	call   80102176 <namecmp>
801021fd:	83 c4 10             	add    $0x10,%esp
80102200:	85 c0                	test   %eax,%eax
80102202:	75 2e                	jne    80102232 <dirlookup+0xa1>
      // entry matches path element
      if(poff)
80102204:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80102208:	74 08                	je     80102212 <dirlookup+0x81>
        *poff = off;
8010220a:	8b 45 10             	mov    0x10(%ebp),%eax
8010220d:	8b 55 f4             	mov    -0xc(%ebp),%edx
80102210:	89 10                	mov    %edx,(%eax)
      inum = de.inum;
80102212:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
80102216:	0f b7 c0             	movzwl %ax,%eax
80102219:	89 45 f0             	mov    %eax,-0x10(%ebp)
      return iget(dp->dev, inum);
8010221c:	8b 45 08             	mov    0x8(%ebp),%eax
8010221f:	8b 00                	mov    (%eax),%eax
80102221:	83 ec 08             	sub    $0x8,%esp
80102224:	ff 75 f0             	pushl  -0x10(%ebp)
80102227:	50                   	push   %eax
80102228:	e8 e3 f5 ff ff       	call   80101810 <iget>
8010222d:	83 c4 10             	add    $0x10,%esp
80102230:	eb 18                	jmp    8010224a <dirlookup+0xb9>
  struct dirent de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80102232:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
80102236:	8b 45 08             	mov    0x8(%ebp),%eax
80102239:	8b 40 18             	mov    0x18(%eax),%eax
8010223c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010223f:	0f 87 75 ff ff ff    	ja     801021ba <dirlookup+0x29>
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
80102245:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010224a:	c9                   	leave  
8010224b:	c3                   	ret    

8010224c <dirlink>:

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
8010224c:	55                   	push   %ebp
8010224d:	89 e5                	mov    %esp,%ebp
8010224f:	83 ec 28             	sub    $0x28,%esp
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
80102252:	83 ec 04             	sub    $0x4,%esp
80102255:	6a 00                	push   $0x0
80102257:	ff 75 0c             	pushl  0xc(%ebp)
8010225a:	ff 75 08             	pushl  0x8(%ebp)
8010225d:	e8 2f ff ff ff       	call   80102191 <dirlookup>
80102262:	83 c4 10             	add    $0x10,%esp
80102265:	89 45 f0             	mov    %eax,-0x10(%ebp)
80102268:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010226c:	74 18                	je     80102286 <dirlink+0x3a>
    iput(ip);
8010226e:	83 ec 0c             	sub    $0xc,%esp
80102271:	ff 75 f0             	pushl  -0x10(%ebp)
80102274:	e8 7e f8 ff ff       	call   80101af7 <iput>
80102279:	83 c4 10             	add    $0x10,%esp
    return -1;
8010227c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102281:	e9 9b 00 00 00       	jmp    80102321 <dirlink+0xd5>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
80102286:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010228d:	eb 3b                	jmp    801022ca <dirlink+0x7e>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010228f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102292:	6a 10                	push   $0x10
80102294:	50                   	push   %eax
80102295:	8d 45 e0             	lea    -0x20(%ebp),%eax
80102298:	50                   	push   %eax
80102299:	ff 75 08             	pushl  0x8(%ebp)
8010229c:	e8 f0 fb ff ff       	call   80101e91 <readi>
801022a1:	83 c4 10             	add    $0x10,%esp
801022a4:	83 f8 10             	cmp    $0x10,%eax
801022a7:	74 0d                	je     801022b6 <dirlink+0x6a>
      panic("dirlink read");
801022a9:	83 ec 0c             	sub    $0xc,%esp
801022ac:	68 b5 88 10 80       	push   $0x801088b5
801022b1:	e8 a6 e2 ff ff       	call   8010055c <panic>
    if(de.inum == 0)
801022b6:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
801022ba:	66 85 c0             	test   %ax,%ax
801022bd:	75 02                	jne    801022c1 <dirlink+0x75>
      break;
801022bf:	eb 16                	jmp    801022d7 <dirlink+0x8b>
    iput(ip);
    return -1;
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
801022c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801022c4:	83 c0 10             	add    $0x10,%eax
801022c7:	89 45 f4             	mov    %eax,-0xc(%ebp)
801022ca:	8b 55 f4             	mov    -0xc(%ebp),%edx
801022cd:	8b 45 08             	mov    0x8(%ebp),%eax
801022d0:	8b 40 18             	mov    0x18(%eax),%eax
801022d3:	39 c2                	cmp    %eax,%edx
801022d5:	72 b8                	jb     8010228f <dirlink+0x43>
      panic("dirlink read");
    if(de.inum == 0)
      break;
  }

  strncpy(de.name, name, DIRSIZ);
801022d7:	83 ec 04             	sub    $0x4,%esp
801022da:	6a 0e                	push   $0xe
801022dc:	ff 75 0c             	pushl  0xc(%ebp)
801022df:	8d 45 e0             	lea    -0x20(%ebp),%eax
801022e2:	83 c0 02             	add    $0x2,%eax
801022e5:	50                   	push   %eax
801022e6:	e8 65 33 00 00       	call   80105650 <strncpy>
801022eb:	83 c4 10             	add    $0x10,%esp
  de.inum = inum;
801022ee:	8b 45 10             	mov    0x10(%ebp),%eax
801022f1:	66 89 45 e0          	mov    %ax,-0x20(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801022f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801022f8:	6a 10                	push   $0x10
801022fa:	50                   	push   %eax
801022fb:	8d 45 e0             	lea    -0x20(%ebp),%eax
801022fe:	50                   	push   %eax
801022ff:	ff 75 08             	pushl  0x8(%ebp)
80102302:	e8 e4 fc ff ff       	call   80101feb <writei>
80102307:	83 c4 10             	add    $0x10,%esp
8010230a:	83 f8 10             	cmp    $0x10,%eax
8010230d:	74 0d                	je     8010231c <dirlink+0xd0>
    panic("dirlink");
8010230f:	83 ec 0c             	sub    $0xc,%esp
80102312:	68 c2 88 10 80       	push   $0x801088c2
80102317:	e8 40 e2 ff ff       	call   8010055c <panic>
  
  return 0;
8010231c:	b8 00 00 00 00       	mov    $0x0,%eax
}
80102321:	c9                   	leave  
80102322:	c3                   	ret    

80102323 <skipelem>:
//   skipelem("a", name) = "", setting name = "a"
//   skipelem("", name) = skipelem("////", name) = 0
//
static char*
skipelem(char *path, char *name)
{
80102323:	55                   	push   %ebp
80102324:	89 e5                	mov    %esp,%ebp
80102326:	83 ec 18             	sub    $0x18,%esp
  char *s;
  int len;

  while(*path == '/')
80102329:	eb 04                	jmp    8010232f <skipelem+0xc>
    path++;
8010232b:	83 45 08 01          	addl   $0x1,0x8(%ebp)
skipelem(char *path, char *name)
{
  char *s;
  int len;

  while(*path == '/')
8010232f:	8b 45 08             	mov    0x8(%ebp),%eax
80102332:	0f b6 00             	movzbl (%eax),%eax
80102335:	3c 2f                	cmp    $0x2f,%al
80102337:	74 f2                	je     8010232b <skipelem+0x8>
    path++;
  if(*path == 0)
80102339:	8b 45 08             	mov    0x8(%ebp),%eax
8010233c:	0f b6 00             	movzbl (%eax),%eax
8010233f:	84 c0                	test   %al,%al
80102341:	75 07                	jne    8010234a <skipelem+0x27>
    return 0;
80102343:	b8 00 00 00 00       	mov    $0x0,%eax
80102348:	eb 7b                	jmp    801023c5 <skipelem+0xa2>
  s = path;
8010234a:	8b 45 08             	mov    0x8(%ebp),%eax
8010234d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(*path != '/' && *path != 0)
80102350:	eb 04                	jmp    80102356 <skipelem+0x33>
    path++;
80102352:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80102356:	8b 45 08             	mov    0x8(%ebp),%eax
80102359:	0f b6 00             	movzbl (%eax),%eax
8010235c:	3c 2f                	cmp    $0x2f,%al
8010235e:	74 0a                	je     8010236a <skipelem+0x47>
80102360:	8b 45 08             	mov    0x8(%ebp),%eax
80102363:	0f b6 00             	movzbl (%eax),%eax
80102366:	84 c0                	test   %al,%al
80102368:	75 e8                	jne    80102352 <skipelem+0x2f>
    path++;
  len = path - s;
8010236a:	8b 55 08             	mov    0x8(%ebp),%edx
8010236d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102370:	29 c2                	sub    %eax,%edx
80102372:	89 d0                	mov    %edx,%eax
80102374:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(len >= DIRSIZ)
80102377:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
8010237b:	7e 15                	jle    80102392 <skipelem+0x6f>
    memmove(name, s, DIRSIZ);
8010237d:	83 ec 04             	sub    $0x4,%esp
80102380:	6a 0e                	push   $0xe
80102382:	ff 75 f4             	pushl  -0xc(%ebp)
80102385:	ff 75 0c             	pushl  0xc(%ebp)
80102388:	e8 d5 31 00 00       	call   80105562 <memmove>
8010238d:	83 c4 10             	add    $0x10,%esp
80102390:	eb 20                	jmp    801023b2 <skipelem+0x8f>
  else {
    memmove(name, s, len);
80102392:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102395:	83 ec 04             	sub    $0x4,%esp
80102398:	50                   	push   %eax
80102399:	ff 75 f4             	pushl  -0xc(%ebp)
8010239c:	ff 75 0c             	pushl  0xc(%ebp)
8010239f:	e8 be 31 00 00       	call   80105562 <memmove>
801023a4:	83 c4 10             	add    $0x10,%esp
    name[len] = 0;
801023a7:	8b 55 f0             	mov    -0x10(%ebp),%edx
801023aa:	8b 45 0c             	mov    0xc(%ebp),%eax
801023ad:	01 d0                	add    %edx,%eax
801023af:	c6 00 00             	movb   $0x0,(%eax)
  }
  while(*path == '/')
801023b2:	eb 04                	jmp    801023b8 <skipelem+0x95>
    path++;
801023b4:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
801023b8:	8b 45 08             	mov    0x8(%ebp),%eax
801023bb:	0f b6 00             	movzbl (%eax),%eax
801023be:	3c 2f                	cmp    $0x2f,%al
801023c0:	74 f2                	je     801023b4 <skipelem+0x91>
    path++;
  return path;
801023c2:	8b 45 08             	mov    0x8(%ebp),%eax
}
801023c5:	c9                   	leave  
801023c6:	c3                   	ret    

801023c7 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
801023c7:	55                   	push   %ebp
801023c8:	89 e5                	mov    %esp,%ebp
801023ca:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip, *next;

  if(*path == '/')
801023cd:	8b 45 08             	mov    0x8(%ebp),%eax
801023d0:	0f b6 00             	movzbl (%eax),%eax
801023d3:	3c 2f                	cmp    $0x2f,%al
801023d5:	75 14                	jne    801023eb <namex+0x24>
    ip = iget(ROOTDEV, ROOTINO);
801023d7:	83 ec 08             	sub    $0x8,%esp
801023da:	6a 01                	push   $0x1
801023dc:	6a 01                	push   $0x1
801023de:	e8 2d f4 ff ff       	call   80101810 <iget>
801023e3:	83 c4 10             	add    $0x10,%esp
801023e6:	89 45 f4             	mov    %eax,-0xc(%ebp)
801023e9:	eb 18                	jmp    80102403 <namex+0x3c>
  else
    ip = idup(proc->cwd);
801023eb:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801023f1:	8b 40 68             	mov    0x68(%eax),%eax
801023f4:	83 ec 0c             	sub    $0xc,%esp
801023f7:	50                   	push   %eax
801023f8:	e8 f2 f4 ff ff       	call   801018ef <idup>
801023fd:	83 c4 10             	add    $0x10,%esp
80102400:	89 45 f4             	mov    %eax,-0xc(%ebp)

  while((path = skipelem(path, name)) != 0){
80102403:	e9 9e 00 00 00       	jmp    801024a6 <namex+0xdf>
    ilock(ip);
80102408:	83 ec 0c             	sub    $0xc,%esp
8010240b:	ff 75 f4             	pushl  -0xc(%ebp)
8010240e:	e8 16 f5 ff ff       	call   80101929 <ilock>
80102413:	83 c4 10             	add    $0x10,%esp
    if(ip->type != T_DIR){
80102416:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102419:	0f b7 40 10          	movzwl 0x10(%eax),%eax
8010241d:	66 83 f8 01          	cmp    $0x1,%ax
80102421:	74 18                	je     8010243b <namex+0x74>
      iunlockput(ip);
80102423:	83 ec 0c             	sub    $0xc,%esp
80102426:	ff 75 f4             	pushl  -0xc(%ebp)
80102429:	e8 b8 f7 ff ff       	call   80101be6 <iunlockput>
8010242e:	83 c4 10             	add    $0x10,%esp
      return 0;
80102431:	b8 00 00 00 00       	mov    $0x0,%eax
80102436:	e9 a7 00 00 00       	jmp    801024e2 <namex+0x11b>
    }
    if(nameiparent && *path == '\0'){
8010243b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
8010243f:	74 20                	je     80102461 <namex+0x9a>
80102441:	8b 45 08             	mov    0x8(%ebp),%eax
80102444:	0f b6 00             	movzbl (%eax),%eax
80102447:	84 c0                	test   %al,%al
80102449:	75 16                	jne    80102461 <namex+0x9a>
      // Stop one level early.
      iunlock(ip);
8010244b:	83 ec 0c             	sub    $0xc,%esp
8010244e:	ff 75 f4             	pushl  -0xc(%ebp)
80102451:	e8 30 f6 ff ff       	call   80101a86 <iunlock>
80102456:	83 c4 10             	add    $0x10,%esp
      return ip;
80102459:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010245c:	e9 81 00 00 00       	jmp    801024e2 <namex+0x11b>
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80102461:	83 ec 04             	sub    $0x4,%esp
80102464:	6a 00                	push   $0x0
80102466:	ff 75 10             	pushl  0x10(%ebp)
80102469:	ff 75 f4             	pushl  -0xc(%ebp)
8010246c:	e8 20 fd ff ff       	call   80102191 <dirlookup>
80102471:	83 c4 10             	add    $0x10,%esp
80102474:	89 45 f0             	mov    %eax,-0x10(%ebp)
80102477:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010247b:	75 15                	jne    80102492 <namex+0xcb>
      iunlockput(ip);
8010247d:	83 ec 0c             	sub    $0xc,%esp
80102480:	ff 75 f4             	pushl  -0xc(%ebp)
80102483:	e8 5e f7 ff ff       	call   80101be6 <iunlockput>
80102488:	83 c4 10             	add    $0x10,%esp
      return 0;
8010248b:	b8 00 00 00 00       	mov    $0x0,%eax
80102490:	eb 50                	jmp    801024e2 <namex+0x11b>
    }
    iunlockput(ip);
80102492:	83 ec 0c             	sub    $0xc,%esp
80102495:	ff 75 f4             	pushl  -0xc(%ebp)
80102498:	e8 49 f7 ff ff       	call   80101be6 <iunlockput>
8010249d:	83 c4 10             	add    $0x10,%esp
    ip = next;
801024a0:	8b 45 f0             	mov    -0x10(%ebp),%eax
801024a3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(proc->cwd);

  while((path = skipelem(path, name)) != 0){
801024a6:	83 ec 08             	sub    $0x8,%esp
801024a9:	ff 75 10             	pushl  0x10(%ebp)
801024ac:	ff 75 08             	pushl  0x8(%ebp)
801024af:	e8 6f fe ff ff       	call   80102323 <skipelem>
801024b4:	83 c4 10             	add    $0x10,%esp
801024b7:	89 45 08             	mov    %eax,0x8(%ebp)
801024ba:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801024be:	0f 85 44 ff ff ff    	jne    80102408 <namex+0x41>
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
801024c4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
801024c8:	74 15                	je     801024df <namex+0x118>
    iput(ip);
801024ca:	83 ec 0c             	sub    $0xc,%esp
801024cd:	ff 75 f4             	pushl  -0xc(%ebp)
801024d0:	e8 22 f6 ff ff       	call   80101af7 <iput>
801024d5:	83 c4 10             	add    $0x10,%esp
    return 0;
801024d8:	b8 00 00 00 00       	mov    $0x0,%eax
801024dd:	eb 03                	jmp    801024e2 <namex+0x11b>
  }
  return ip;
801024df:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801024e2:	c9                   	leave  
801024e3:	c3                   	ret    

801024e4 <namei>:

struct inode*
namei(char *path)
{
801024e4:	55                   	push   %ebp
801024e5:	89 e5                	mov    %esp,%ebp
801024e7:	83 ec 18             	sub    $0x18,%esp
  char name[DIRSIZ];
  return namex(path, 0, name);
801024ea:	83 ec 04             	sub    $0x4,%esp
801024ed:	8d 45 ea             	lea    -0x16(%ebp),%eax
801024f0:	50                   	push   %eax
801024f1:	6a 00                	push   $0x0
801024f3:	ff 75 08             	pushl  0x8(%ebp)
801024f6:	e8 cc fe ff ff       	call   801023c7 <namex>
801024fb:	83 c4 10             	add    $0x10,%esp
}
801024fe:	c9                   	leave  
801024ff:	c3                   	ret    

80102500 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80102500:	55                   	push   %ebp
80102501:	89 e5                	mov    %esp,%ebp
80102503:	83 ec 08             	sub    $0x8,%esp
  return namex(path, 1, name);
80102506:	83 ec 04             	sub    $0x4,%esp
80102509:	ff 75 0c             	pushl  0xc(%ebp)
8010250c:	6a 01                	push   $0x1
8010250e:	ff 75 08             	pushl  0x8(%ebp)
80102511:	e8 b1 fe ff ff       	call   801023c7 <namex>
80102516:	83 c4 10             	add    $0x10,%esp
}
80102519:	c9                   	leave  
8010251a:	c3                   	ret    

8010251b <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
8010251b:	55                   	push   %ebp
8010251c:	89 e5                	mov    %esp,%ebp
8010251e:	83 ec 14             	sub    $0x14,%esp
80102521:	8b 45 08             	mov    0x8(%ebp),%eax
80102524:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102528:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
8010252c:	89 c2                	mov    %eax,%edx
8010252e:	ec                   	in     (%dx),%al
8010252f:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80102532:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80102536:	c9                   	leave  
80102537:	c3                   	ret    

80102538 <insl>:

static inline void
insl(int port, void *addr, int cnt)
{
80102538:	55                   	push   %ebp
80102539:	89 e5                	mov    %esp,%ebp
8010253b:	57                   	push   %edi
8010253c:	53                   	push   %ebx
  asm volatile("cld; rep insl" :
8010253d:	8b 55 08             	mov    0x8(%ebp),%edx
80102540:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102543:	8b 45 10             	mov    0x10(%ebp),%eax
80102546:	89 cb                	mov    %ecx,%ebx
80102548:	89 df                	mov    %ebx,%edi
8010254a:	89 c1                	mov    %eax,%ecx
8010254c:	fc                   	cld    
8010254d:	f3 6d                	rep insl (%dx),%es:(%edi)
8010254f:	89 c8                	mov    %ecx,%eax
80102551:	89 fb                	mov    %edi,%ebx
80102553:	89 5d 0c             	mov    %ebx,0xc(%ebp)
80102556:	89 45 10             	mov    %eax,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "d" (port), "0" (addr), "1" (cnt) :
               "memory", "cc");
}
80102559:	5b                   	pop    %ebx
8010255a:	5f                   	pop    %edi
8010255b:	5d                   	pop    %ebp
8010255c:	c3                   	ret    

8010255d <outb>:

static inline void
outb(ushort port, uchar data)
{
8010255d:	55                   	push   %ebp
8010255e:	89 e5                	mov    %esp,%ebp
80102560:	83 ec 08             	sub    $0x8,%esp
80102563:	8b 55 08             	mov    0x8(%ebp),%edx
80102566:	8b 45 0c             	mov    0xc(%ebp),%eax
80102569:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
8010256d:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102570:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80102574:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80102578:	ee                   	out    %al,(%dx)
}
80102579:	c9                   	leave  
8010257a:	c3                   	ret    

8010257b <outsl>:
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
}

static inline void
outsl(int port, const void *addr, int cnt)
{
8010257b:	55                   	push   %ebp
8010257c:	89 e5                	mov    %esp,%ebp
8010257e:	56                   	push   %esi
8010257f:	53                   	push   %ebx
  asm volatile("cld; rep outsl" :
80102580:	8b 55 08             	mov    0x8(%ebp),%edx
80102583:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102586:	8b 45 10             	mov    0x10(%ebp),%eax
80102589:	89 cb                	mov    %ecx,%ebx
8010258b:	89 de                	mov    %ebx,%esi
8010258d:	89 c1                	mov    %eax,%ecx
8010258f:	fc                   	cld    
80102590:	f3 6f                	rep outsl %ds:(%esi),(%dx)
80102592:	89 c8                	mov    %ecx,%eax
80102594:	89 f3                	mov    %esi,%ebx
80102596:	89 5d 0c             	mov    %ebx,0xc(%ebp)
80102599:	89 45 10             	mov    %eax,0x10(%ebp)
               "=S" (addr), "=c" (cnt) :
               "d" (port), "0" (addr), "1" (cnt) :
               "cc");
}
8010259c:	5b                   	pop    %ebx
8010259d:	5e                   	pop    %esi
8010259e:	5d                   	pop    %ebp
8010259f:	c3                   	ret    

801025a0 <idewait>:
static void idestart(struct buf*);

// Wait for IDE disk to become ready.
static int
idewait(int checkerr)
{
801025a0:	55                   	push   %ebp
801025a1:	89 e5                	mov    %esp,%ebp
801025a3:	83 ec 10             	sub    $0x10,%esp
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY) 
801025a6:	90                   	nop
801025a7:	68 f7 01 00 00       	push   $0x1f7
801025ac:	e8 6a ff ff ff       	call   8010251b <inb>
801025b1:	83 c4 04             	add    $0x4,%esp
801025b4:	0f b6 c0             	movzbl %al,%eax
801025b7:	89 45 fc             	mov    %eax,-0x4(%ebp)
801025ba:	8b 45 fc             	mov    -0x4(%ebp),%eax
801025bd:	25 c0 00 00 00       	and    $0xc0,%eax
801025c2:	83 f8 40             	cmp    $0x40,%eax
801025c5:	75 e0                	jne    801025a7 <idewait+0x7>
    ;
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
801025c7:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801025cb:	74 11                	je     801025de <idewait+0x3e>
801025cd:	8b 45 fc             	mov    -0x4(%ebp),%eax
801025d0:	83 e0 21             	and    $0x21,%eax
801025d3:	85 c0                	test   %eax,%eax
801025d5:	74 07                	je     801025de <idewait+0x3e>
    return -1;
801025d7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801025dc:	eb 05                	jmp    801025e3 <idewait+0x43>
  return 0;
801025de:	b8 00 00 00 00       	mov    $0x0,%eax
}
801025e3:	c9                   	leave  
801025e4:	c3                   	ret    

801025e5 <ideinit>:

void
ideinit(void)
{
801025e5:	55                   	push   %ebp
801025e6:	89 e5                	mov    %esp,%ebp
801025e8:	83 ec 18             	sub    $0x18,%esp
  int i;
  
  initlock(&idelock, "ide");
801025eb:	83 ec 08             	sub    $0x8,%esp
801025ee:	68 ca 88 10 80       	push   $0x801088ca
801025f3:	68 20 b6 10 80       	push   $0x8010b620
801025f8:	e8 29 2c 00 00       	call   80105226 <initlock>
801025fd:	83 c4 10             	add    $0x10,%esp
  picenable(IRQ_IDE);
80102600:	83 ec 0c             	sub    $0xc,%esp
80102603:	6a 0e                	push   $0xe
80102605:	e8 b7 18 00 00       	call   80103ec1 <picenable>
8010260a:	83 c4 10             	add    $0x10,%esp
  ioapicenable(IRQ_IDE, ncpu - 1);
8010260d:	a1 20 2c 11 80       	mov    0x80112c20,%eax
80102612:	83 e8 01             	sub    $0x1,%eax
80102615:	83 ec 08             	sub    $0x8,%esp
80102618:	50                   	push   %eax
80102619:	6a 0e                	push   $0xe
8010261b:	e8 6d 04 00 00       	call   80102a8d <ioapicenable>
80102620:	83 c4 10             	add    $0x10,%esp
  idewait(0);
80102623:	83 ec 0c             	sub    $0xc,%esp
80102626:	6a 00                	push   $0x0
80102628:	e8 73 ff ff ff       	call   801025a0 <idewait>
8010262d:	83 c4 10             	add    $0x10,%esp
  
  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
80102630:	83 ec 08             	sub    $0x8,%esp
80102633:	68 f0 00 00 00       	push   $0xf0
80102638:	68 f6 01 00 00       	push   $0x1f6
8010263d:	e8 1b ff ff ff       	call   8010255d <outb>
80102642:	83 c4 10             	add    $0x10,%esp
  for(i=0; i<1000; i++){
80102645:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010264c:	eb 24                	jmp    80102672 <ideinit+0x8d>
    if(inb(0x1f7) != 0){
8010264e:	83 ec 0c             	sub    $0xc,%esp
80102651:	68 f7 01 00 00       	push   $0x1f7
80102656:	e8 c0 fe ff ff       	call   8010251b <inb>
8010265b:	83 c4 10             	add    $0x10,%esp
8010265e:	84 c0                	test   %al,%al
80102660:	74 0c                	je     8010266e <ideinit+0x89>
      havedisk1 = 1;
80102662:	c7 05 58 b6 10 80 01 	movl   $0x1,0x8010b658
80102669:	00 00 00 
      break;
8010266c:	eb 0d                	jmp    8010267b <ideinit+0x96>
  ioapicenable(IRQ_IDE, ncpu - 1);
  idewait(0);
  
  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
  for(i=0; i<1000; i++){
8010266e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80102672:	81 7d f4 e7 03 00 00 	cmpl   $0x3e7,-0xc(%ebp)
80102679:	7e d3                	jle    8010264e <ideinit+0x69>
      break;
    }
  }
  
  // Switch back to disk 0.
  outb(0x1f6, 0xe0 | (0<<4));
8010267b:	83 ec 08             	sub    $0x8,%esp
8010267e:	68 e0 00 00 00       	push   $0xe0
80102683:	68 f6 01 00 00       	push   $0x1f6
80102688:	e8 d0 fe ff ff       	call   8010255d <outb>
8010268d:	83 c4 10             	add    $0x10,%esp
}
80102690:	c9                   	leave  
80102691:	c3                   	ret    

80102692 <idestart>:

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80102692:	55                   	push   %ebp
80102693:	89 e5                	mov    %esp,%ebp
80102695:	83 ec 18             	sub    $0x18,%esp
  if(b == 0)
80102698:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
8010269c:	75 0d                	jne    801026ab <idestart+0x19>
    panic("idestart");
8010269e:	83 ec 0c             	sub    $0xc,%esp
801026a1:	68 ce 88 10 80       	push   $0x801088ce
801026a6:	e8 b1 de ff ff       	call   8010055c <panic>
  if(b->blockno >= FSSIZE)
801026ab:	8b 45 08             	mov    0x8(%ebp),%eax
801026ae:	8b 40 08             	mov    0x8(%eax),%eax
801026b1:	3d e7 03 00 00       	cmp    $0x3e7,%eax
801026b6:	76 0d                	jbe    801026c5 <idestart+0x33>
    panic("incorrect blockno");
801026b8:	83 ec 0c             	sub    $0xc,%esp
801026bb:	68 d7 88 10 80       	push   $0x801088d7
801026c0:	e8 97 de ff ff       	call   8010055c <panic>
  int sector_per_block =  BSIZE/SECTOR_SIZE;
801026c5:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
  int sector = b->blockno * sector_per_block;
801026cc:	8b 45 08             	mov    0x8(%ebp),%eax
801026cf:	8b 50 08             	mov    0x8(%eax),%edx
801026d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801026d5:	0f af c2             	imul   %edx,%eax
801026d8:	89 45 f0             	mov    %eax,-0x10(%ebp)

  if (sector_per_block > 7) panic("idestart");
801026db:	83 7d f4 07          	cmpl   $0x7,-0xc(%ebp)
801026df:	7e 0d                	jle    801026ee <idestart+0x5c>
801026e1:	83 ec 0c             	sub    $0xc,%esp
801026e4:	68 ce 88 10 80       	push   $0x801088ce
801026e9:	e8 6e de ff ff       	call   8010055c <panic>
  
  idewait(0);
801026ee:	83 ec 0c             	sub    $0xc,%esp
801026f1:	6a 00                	push   $0x0
801026f3:	e8 a8 fe ff ff       	call   801025a0 <idewait>
801026f8:	83 c4 10             	add    $0x10,%esp
  outb(0x3f6, 0);  // generate interrupt
801026fb:	83 ec 08             	sub    $0x8,%esp
801026fe:	6a 00                	push   $0x0
80102700:	68 f6 03 00 00       	push   $0x3f6
80102705:	e8 53 fe ff ff       	call   8010255d <outb>
8010270a:	83 c4 10             	add    $0x10,%esp
  outb(0x1f2, sector_per_block);  // number of sectors
8010270d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102710:	0f b6 c0             	movzbl %al,%eax
80102713:	83 ec 08             	sub    $0x8,%esp
80102716:	50                   	push   %eax
80102717:	68 f2 01 00 00       	push   $0x1f2
8010271c:	e8 3c fe ff ff       	call   8010255d <outb>
80102721:	83 c4 10             	add    $0x10,%esp
  outb(0x1f3, sector & 0xff);
80102724:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102727:	0f b6 c0             	movzbl %al,%eax
8010272a:	83 ec 08             	sub    $0x8,%esp
8010272d:	50                   	push   %eax
8010272e:	68 f3 01 00 00       	push   $0x1f3
80102733:	e8 25 fe ff ff       	call   8010255d <outb>
80102738:	83 c4 10             	add    $0x10,%esp
  outb(0x1f4, (sector >> 8) & 0xff);
8010273b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010273e:	c1 f8 08             	sar    $0x8,%eax
80102741:	0f b6 c0             	movzbl %al,%eax
80102744:	83 ec 08             	sub    $0x8,%esp
80102747:	50                   	push   %eax
80102748:	68 f4 01 00 00       	push   $0x1f4
8010274d:	e8 0b fe ff ff       	call   8010255d <outb>
80102752:	83 c4 10             	add    $0x10,%esp
  outb(0x1f5, (sector >> 16) & 0xff);
80102755:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102758:	c1 f8 10             	sar    $0x10,%eax
8010275b:	0f b6 c0             	movzbl %al,%eax
8010275e:	83 ec 08             	sub    $0x8,%esp
80102761:	50                   	push   %eax
80102762:	68 f5 01 00 00       	push   $0x1f5
80102767:	e8 f1 fd ff ff       	call   8010255d <outb>
8010276c:	83 c4 10             	add    $0x10,%esp
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
8010276f:	8b 45 08             	mov    0x8(%ebp),%eax
80102772:	8b 40 04             	mov    0x4(%eax),%eax
80102775:	83 e0 01             	and    $0x1,%eax
80102778:	c1 e0 04             	shl    $0x4,%eax
8010277b:	89 c2                	mov    %eax,%edx
8010277d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102780:	c1 f8 18             	sar    $0x18,%eax
80102783:	83 e0 0f             	and    $0xf,%eax
80102786:	09 d0                	or     %edx,%eax
80102788:	83 c8 e0             	or     $0xffffffe0,%eax
8010278b:	0f b6 c0             	movzbl %al,%eax
8010278e:	83 ec 08             	sub    $0x8,%esp
80102791:	50                   	push   %eax
80102792:	68 f6 01 00 00       	push   $0x1f6
80102797:	e8 c1 fd ff ff       	call   8010255d <outb>
8010279c:	83 c4 10             	add    $0x10,%esp
  if(b->flags & B_DIRTY){
8010279f:	8b 45 08             	mov    0x8(%ebp),%eax
801027a2:	8b 00                	mov    (%eax),%eax
801027a4:	83 e0 04             	and    $0x4,%eax
801027a7:	85 c0                	test   %eax,%eax
801027a9:	74 30                	je     801027db <idestart+0x149>
    outb(0x1f7, IDE_CMD_WRITE);
801027ab:	83 ec 08             	sub    $0x8,%esp
801027ae:	6a 30                	push   $0x30
801027b0:	68 f7 01 00 00       	push   $0x1f7
801027b5:	e8 a3 fd ff ff       	call   8010255d <outb>
801027ba:	83 c4 10             	add    $0x10,%esp
    outsl(0x1f0, b->data, BSIZE/4);
801027bd:	8b 45 08             	mov    0x8(%ebp),%eax
801027c0:	83 c0 18             	add    $0x18,%eax
801027c3:	83 ec 04             	sub    $0x4,%esp
801027c6:	68 80 00 00 00       	push   $0x80
801027cb:	50                   	push   %eax
801027cc:	68 f0 01 00 00       	push   $0x1f0
801027d1:	e8 a5 fd ff ff       	call   8010257b <outsl>
801027d6:	83 c4 10             	add    $0x10,%esp
801027d9:	eb 12                	jmp    801027ed <idestart+0x15b>
  } else {
    outb(0x1f7, IDE_CMD_READ);
801027db:	83 ec 08             	sub    $0x8,%esp
801027de:	6a 20                	push   $0x20
801027e0:	68 f7 01 00 00       	push   $0x1f7
801027e5:	e8 73 fd ff ff       	call   8010255d <outb>
801027ea:	83 c4 10             	add    $0x10,%esp
  }
}
801027ed:	c9                   	leave  
801027ee:	c3                   	ret    

801027ef <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
801027ef:	55                   	push   %ebp
801027f0:	89 e5                	mov    %esp,%ebp
801027f2:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
801027f5:	83 ec 0c             	sub    $0xc,%esp
801027f8:	68 20 b6 10 80       	push   $0x8010b620
801027fd:	e8 45 2a 00 00       	call   80105247 <acquire>
80102802:	83 c4 10             	add    $0x10,%esp
  if((b = idequeue) == 0){
80102805:	a1 54 b6 10 80       	mov    0x8010b654,%eax
8010280a:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010280d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80102811:	75 15                	jne    80102828 <ideintr+0x39>
    release(&idelock);
80102813:	83 ec 0c             	sub    $0xc,%esp
80102816:	68 20 b6 10 80       	push   $0x8010b620
8010281b:	e8 8d 2a 00 00       	call   801052ad <release>
80102820:	83 c4 10             	add    $0x10,%esp
    // cprintf("spurious IDE interrupt\n");
    return;
80102823:	e9 9a 00 00 00       	jmp    801028c2 <ideintr+0xd3>
  }
  idequeue = b->qnext;
80102828:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010282b:	8b 40 14             	mov    0x14(%eax),%eax
8010282e:	a3 54 b6 10 80       	mov    %eax,0x8010b654

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102833:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102836:	8b 00                	mov    (%eax),%eax
80102838:	83 e0 04             	and    $0x4,%eax
8010283b:	85 c0                	test   %eax,%eax
8010283d:	75 2d                	jne    8010286c <ideintr+0x7d>
8010283f:	83 ec 0c             	sub    $0xc,%esp
80102842:	6a 01                	push   $0x1
80102844:	e8 57 fd ff ff       	call   801025a0 <idewait>
80102849:	83 c4 10             	add    $0x10,%esp
8010284c:	85 c0                	test   %eax,%eax
8010284e:	78 1c                	js     8010286c <ideintr+0x7d>
    insl(0x1f0, b->data, BSIZE/4);
80102850:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102853:	83 c0 18             	add    $0x18,%eax
80102856:	83 ec 04             	sub    $0x4,%esp
80102859:	68 80 00 00 00       	push   $0x80
8010285e:	50                   	push   %eax
8010285f:	68 f0 01 00 00       	push   $0x1f0
80102864:	e8 cf fc ff ff       	call   80102538 <insl>
80102869:	83 c4 10             	add    $0x10,%esp
  
  // Wake process waiting for this buf.
  b->flags |= B_VALID;
8010286c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010286f:	8b 00                	mov    (%eax),%eax
80102871:	83 c8 02             	or     $0x2,%eax
80102874:	89 c2                	mov    %eax,%edx
80102876:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102879:	89 10                	mov    %edx,(%eax)
  b->flags &= ~B_DIRTY;
8010287b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010287e:	8b 00                	mov    (%eax),%eax
80102880:	83 e0 fb             	and    $0xfffffffb,%eax
80102883:	89 c2                	mov    %eax,%edx
80102885:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102888:	89 10                	mov    %edx,(%eax)
  wakeup(b);
8010288a:	83 ec 0c             	sub    $0xc,%esp
8010288d:	ff 75 f4             	pushl  -0xc(%ebp)
80102890:	e8 98 27 00 00       	call   8010502d <wakeup>
80102895:	83 c4 10             	add    $0x10,%esp
  
  // Start disk on next buf in queue.
  if(idequeue != 0)
80102898:	a1 54 b6 10 80       	mov    0x8010b654,%eax
8010289d:	85 c0                	test   %eax,%eax
8010289f:	74 11                	je     801028b2 <ideintr+0xc3>
    idestart(idequeue);
801028a1:	a1 54 b6 10 80       	mov    0x8010b654,%eax
801028a6:	83 ec 0c             	sub    $0xc,%esp
801028a9:	50                   	push   %eax
801028aa:	e8 e3 fd ff ff       	call   80102692 <idestart>
801028af:	83 c4 10             	add    $0x10,%esp

  release(&idelock);
801028b2:	83 ec 0c             	sub    $0xc,%esp
801028b5:	68 20 b6 10 80       	push   $0x8010b620
801028ba:	e8 ee 29 00 00       	call   801052ad <release>
801028bf:	83 c4 10             	add    $0x10,%esp
}
801028c2:	c9                   	leave  
801028c3:	c3                   	ret    

801028c4 <iderw>:
// Sync buf with disk. 
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
801028c4:	55                   	push   %ebp
801028c5:	89 e5                	mov    %esp,%ebp
801028c7:	83 ec 18             	sub    $0x18,%esp
  struct buf **pp;

  if(!(b->flags & B_BUSY))
801028ca:	8b 45 08             	mov    0x8(%ebp),%eax
801028cd:	8b 00                	mov    (%eax),%eax
801028cf:	83 e0 01             	and    $0x1,%eax
801028d2:	85 c0                	test   %eax,%eax
801028d4:	75 0d                	jne    801028e3 <iderw+0x1f>
    panic("iderw: buf not busy");
801028d6:	83 ec 0c             	sub    $0xc,%esp
801028d9:	68 e9 88 10 80       	push   $0x801088e9
801028de:	e8 79 dc ff ff       	call   8010055c <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
801028e3:	8b 45 08             	mov    0x8(%ebp),%eax
801028e6:	8b 00                	mov    (%eax),%eax
801028e8:	83 e0 06             	and    $0x6,%eax
801028eb:	83 f8 02             	cmp    $0x2,%eax
801028ee:	75 0d                	jne    801028fd <iderw+0x39>
    panic("iderw: nothing to do");
801028f0:	83 ec 0c             	sub    $0xc,%esp
801028f3:	68 fd 88 10 80       	push   $0x801088fd
801028f8:	e8 5f dc ff ff       	call   8010055c <panic>
  if(b->dev != 0 && !havedisk1)
801028fd:	8b 45 08             	mov    0x8(%ebp),%eax
80102900:	8b 40 04             	mov    0x4(%eax),%eax
80102903:	85 c0                	test   %eax,%eax
80102905:	74 16                	je     8010291d <iderw+0x59>
80102907:	a1 58 b6 10 80       	mov    0x8010b658,%eax
8010290c:	85 c0                	test   %eax,%eax
8010290e:	75 0d                	jne    8010291d <iderw+0x59>
    panic("iderw: ide disk 1 not present");
80102910:	83 ec 0c             	sub    $0xc,%esp
80102913:	68 12 89 10 80       	push   $0x80108912
80102918:	e8 3f dc ff ff       	call   8010055c <panic>

  acquire(&idelock);  //DOC:acquire-lock
8010291d:	83 ec 0c             	sub    $0xc,%esp
80102920:	68 20 b6 10 80       	push   $0x8010b620
80102925:	e8 1d 29 00 00       	call   80105247 <acquire>
8010292a:	83 c4 10             	add    $0x10,%esp

  // Append b to idequeue.
  b->qnext = 0;
8010292d:	8b 45 08             	mov    0x8(%ebp),%eax
80102930:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102937:	c7 45 f4 54 b6 10 80 	movl   $0x8010b654,-0xc(%ebp)
8010293e:	eb 0b                	jmp    8010294b <iderw+0x87>
80102940:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102943:	8b 00                	mov    (%eax),%eax
80102945:	83 c0 14             	add    $0x14,%eax
80102948:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010294b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010294e:	8b 00                	mov    (%eax),%eax
80102950:	85 c0                	test   %eax,%eax
80102952:	75 ec                	jne    80102940 <iderw+0x7c>
    ;
  *pp = b;
80102954:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102957:	8b 55 08             	mov    0x8(%ebp),%edx
8010295a:	89 10                	mov    %edx,(%eax)
  
  // Start disk if necessary.
  if(idequeue == b)
8010295c:	a1 54 b6 10 80       	mov    0x8010b654,%eax
80102961:	3b 45 08             	cmp    0x8(%ebp),%eax
80102964:	75 0e                	jne    80102974 <iderw+0xb0>
    idestart(b);
80102966:	83 ec 0c             	sub    $0xc,%esp
80102969:	ff 75 08             	pushl  0x8(%ebp)
8010296c:	e8 21 fd ff ff       	call   80102692 <idestart>
80102971:	83 c4 10             	add    $0x10,%esp
  
  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102974:	eb 13                	jmp    80102989 <iderw+0xc5>
    sleep(b, &idelock);
80102976:	83 ec 08             	sub    $0x8,%esp
80102979:	68 20 b6 10 80       	push   $0x8010b620
8010297e:	ff 75 08             	pushl  0x8(%ebp)
80102981:	e8 9b 25 00 00       	call   80104f21 <sleep>
80102986:	83 c4 10             	add    $0x10,%esp
  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);
  
  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102989:	8b 45 08             	mov    0x8(%ebp),%eax
8010298c:	8b 00                	mov    (%eax),%eax
8010298e:	83 e0 06             	and    $0x6,%eax
80102991:	83 f8 02             	cmp    $0x2,%eax
80102994:	75 e0                	jne    80102976 <iderw+0xb2>
    sleep(b, &idelock);
  }

  release(&idelock);
80102996:	83 ec 0c             	sub    $0xc,%esp
80102999:	68 20 b6 10 80       	push   $0x8010b620
8010299e:	e8 0a 29 00 00       	call   801052ad <release>
801029a3:	83 c4 10             	add    $0x10,%esp
}
801029a6:	c9                   	leave  
801029a7:	c3                   	ret    

801029a8 <ioapicread>:
  uint data;
};

static uint
ioapicread(int reg)
{
801029a8:	55                   	push   %ebp
801029a9:	89 e5                	mov    %esp,%ebp
  ioapic->reg = reg;
801029ab:	a1 94 24 11 80       	mov    0x80112494,%eax
801029b0:	8b 55 08             	mov    0x8(%ebp),%edx
801029b3:	89 10                	mov    %edx,(%eax)
  return ioapic->data;
801029b5:	a1 94 24 11 80       	mov    0x80112494,%eax
801029ba:	8b 40 10             	mov    0x10(%eax),%eax
}
801029bd:	5d                   	pop    %ebp
801029be:	c3                   	ret    

801029bf <ioapicwrite>:

static void
ioapicwrite(int reg, uint data)
{
801029bf:	55                   	push   %ebp
801029c0:	89 e5                	mov    %esp,%ebp
  ioapic->reg = reg;
801029c2:	a1 94 24 11 80       	mov    0x80112494,%eax
801029c7:	8b 55 08             	mov    0x8(%ebp),%edx
801029ca:	89 10                	mov    %edx,(%eax)
  ioapic->data = data;
801029cc:	a1 94 24 11 80       	mov    0x80112494,%eax
801029d1:	8b 55 0c             	mov    0xc(%ebp),%edx
801029d4:	89 50 10             	mov    %edx,0x10(%eax)
}
801029d7:	5d                   	pop    %ebp
801029d8:	c3                   	ret    

801029d9 <ioapicinit>:

void
ioapicinit(void)
{
801029d9:	55                   	push   %ebp
801029da:	89 e5                	mov    %esp,%ebp
801029dc:	83 ec 18             	sub    $0x18,%esp
  int i, id, maxintr;

  if(!ismp)
801029df:	a1 04 26 11 80       	mov    0x80112604,%eax
801029e4:	85 c0                	test   %eax,%eax
801029e6:	75 05                	jne    801029ed <ioapicinit+0x14>
    return;
801029e8:	e9 9e 00 00 00       	jmp    80102a8b <ioapicinit+0xb2>

  ioapic = (volatile struct ioapic*)IOAPIC;
801029ed:	c7 05 94 24 11 80 00 	movl   $0xfec00000,0x80112494
801029f4:	00 c0 fe 
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
801029f7:	6a 01                	push   $0x1
801029f9:	e8 aa ff ff ff       	call   801029a8 <ioapicread>
801029fe:	83 c4 04             	add    $0x4,%esp
80102a01:	c1 e8 10             	shr    $0x10,%eax
80102a04:	25 ff 00 00 00       	and    $0xff,%eax
80102a09:	89 45 f0             	mov    %eax,-0x10(%ebp)
  id = ioapicread(REG_ID) >> 24;
80102a0c:	6a 00                	push   $0x0
80102a0e:	e8 95 ff ff ff       	call   801029a8 <ioapicread>
80102a13:	83 c4 04             	add    $0x4,%esp
80102a16:	c1 e8 18             	shr    $0x18,%eax
80102a19:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(id != ioapicid)
80102a1c:	0f b6 05 00 26 11 80 	movzbl 0x80112600,%eax
80102a23:	0f b6 c0             	movzbl %al,%eax
80102a26:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80102a29:	74 10                	je     80102a3b <ioapicinit+0x62>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102a2b:	83 ec 0c             	sub    $0xc,%esp
80102a2e:	68 30 89 10 80       	push   $0x80108930
80102a33:	e8 87 d9 ff ff       	call   801003bf <cprintf>
80102a38:	83 c4 10             	add    $0x10,%esp

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
80102a3b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80102a42:	eb 3f                	jmp    80102a83 <ioapicinit+0xaa>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102a44:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102a47:	83 c0 20             	add    $0x20,%eax
80102a4a:	0d 00 00 01 00       	or     $0x10000,%eax
80102a4f:	89 c2                	mov    %eax,%edx
80102a51:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102a54:	83 c0 08             	add    $0x8,%eax
80102a57:	01 c0                	add    %eax,%eax
80102a59:	83 ec 08             	sub    $0x8,%esp
80102a5c:	52                   	push   %edx
80102a5d:	50                   	push   %eax
80102a5e:	e8 5c ff ff ff       	call   801029bf <ioapicwrite>
80102a63:	83 c4 10             	add    $0x10,%esp
    ioapicwrite(REG_TABLE+2*i+1, 0);
80102a66:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102a69:	83 c0 08             	add    $0x8,%eax
80102a6c:	01 c0                	add    %eax,%eax
80102a6e:	83 c0 01             	add    $0x1,%eax
80102a71:	83 ec 08             	sub    $0x8,%esp
80102a74:	6a 00                	push   $0x0
80102a76:	50                   	push   %eax
80102a77:	e8 43 ff ff ff       	call   801029bf <ioapicwrite>
80102a7c:	83 c4 10             	add    $0x10,%esp
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
80102a7f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80102a83:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102a86:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80102a89:	7e b9                	jle    80102a44 <ioapicinit+0x6b>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
80102a8b:	c9                   	leave  
80102a8c:	c3                   	ret    

80102a8d <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102a8d:	55                   	push   %ebp
80102a8e:	89 e5                	mov    %esp,%ebp
  if(!ismp)
80102a90:	a1 04 26 11 80       	mov    0x80112604,%eax
80102a95:	85 c0                	test   %eax,%eax
80102a97:	75 02                	jne    80102a9b <ioapicenable+0xe>
    return;
80102a99:	eb 37                	jmp    80102ad2 <ioapicenable+0x45>

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
80102a9b:	8b 45 08             	mov    0x8(%ebp),%eax
80102a9e:	83 c0 20             	add    $0x20,%eax
80102aa1:	89 c2                	mov    %eax,%edx
80102aa3:	8b 45 08             	mov    0x8(%ebp),%eax
80102aa6:	83 c0 08             	add    $0x8,%eax
80102aa9:	01 c0                	add    %eax,%eax
80102aab:	52                   	push   %edx
80102aac:	50                   	push   %eax
80102aad:	e8 0d ff ff ff       	call   801029bf <ioapicwrite>
80102ab2:	83 c4 08             	add    $0x8,%esp
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102ab5:	8b 45 0c             	mov    0xc(%ebp),%eax
80102ab8:	c1 e0 18             	shl    $0x18,%eax
80102abb:	89 c2                	mov    %eax,%edx
80102abd:	8b 45 08             	mov    0x8(%ebp),%eax
80102ac0:	83 c0 08             	add    $0x8,%eax
80102ac3:	01 c0                	add    %eax,%eax
80102ac5:	83 c0 01             	add    $0x1,%eax
80102ac8:	52                   	push   %edx
80102ac9:	50                   	push   %eax
80102aca:	e8 f0 fe ff ff       	call   801029bf <ioapicwrite>
80102acf:	83 c4 08             	add    $0x8,%esp
}
80102ad2:	c9                   	leave  
80102ad3:	c3                   	ret    

80102ad4 <v2p>:
#define KERNBASE 0x80000000         // First kernel virtual address
#define KERNLINK (KERNBASE+EXTMEM)  // Address where kernel is linked

#ifndef __ASSEMBLER__

static inline uint v2p(void *a) { return ((uint) (a))  - KERNBASE; }
80102ad4:	55                   	push   %ebp
80102ad5:	89 e5                	mov    %esp,%ebp
80102ad7:	8b 45 08             	mov    0x8(%ebp),%eax
80102ada:	05 00 00 00 80       	add    $0x80000000,%eax
80102adf:	5d                   	pop    %ebp
80102ae0:	c3                   	ret    

80102ae1 <kinit1>:
// the pages mapped by entrypgdir on free list.
// 2. main() calls kinit2() with the rest of the physical pages
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
80102ae1:	55                   	push   %ebp
80102ae2:	89 e5                	mov    %esp,%ebp
80102ae4:	83 ec 08             	sub    $0x8,%esp
  initlock(&kmem.lock, "kmem");
80102ae7:	83 ec 08             	sub    $0x8,%esp
80102aea:	68 62 89 10 80       	push   $0x80108962
80102aef:	68 a0 24 11 80       	push   $0x801124a0
80102af4:	e8 2d 27 00 00       	call   80105226 <initlock>
80102af9:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102afc:	c7 05 d4 24 11 80 00 	movl   $0x0,0x801124d4
80102b03:	00 00 00 
  freerange(vstart, vend);
80102b06:	83 ec 08             	sub    $0x8,%esp
80102b09:	ff 75 0c             	pushl  0xc(%ebp)
80102b0c:	ff 75 08             	pushl  0x8(%ebp)
80102b0f:	e8 28 00 00 00       	call   80102b3c <freerange>
80102b14:	83 c4 10             	add    $0x10,%esp
}
80102b17:	c9                   	leave  
80102b18:	c3                   	ret    

80102b19 <kinit2>:

void
kinit2(void *vstart, void *vend)
{
80102b19:	55                   	push   %ebp
80102b1a:	89 e5                	mov    %esp,%ebp
80102b1c:	83 ec 08             	sub    $0x8,%esp
  freerange(vstart, vend);
80102b1f:	83 ec 08             	sub    $0x8,%esp
80102b22:	ff 75 0c             	pushl  0xc(%ebp)
80102b25:	ff 75 08             	pushl  0x8(%ebp)
80102b28:	e8 0f 00 00 00       	call   80102b3c <freerange>
80102b2d:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 1;
80102b30:	c7 05 d4 24 11 80 01 	movl   $0x1,0x801124d4
80102b37:	00 00 00 
}
80102b3a:	c9                   	leave  
80102b3b:	c3                   	ret    

80102b3c <freerange>:

void
freerange(void *vstart, void *vend)
{
80102b3c:	55                   	push   %ebp
80102b3d:	89 e5                	mov    %esp,%ebp
80102b3f:	83 ec 18             	sub    $0x18,%esp
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
80102b42:	8b 45 08             	mov    0x8(%ebp),%eax
80102b45:	05 ff 0f 00 00       	add    $0xfff,%eax
80102b4a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80102b4f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102b52:	eb 15                	jmp    80102b69 <freerange+0x2d>
    kfree(p);
80102b54:	83 ec 0c             	sub    $0xc,%esp
80102b57:	ff 75 f4             	pushl  -0xc(%ebp)
80102b5a:	e8 19 00 00 00       	call   80102b78 <kfree>
80102b5f:	83 c4 10             	add    $0x10,%esp
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102b62:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80102b69:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102b6c:	05 00 10 00 00       	add    $0x1000,%eax
80102b71:	3b 45 0c             	cmp    0xc(%ebp),%eax
80102b74:	76 de                	jbe    80102b54 <freerange+0x18>
    kfree(p);
}
80102b76:	c9                   	leave  
80102b77:	c3                   	ret    

80102b78 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102b78:	55                   	push   %ebp
80102b79:	89 e5                	mov    %esp,%ebp
80102b7b:	83 ec 18             	sub    $0x18,%esp
  struct run *r;

  if((uint)v % PGSIZE || v < end || v2p(v) >= PHYSTOP)
80102b7e:	8b 45 08             	mov    0x8(%ebp),%eax
80102b81:	25 ff 0f 00 00       	and    $0xfff,%eax
80102b86:	85 c0                	test   %eax,%eax
80102b88:	75 1b                	jne    80102ba5 <kfree+0x2d>
80102b8a:	81 7d 08 1c 55 11 80 	cmpl   $0x8011551c,0x8(%ebp)
80102b91:	72 12                	jb     80102ba5 <kfree+0x2d>
80102b93:	ff 75 08             	pushl  0x8(%ebp)
80102b96:	e8 39 ff ff ff       	call   80102ad4 <v2p>
80102b9b:	83 c4 04             	add    $0x4,%esp
80102b9e:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102ba3:	76 0d                	jbe    80102bb2 <kfree+0x3a>
    panic("kfree");
80102ba5:	83 ec 0c             	sub    $0xc,%esp
80102ba8:	68 67 89 10 80       	push   $0x80108967
80102bad:	e8 aa d9 ff ff       	call   8010055c <panic>

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102bb2:	83 ec 04             	sub    $0x4,%esp
80102bb5:	68 00 10 00 00       	push   $0x1000
80102bba:	6a 01                	push   $0x1
80102bbc:	ff 75 08             	pushl  0x8(%ebp)
80102bbf:	e8 df 28 00 00       	call   801054a3 <memset>
80102bc4:	83 c4 10             	add    $0x10,%esp

  if(kmem.use_lock)
80102bc7:	a1 d4 24 11 80       	mov    0x801124d4,%eax
80102bcc:	85 c0                	test   %eax,%eax
80102bce:	74 10                	je     80102be0 <kfree+0x68>
    acquire(&kmem.lock);
80102bd0:	83 ec 0c             	sub    $0xc,%esp
80102bd3:	68 a0 24 11 80       	push   $0x801124a0
80102bd8:	e8 6a 26 00 00       	call   80105247 <acquire>
80102bdd:	83 c4 10             	add    $0x10,%esp
  r = (struct run*)v;
80102be0:	8b 45 08             	mov    0x8(%ebp),%eax
80102be3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  r->next = kmem.freelist;
80102be6:	8b 15 d8 24 11 80    	mov    0x801124d8,%edx
80102bec:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102bef:	89 10                	mov    %edx,(%eax)
  kmem.freelist = r;
80102bf1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102bf4:	a3 d8 24 11 80       	mov    %eax,0x801124d8
  if(kmem.use_lock)
80102bf9:	a1 d4 24 11 80       	mov    0x801124d4,%eax
80102bfe:	85 c0                	test   %eax,%eax
80102c00:	74 10                	je     80102c12 <kfree+0x9a>
    release(&kmem.lock);
80102c02:	83 ec 0c             	sub    $0xc,%esp
80102c05:	68 a0 24 11 80       	push   $0x801124a0
80102c0a:	e8 9e 26 00 00       	call   801052ad <release>
80102c0f:	83 c4 10             	add    $0x10,%esp
}
80102c12:	c9                   	leave  
80102c13:	c3                   	ret    

80102c14 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80102c14:	55                   	push   %ebp
80102c15:	89 e5                	mov    %esp,%ebp
80102c17:	83 ec 18             	sub    $0x18,%esp
  struct run *r;

  if(kmem.use_lock)
80102c1a:	a1 d4 24 11 80       	mov    0x801124d4,%eax
80102c1f:	85 c0                	test   %eax,%eax
80102c21:	74 10                	je     80102c33 <kalloc+0x1f>
    acquire(&kmem.lock);
80102c23:	83 ec 0c             	sub    $0xc,%esp
80102c26:	68 a0 24 11 80       	push   $0x801124a0
80102c2b:	e8 17 26 00 00       	call   80105247 <acquire>
80102c30:	83 c4 10             	add    $0x10,%esp
  r = kmem.freelist;
80102c33:	a1 d8 24 11 80       	mov    0x801124d8,%eax
80102c38:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(r)
80102c3b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80102c3f:	74 0a                	je     80102c4b <kalloc+0x37>
    kmem.freelist = r->next;
80102c41:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102c44:	8b 00                	mov    (%eax),%eax
80102c46:	a3 d8 24 11 80       	mov    %eax,0x801124d8
  if(kmem.use_lock)
80102c4b:	a1 d4 24 11 80       	mov    0x801124d4,%eax
80102c50:	85 c0                	test   %eax,%eax
80102c52:	74 10                	je     80102c64 <kalloc+0x50>
    release(&kmem.lock);
80102c54:	83 ec 0c             	sub    $0xc,%esp
80102c57:	68 a0 24 11 80       	push   $0x801124a0
80102c5c:	e8 4c 26 00 00       	call   801052ad <release>
80102c61:	83 c4 10             	add    $0x10,%esp
  return (char*)r;
80102c64:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80102c67:	c9                   	leave  
80102c68:	c3                   	ret    

80102c69 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
80102c69:	55                   	push   %ebp
80102c6a:	89 e5                	mov    %esp,%ebp
80102c6c:	83 ec 14             	sub    $0x14,%esp
80102c6f:	8b 45 08             	mov    0x8(%ebp),%eax
80102c72:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c76:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80102c7a:	89 c2                	mov    %eax,%edx
80102c7c:	ec                   	in     (%dx),%al
80102c7d:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80102c80:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80102c84:	c9                   	leave  
80102c85:	c3                   	ret    

80102c86 <kbdgetc>:
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
80102c86:	55                   	push   %ebp
80102c87:	89 e5                	mov    %esp,%ebp
80102c89:	83 ec 10             	sub    $0x10,%esp
  static uchar *charcode[4] = {
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
80102c8c:	6a 64                	push   $0x64
80102c8e:	e8 d6 ff ff ff       	call   80102c69 <inb>
80102c93:	83 c4 04             	add    $0x4,%esp
80102c96:	0f b6 c0             	movzbl %al,%eax
80102c99:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((st & KBS_DIB) == 0)
80102c9c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102c9f:	83 e0 01             	and    $0x1,%eax
80102ca2:	85 c0                	test   %eax,%eax
80102ca4:	75 0a                	jne    80102cb0 <kbdgetc+0x2a>
    return -1;
80102ca6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102cab:	e9 23 01 00 00       	jmp    80102dd3 <kbdgetc+0x14d>
  data = inb(KBDATAP);
80102cb0:	6a 60                	push   $0x60
80102cb2:	e8 b2 ff ff ff       	call   80102c69 <inb>
80102cb7:	83 c4 04             	add    $0x4,%esp
80102cba:	0f b6 c0             	movzbl %al,%eax
80102cbd:	89 45 fc             	mov    %eax,-0x4(%ebp)

  if(data == 0xE0){
80102cc0:	81 7d fc e0 00 00 00 	cmpl   $0xe0,-0x4(%ebp)
80102cc7:	75 17                	jne    80102ce0 <kbdgetc+0x5a>
    shift |= E0ESC;
80102cc9:	a1 5c b6 10 80       	mov    0x8010b65c,%eax
80102cce:	83 c8 40             	or     $0x40,%eax
80102cd1:	a3 5c b6 10 80       	mov    %eax,0x8010b65c
    return 0;
80102cd6:	b8 00 00 00 00       	mov    $0x0,%eax
80102cdb:	e9 f3 00 00 00       	jmp    80102dd3 <kbdgetc+0x14d>
  } else if(data & 0x80){
80102ce0:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102ce3:	25 80 00 00 00       	and    $0x80,%eax
80102ce8:	85 c0                	test   %eax,%eax
80102cea:	74 45                	je     80102d31 <kbdgetc+0xab>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
80102cec:	a1 5c b6 10 80       	mov    0x8010b65c,%eax
80102cf1:	83 e0 40             	and    $0x40,%eax
80102cf4:	85 c0                	test   %eax,%eax
80102cf6:	75 08                	jne    80102d00 <kbdgetc+0x7a>
80102cf8:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102cfb:	83 e0 7f             	and    $0x7f,%eax
80102cfe:	eb 03                	jmp    80102d03 <kbdgetc+0x7d>
80102d00:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102d03:	89 45 fc             	mov    %eax,-0x4(%ebp)
    shift &= ~(shiftcode[data] | E0ESC);
80102d06:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102d09:	05 40 90 10 80       	add    $0x80109040,%eax
80102d0e:	0f b6 00             	movzbl (%eax),%eax
80102d11:	83 c8 40             	or     $0x40,%eax
80102d14:	0f b6 c0             	movzbl %al,%eax
80102d17:	f7 d0                	not    %eax
80102d19:	89 c2                	mov    %eax,%edx
80102d1b:	a1 5c b6 10 80       	mov    0x8010b65c,%eax
80102d20:	21 d0                	and    %edx,%eax
80102d22:	a3 5c b6 10 80       	mov    %eax,0x8010b65c
    return 0;
80102d27:	b8 00 00 00 00       	mov    $0x0,%eax
80102d2c:	e9 a2 00 00 00       	jmp    80102dd3 <kbdgetc+0x14d>
  } else if(shift & E0ESC){
80102d31:	a1 5c b6 10 80       	mov    0x8010b65c,%eax
80102d36:	83 e0 40             	and    $0x40,%eax
80102d39:	85 c0                	test   %eax,%eax
80102d3b:	74 14                	je     80102d51 <kbdgetc+0xcb>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102d3d:	81 4d fc 80 00 00 00 	orl    $0x80,-0x4(%ebp)
    shift &= ~E0ESC;
80102d44:	a1 5c b6 10 80       	mov    0x8010b65c,%eax
80102d49:	83 e0 bf             	and    $0xffffffbf,%eax
80102d4c:	a3 5c b6 10 80       	mov    %eax,0x8010b65c
  }

  shift |= shiftcode[data];
80102d51:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102d54:	05 40 90 10 80       	add    $0x80109040,%eax
80102d59:	0f b6 00             	movzbl (%eax),%eax
80102d5c:	0f b6 d0             	movzbl %al,%edx
80102d5f:	a1 5c b6 10 80       	mov    0x8010b65c,%eax
80102d64:	09 d0                	or     %edx,%eax
80102d66:	a3 5c b6 10 80       	mov    %eax,0x8010b65c
  shift ^= togglecode[data];
80102d6b:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102d6e:	05 40 91 10 80       	add    $0x80109140,%eax
80102d73:	0f b6 00             	movzbl (%eax),%eax
80102d76:	0f b6 d0             	movzbl %al,%edx
80102d79:	a1 5c b6 10 80       	mov    0x8010b65c,%eax
80102d7e:	31 d0                	xor    %edx,%eax
80102d80:	a3 5c b6 10 80       	mov    %eax,0x8010b65c
  c = charcode[shift & (CTL | SHIFT)][data];
80102d85:	a1 5c b6 10 80       	mov    0x8010b65c,%eax
80102d8a:	83 e0 03             	and    $0x3,%eax
80102d8d:	8b 14 85 40 95 10 80 	mov    -0x7fef6ac0(,%eax,4),%edx
80102d94:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102d97:	01 d0                	add    %edx,%eax
80102d99:	0f b6 00             	movzbl (%eax),%eax
80102d9c:	0f b6 c0             	movzbl %al,%eax
80102d9f:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if(shift & CAPSLOCK){
80102da2:	a1 5c b6 10 80       	mov    0x8010b65c,%eax
80102da7:	83 e0 08             	and    $0x8,%eax
80102daa:	85 c0                	test   %eax,%eax
80102dac:	74 22                	je     80102dd0 <kbdgetc+0x14a>
    if('a' <= c && c <= 'z')
80102dae:	83 7d f8 60          	cmpl   $0x60,-0x8(%ebp)
80102db2:	76 0c                	jbe    80102dc0 <kbdgetc+0x13a>
80102db4:	83 7d f8 7a          	cmpl   $0x7a,-0x8(%ebp)
80102db8:	77 06                	ja     80102dc0 <kbdgetc+0x13a>
      c += 'A' - 'a';
80102dba:	83 6d f8 20          	subl   $0x20,-0x8(%ebp)
80102dbe:	eb 10                	jmp    80102dd0 <kbdgetc+0x14a>
    else if('A' <= c && c <= 'Z')
80102dc0:	83 7d f8 40          	cmpl   $0x40,-0x8(%ebp)
80102dc4:	76 0a                	jbe    80102dd0 <kbdgetc+0x14a>
80102dc6:	83 7d f8 5a          	cmpl   $0x5a,-0x8(%ebp)
80102dca:	77 04                	ja     80102dd0 <kbdgetc+0x14a>
      c += 'a' - 'A';
80102dcc:	83 45 f8 20          	addl   $0x20,-0x8(%ebp)
  }
  return c;
80102dd0:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
80102dd3:	c9                   	leave  
80102dd4:	c3                   	ret    

80102dd5 <kbdintr>:

void
kbdintr(void)
{
80102dd5:	55                   	push   %ebp
80102dd6:	89 e5                	mov    %esp,%ebp
80102dd8:	83 ec 08             	sub    $0x8,%esp
  consoleintr(kbdgetc);
80102ddb:	83 ec 0c             	sub    $0xc,%esp
80102dde:	68 86 2c 10 80       	push   $0x80102c86
80102de3:	e8 e9 d9 ff ff       	call   801007d1 <consoleintr>
80102de8:	83 c4 10             	add    $0x10,%esp
}
80102deb:	c9                   	leave  
80102dec:	c3                   	ret    

80102ded <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
80102ded:	55                   	push   %ebp
80102dee:	89 e5                	mov    %esp,%ebp
80102df0:	83 ec 14             	sub    $0x14,%esp
80102df3:	8b 45 08             	mov    0x8(%ebp),%eax
80102df6:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102dfa:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80102dfe:	89 c2                	mov    %eax,%edx
80102e00:	ec                   	in     (%dx),%al
80102e01:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80102e04:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80102e08:	c9                   	leave  
80102e09:	c3                   	ret    

80102e0a <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80102e0a:	55                   	push   %ebp
80102e0b:	89 e5                	mov    %esp,%ebp
80102e0d:	83 ec 08             	sub    $0x8,%esp
80102e10:	8b 55 08             	mov    0x8(%ebp),%edx
80102e13:	8b 45 0c             	mov    0xc(%ebp),%eax
80102e16:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80102e1a:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102e1d:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80102e21:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80102e25:	ee                   	out    %al,(%dx)
}
80102e26:	c9                   	leave  
80102e27:	c3                   	ret    

80102e28 <readeflags>:
  asm volatile("ltr %0" : : "r" (sel));
}

static inline uint
readeflags(void)
{
80102e28:	55                   	push   %ebp
80102e29:	89 e5                	mov    %esp,%ebp
80102e2b:	83 ec 10             	sub    $0x10,%esp
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80102e2e:	9c                   	pushf  
80102e2f:	58                   	pop    %eax
80102e30:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return eflags;
80102e33:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80102e36:	c9                   	leave  
80102e37:	c3                   	ret    

80102e38 <lapicw>:

volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
80102e38:	55                   	push   %ebp
80102e39:	89 e5                	mov    %esp,%ebp
  lapic[index] = value;
80102e3b:	a1 dc 24 11 80       	mov    0x801124dc,%eax
80102e40:	8b 55 08             	mov    0x8(%ebp),%edx
80102e43:	c1 e2 02             	shl    $0x2,%edx
80102e46:	01 c2                	add    %eax,%edx
80102e48:	8b 45 0c             	mov    0xc(%ebp),%eax
80102e4b:	89 02                	mov    %eax,(%edx)
  lapic[ID];  // wait for write to finish, by reading
80102e4d:	a1 dc 24 11 80       	mov    0x801124dc,%eax
80102e52:	83 c0 20             	add    $0x20,%eax
80102e55:	8b 00                	mov    (%eax),%eax
}
80102e57:	5d                   	pop    %ebp
80102e58:	c3                   	ret    

80102e59 <lapicinit>:
//PAGEBREAK!

void
lapicinit(void)
{
80102e59:	55                   	push   %ebp
80102e5a:	89 e5                	mov    %esp,%ebp
  if(!lapic) 
80102e5c:	a1 dc 24 11 80       	mov    0x801124dc,%eax
80102e61:	85 c0                	test   %eax,%eax
80102e63:	75 05                	jne    80102e6a <lapicinit+0x11>
    return;
80102e65:	e9 09 01 00 00       	jmp    80102f73 <lapicinit+0x11a>

  // Enable local APIC; set spurious interrupt vector.
  lapicw(SVR, ENABLE | (T_IRQ0 + IRQ_SPURIOUS));
80102e6a:	68 3f 01 00 00       	push   $0x13f
80102e6f:	6a 3c                	push   $0x3c
80102e71:	e8 c2 ff ff ff       	call   80102e38 <lapicw>
80102e76:	83 c4 08             	add    $0x8,%esp

  // The timer repeatedly counts down at bus frequency
  // from lapic[TICR] and then issues an interrupt.  
  // If xv6 cared more about precise timekeeping,
  // TICR would be calibrated using an external time source.
  lapicw(TDCR, X1);
80102e79:	6a 0b                	push   $0xb
80102e7b:	68 f8 00 00 00       	push   $0xf8
80102e80:	e8 b3 ff ff ff       	call   80102e38 <lapicw>
80102e85:	83 c4 08             	add    $0x8,%esp
  lapicw(TIMER, PERIODIC | (T_IRQ0 + IRQ_TIMER));
80102e88:	68 20 00 02 00       	push   $0x20020
80102e8d:	68 c8 00 00 00       	push   $0xc8
80102e92:	e8 a1 ff ff ff       	call   80102e38 <lapicw>
80102e97:	83 c4 08             	add    $0x8,%esp
  lapicw(TICR, 10000000); 
80102e9a:	68 80 96 98 00       	push   $0x989680
80102e9f:	68 e0 00 00 00       	push   $0xe0
80102ea4:	e8 8f ff ff ff       	call   80102e38 <lapicw>
80102ea9:	83 c4 08             	add    $0x8,%esp

  // Disable logical interrupt lines.
  lapicw(LINT0, MASKED);
80102eac:	68 00 00 01 00       	push   $0x10000
80102eb1:	68 d4 00 00 00       	push   $0xd4
80102eb6:	e8 7d ff ff ff       	call   80102e38 <lapicw>
80102ebb:	83 c4 08             	add    $0x8,%esp
  lapicw(LINT1, MASKED);
80102ebe:	68 00 00 01 00       	push   $0x10000
80102ec3:	68 d8 00 00 00       	push   $0xd8
80102ec8:	e8 6b ff ff ff       	call   80102e38 <lapicw>
80102ecd:	83 c4 08             	add    $0x8,%esp

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
80102ed0:	a1 dc 24 11 80       	mov    0x801124dc,%eax
80102ed5:	83 c0 30             	add    $0x30,%eax
80102ed8:	8b 00                	mov    (%eax),%eax
80102eda:	c1 e8 10             	shr    $0x10,%eax
80102edd:	0f b6 c0             	movzbl %al,%eax
80102ee0:	83 f8 03             	cmp    $0x3,%eax
80102ee3:	76 12                	jbe    80102ef7 <lapicinit+0x9e>
    lapicw(PCINT, MASKED);
80102ee5:	68 00 00 01 00       	push   $0x10000
80102eea:	68 d0 00 00 00       	push   $0xd0
80102eef:	e8 44 ff ff ff       	call   80102e38 <lapicw>
80102ef4:	83 c4 08             	add    $0x8,%esp

  // Map error interrupt to IRQ_ERROR.
  lapicw(ERROR, T_IRQ0 + IRQ_ERROR);
80102ef7:	6a 33                	push   $0x33
80102ef9:	68 dc 00 00 00       	push   $0xdc
80102efe:	e8 35 ff ff ff       	call   80102e38 <lapicw>
80102f03:	83 c4 08             	add    $0x8,%esp

  // Clear error status register (requires back-to-back writes).
  lapicw(ESR, 0);
80102f06:	6a 00                	push   $0x0
80102f08:	68 a0 00 00 00       	push   $0xa0
80102f0d:	e8 26 ff ff ff       	call   80102e38 <lapicw>
80102f12:	83 c4 08             	add    $0x8,%esp
  lapicw(ESR, 0);
80102f15:	6a 00                	push   $0x0
80102f17:	68 a0 00 00 00       	push   $0xa0
80102f1c:	e8 17 ff ff ff       	call   80102e38 <lapicw>
80102f21:	83 c4 08             	add    $0x8,%esp

  // Ack any outstanding interrupts.
  lapicw(EOI, 0);
80102f24:	6a 00                	push   $0x0
80102f26:	6a 2c                	push   $0x2c
80102f28:	e8 0b ff ff ff       	call   80102e38 <lapicw>
80102f2d:	83 c4 08             	add    $0x8,%esp

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
80102f30:	6a 00                	push   $0x0
80102f32:	68 c4 00 00 00       	push   $0xc4
80102f37:	e8 fc fe ff ff       	call   80102e38 <lapicw>
80102f3c:	83 c4 08             	add    $0x8,%esp
  lapicw(ICRLO, BCAST | INIT | LEVEL);
80102f3f:	68 00 85 08 00       	push   $0x88500
80102f44:	68 c0 00 00 00       	push   $0xc0
80102f49:	e8 ea fe ff ff       	call   80102e38 <lapicw>
80102f4e:	83 c4 08             	add    $0x8,%esp
  while(lapic[ICRLO] & DELIVS)
80102f51:	90                   	nop
80102f52:	a1 dc 24 11 80       	mov    0x801124dc,%eax
80102f57:	05 00 03 00 00       	add    $0x300,%eax
80102f5c:	8b 00                	mov    (%eax),%eax
80102f5e:	25 00 10 00 00       	and    $0x1000,%eax
80102f63:	85 c0                	test   %eax,%eax
80102f65:	75 eb                	jne    80102f52 <lapicinit+0xf9>
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
80102f67:	6a 00                	push   $0x0
80102f69:	6a 20                	push   $0x20
80102f6b:	e8 c8 fe ff ff       	call   80102e38 <lapicw>
80102f70:	83 c4 08             	add    $0x8,%esp
}
80102f73:	c9                   	leave  
80102f74:	c3                   	ret    

80102f75 <cpunum>:

int
cpunum(void)
{
80102f75:	55                   	push   %ebp
80102f76:	89 e5                	mov    %esp,%ebp
80102f78:	83 ec 08             	sub    $0x8,%esp
  // Cannot call cpu when interrupts are enabled:
  // result not guaranteed to last long enough to be used!
  // Would prefer to panic but even printing is chancy here:
  // almost everything, including cprintf and panic, calls cpu,
  // often indirectly through acquire and release.
  if(readeflags()&FL_IF){
80102f7b:	e8 a8 fe ff ff       	call   80102e28 <readeflags>
80102f80:	25 00 02 00 00       	and    $0x200,%eax
80102f85:	85 c0                	test   %eax,%eax
80102f87:	74 26                	je     80102faf <cpunum+0x3a>
    static int n;
    if(n++ == 0)
80102f89:	a1 60 b6 10 80       	mov    0x8010b660,%eax
80102f8e:	8d 50 01             	lea    0x1(%eax),%edx
80102f91:	89 15 60 b6 10 80    	mov    %edx,0x8010b660
80102f97:	85 c0                	test   %eax,%eax
80102f99:	75 14                	jne    80102faf <cpunum+0x3a>
      cprintf("cpu called from %x with interrupts enabled\n",
80102f9b:	8b 45 04             	mov    0x4(%ebp),%eax
80102f9e:	83 ec 08             	sub    $0x8,%esp
80102fa1:	50                   	push   %eax
80102fa2:	68 70 89 10 80       	push   $0x80108970
80102fa7:	e8 13 d4 ff ff       	call   801003bf <cprintf>
80102fac:	83 c4 10             	add    $0x10,%esp
        __builtin_return_address(0));
  }

  if(lapic)
80102faf:	a1 dc 24 11 80       	mov    0x801124dc,%eax
80102fb4:	85 c0                	test   %eax,%eax
80102fb6:	74 0f                	je     80102fc7 <cpunum+0x52>
    return lapic[ID]>>24;
80102fb8:	a1 dc 24 11 80       	mov    0x801124dc,%eax
80102fbd:	83 c0 20             	add    $0x20,%eax
80102fc0:	8b 00                	mov    (%eax),%eax
80102fc2:	c1 e8 18             	shr    $0x18,%eax
80102fc5:	eb 05                	jmp    80102fcc <cpunum+0x57>
  return 0;
80102fc7:	b8 00 00 00 00       	mov    $0x0,%eax
}
80102fcc:	c9                   	leave  
80102fcd:	c3                   	ret    

80102fce <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
80102fce:	55                   	push   %ebp
80102fcf:	89 e5                	mov    %esp,%ebp
  if(lapic)
80102fd1:	a1 dc 24 11 80       	mov    0x801124dc,%eax
80102fd6:	85 c0                	test   %eax,%eax
80102fd8:	74 0c                	je     80102fe6 <lapiceoi+0x18>
    lapicw(EOI, 0);
80102fda:	6a 00                	push   $0x0
80102fdc:	6a 2c                	push   $0x2c
80102fde:	e8 55 fe ff ff       	call   80102e38 <lapicw>
80102fe3:	83 c4 08             	add    $0x8,%esp
}
80102fe6:	c9                   	leave  
80102fe7:	c3                   	ret    

80102fe8 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80102fe8:	55                   	push   %ebp
80102fe9:	89 e5                	mov    %esp,%ebp
}
80102feb:	5d                   	pop    %ebp
80102fec:	c3                   	ret    

80102fed <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102fed:	55                   	push   %ebp
80102fee:	89 e5                	mov    %esp,%ebp
80102ff0:	83 ec 14             	sub    $0x14,%esp
80102ff3:	8b 45 08             	mov    0x8(%ebp),%eax
80102ff6:	88 45 ec             	mov    %al,-0x14(%ebp)
  ushort *wrv;
  
  // "The BSP must initialize CMOS shutdown code to 0AH
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
80102ff9:	6a 0f                	push   $0xf
80102ffb:	6a 70                	push   $0x70
80102ffd:	e8 08 fe ff ff       	call   80102e0a <outb>
80103002:	83 c4 08             	add    $0x8,%esp
  outb(CMOS_PORT+1, 0x0A);
80103005:	6a 0a                	push   $0xa
80103007:	6a 71                	push   $0x71
80103009:	e8 fc fd ff ff       	call   80102e0a <outb>
8010300e:	83 c4 08             	add    $0x8,%esp
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
80103011:	c7 45 f8 67 04 00 80 	movl   $0x80000467,-0x8(%ebp)
  wrv[0] = 0;
80103018:	8b 45 f8             	mov    -0x8(%ebp),%eax
8010301b:	66 c7 00 00 00       	movw   $0x0,(%eax)
  wrv[1] = addr >> 4;
80103020:	8b 45 f8             	mov    -0x8(%ebp),%eax
80103023:	83 c0 02             	add    $0x2,%eax
80103026:	8b 55 0c             	mov    0xc(%ebp),%edx
80103029:	c1 ea 04             	shr    $0x4,%edx
8010302c:	66 89 10             	mov    %dx,(%eax)

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
8010302f:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
80103033:	c1 e0 18             	shl    $0x18,%eax
80103036:	50                   	push   %eax
80103037:	68 c4 00 00 00       	push   $0xc4
8010303c:	e8 f7 fd ff ff       	call   80102e38 <lapicw>
80103041:	83 c4 08             	add    $0x8,%esp
  lapicw(ICRLO, INIT | LEVEL | ASSERT);
80103044:	68 00 c5 00 00       	push   $0xc500
80103049:	68 c0 00 00 00       	push   $0xc0
8010304e:	e8 e5 fd ff ff       	call   80102e38 <lapicw>
80103053:	83 c4 08             	add    $0x8,%esp
  microdelay(200);
80103056:	68 c8 00 00 00       	push   $0xc8
8010305b:	e8 88 ff ff ff       	call   80102fe8 <microdelay>
80103060:	83 c4 04             	add    $0x4,%esp
  lapicw(ICRLO, INIT | LEVEL);
80103063:	68 00 85 00 00       	push   $0x8500
80103068:	68 c0 00 00 00       	push   $0xc0
8010306d:	e8 c6 fd ff ff       	call   80102e38 <lapicw>
80103072:	83 c4 08             	add    $0x8,%esp
  microdelay(100);    // should be 10ms, but too slow in Bochs!
80103075:	6a 64                	push   $0x64
80103077:	e8 6c ff ff ff       	call   80102fe8 <microdelay>
8010307c:	83 c4 04             	add    $0x4,%esp
  // Send startup IPI (twice!) to enter code.
  // Regular hardware is supposed to only accept a STARTUP
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
8010307f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
80103086:	eb 3d                	jmp    801030c5 <lapicstartap+0xd8>
    lapicw(ICRHI, apicid<<24);
80103088:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
8010308c:	c1 e0 18             	shl    $0x18,%eax
8010308f:	50                   	push   %eax
80103090:	68 c4 00 00 00       	push   $0xc4
80103095:	e8 9e fd ff ff       	call   80102e38 <lapicw>
8010309a:	83 c4 08             	add    $0x8,%esp
    lapicw(ICRLO, STARTUP | (addr>>12));
8010309d:	8b 45 0c             	mov    0xc(%ebp),%eax
801030a0:	c1 e8 0c             	shr    $0xc,%eax
801030a3:	80 cc 06             	or     $0x6,%ah
801030a6:	50                   	push   %eax
801030a7:	68 c0 00 00 00       	push   $0xc0
801030ac:	e8 87 fd ff ff       	call   80102e38 <lapicw>
801030b1:	83 c4 08             	add    $0x8,%esp
    microdelay(200);
801030b4:	68 c8 00 00 00       	push   $0xc8
801030b9:	e8 2a ff ff ff       	call   80102fe8 <microdelay>
801030be:	83 c4 04             	add    $0x4,%esp
  // Send startup IPI (twice!) to enter code.
  // Regular hardware is supposed to only accept a STARTUP
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
801030c1:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
801030c5:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
801030c9:	7e bd                	jle    80103088 <lapicstartap+0x9b>
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
    microdelay(200);
  }
}
801030cb:	c9                   	leave  
801030cc:	c3                   	ret    

801030cd <cmos_read>:
#define DAY     0x07
#define MONTH   0x08
#define YEAR    0x09

static uint cmos_read(uint reg)
{
801030cd:	55                   	push   %ebp
801030ce:	89 e5                	mov    %esp,%ebp
  outb(CMOS_PORT,  reg);
801030d0:	8b 45 08             	mov    0x8(%ebp),%eax
801030d3:	0f b6 c0             	movzbl %al,%eax
801030d6:	50                   	push   %eax
801030d7:	6a 70                	push   $0x70
801030d9:	e8 2c fd ff ff       	call   80102e0a <outb>
801030de:	83 c4 08             	add    $0x8,%esp
  microdelay(200);
801030e1:	68 c8 00 00 00       	push   $0xc8
801030e6:	e8 fd fe ff ff       	call   80102fe8 <microdelay>
801030eb:	83 c4 04             	add    $0x4,%esp

  return inb(CMOS_RETURN);
801030ee:	6a 71                	push   $0x71
801030f0:	e8 f8 fc ff ff       	call   80102ded <inb>
801030f5:	83 c4 04             	add    $0x4,%esp
801030f8:	0f b6 c0             	movzbl %al,%eax
}
801030fb:	c9                   	leave  
801030fc:	c3                   	ret    

801030fd <fill_rtcdate>:

static void fill_rtcdate(struct rtcdate *r)
{
801030fd:	55                   	push   %ebp
801030fe:	89 e5                	mov    %esp,%ebp
  r->second = cmos_read(SECS);
80103100:	6a 00                	push   $0x0
80103102:	e8 c6 ff ff ff       	call   801030cd <cmos_read>
80103107:	83 c4 04             	add    $0x4,%esp
8010310a:	89 c2                	mov    %eax,%edx
8010310c:	8b 45 08             	mov    0x8(%ebp),%eax
8010310f:	89 10                	mov    %edx,(%eax)
  r->minute = cmos_read(MINS);
80103111:	6a 02                	push   $0x2
80103113:	e8 b5 ff ff ff       	call   801030cd <cmos_read>
80103118:	83 c4 04             	add    $0x4,%esp
8010311b:	89 c2                	mov    %eax,%edx
8010311d:	8b 45 08             	mov    0x8(%ebp),%eax
80103120:	89 50 04             	mov    %edx,0x4(%eax)
  r->hour   = cmos_read(HOURS);
80103123:	6a 04                	push   $0x4
80103125:	e8 a3 ff ff ff       	call   801030cd <cmos_read>
8010312a:	83 c4 04             	add    $0x4,%esp
8010312d:	89 c2                	mov    %eax,%edx
8010312f:	8b 45 08             	mov    0x8(%ebp),%eax
80103132:	89 50 08             	mov    %edx,0x8(%eax)
  r->day    = cmos_read(DAY);
80103135:	6a 07                	push   $0x7
80103137:	e8 91 ff ff ff       	call   801030cd <cmos_read>
8010313c:	83 c4 04             	add    $0x4,%esp
8010313f:	89 c2                	mov    %eax,%edx
80103141:	8b 45 08             	mov    0x8(%ebp),%eax
80103144:	89 50 0c             	mov    %edx,0xc(%eax)
  r->month  = cmos_read(MONTH);
80103147:	6a 08                	push   $0x8
80103149:	e8 7f ff ff ff       	call   801030cd <cmos_read>
8010314e:	83 c4 04             	add    $0x4,%esp
80103151:	89 c2                	mov    %eax,%edx
80103153:	8b 45 08             	mov    0x8(%ebp),%eax
80103156:	89 50 10             	mov    %edx,0x10(%eax)
  r->year   = cmos_read(YEAR);
80103159:	6a 09                	push   $0x9
8010315b:	e8 6d ff ff ff       	call   801030cd <cmos_read>
80103160:	83 c4 04             	add    $0x4,%esp
80103163:	89 c2                	mov    %eax,%edx
80103165:	8b 45 08             	mov    0x8(%ebp),%eax
80103168:	89 50 14             	mov    %edx,0x14(%eax)
}
8010316b:	c9                   	leave  
8010316c:	c3                   	ret    

8010316d <cmostime>:

// qemu seems to use 24-hour GWT and the values are BCD encoded
void cmostime(struct rtcdate *r)
{
8010316d:	55                   	push   %ebp
8010316e:	89 e5                	mov    %esp,%ebp
80103170:	83 ec 48             	sub    $0x48,%esp
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);
80103173:	6a 0b                	push   $0xb
80103175:	e8 53 ff ff ff       	call   801030cd <cmos_read>
8010317a:	83 c4 04             	add    $0x4,%esp
8010317d:	89 45 f4             	mov    %eax,-0xc(%ebp)

  bcd = (sb & (1 << 2)) == 0;
80103180:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103183:	83 e0 04             	and    $0x4,%eax
80103186:	85 c0                	test   %eax,%eax
80103188:	0f 94 c0             	sete   %al
8010318b:	0f b6 c0             	movzbl %al,%eax
8010318e:	89 45 f0             	mov    %eax,-0x10(%ebp)

  // make sure CMOS doesn't modify time while we read it
  for (;;) {
    fill_rtcdate(&t1);
80103191:	8d 45 d8             	lea    -0x28(%ebp),%eax
80103194:	50                   	push   %eax
80103195:	e8 63 ff ff ff       	call   801030fd <fill_rtcdate>
8010319a:	83 c4 04             	add    $0x4,%esp
    if (cmos_read(CMOS_STATA) & CMOS_UIP)
8010319d:	6a 0a                	push   $0xa
8010319f:	e8 29 ff ff ff       	call   801030cd <cmos_read>
801031a4:	83 c4 04             	add    $0x4,%esp
801031a7:	25 80 00 00 00       	and    $0x80,%eax
801031ac:	85 c0                	test   %eax,%eax
801031ae:	74 02                	je     801031b2 <cmostime+0x45>
        continue;
801031b0:	eb 32                	jmp    801031e4 <cmostime+0x77>
    fill_rtcdate(&t2);
801031b2:	8d 45 c0             	lea    -0x40(%ebp),%eax
801031b5:	50                   	push   %eax
801031b6:	e8 42 ff ff ff       	call   801030fd <fill_rtcdate>
801031bb:	83 c4 04             	add    $0x4,%esp
    if (memcmp(&t1, &t2, sizeof(t1)) == 0)
801031be:	83 ec 04             	sub    $0x4,%esp
801031c1:	6a 18                	push   $0x18
801031c3:	8d 45 c0             	lea    -0x40(%ebp),%eax
801031c6:	50                   	push   %eax
801031c7:	8d 45 d8             	lea    -0x28(%ebp),%eax
801031ca:	50                   	push   %eax
801031cb:	e8 3a 23 00 00       	call   8010550a <memcmp>
801031d0:	83 c4 10             	add    $0x10,%esp
801031d3:	85 c0                	test   %eax,%eax
801031d5:	75 0d                	jne    801031e4 <cmostime+0x77>
      break;
801031d7:	90                   	nop
  }

  // convert
  if (bcd) {
801031d8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801031dc:	0f 84 b8 00 00 00    	je     8010329a <cmostime+0x12d>
801031e2:	eb 02                	jmp    801031e6 <cmostime+0x79>
    if (cmos_read(CMOS_STATA) & CMOS_UIP)
        continue;
    fill_rtcdate(&t2);
    if (memcmp(&t1, &t2, sizeof(t1)) == 0)
      break;
  }
801031e4:	eb ab                	jmp    80103191 <cmostime+0x24>

  // convert
  if (bcd) {
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
801031e6:	8b 45 d8             	mov    -0x28(%ebp),%eax
801031e9:	c1 e8 04             	shr    $0x4,%eax
801031ec:	89 c2                	mov    %eax,%edx
801031ee:	89 d0                	mov    %edx,%eax
801031f0:	c1 e0 02             	shl    $0x2,%eax
801031f3:	01 d0                	add    %edx,%eax
801031f5:	01 c0                	add    %eax,%eax
801031f7:	89 c2                	mov    %eax,%edx
801031f9:	8b 45 d8             	mov    -0x28(%ebp),%eax
801031fc:	83 e0 0f             	and    $0xf,%eax
801031ff:	01 d0                	add    %edx,%eax
80103201:	89 45 d8             	mov    %eax,-0x28(%ebp)
    CONV(minute);
80103204:	8b 45 dc             	mov    -0x24(%ebp),%eax
80103207:	c1 e8 04             	shr    $0x4,%eax
8010320a:	89 c2                	mov    %eax,%edx
8010320c:	89 d0                	mov    %edx,%eax
8010320e:	c1 e0 02             	shl    $0x2,%eax
80103211:	01 d0                	add    %edx,%eax
80103213:	01 c0                	add    %eax,%eax
80103215:	89 c2                	mov    %eax,%edx
80103217:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010321a:	83 e0 0f             	and    $0xf,%eax
8010321d:	01 d0                	add    %edx,%eax
8010321f:	89 45 dc             	mov    %eax,-0x24(%ebp)
    CONV(hour  );
80103222:	8b 45 e0             	mov    -0x20(%ebp),%eax
80103225:	c1 e8 04             	shr    $0x4,%eax
80103228:	89 c2                	mov    %eax,%edx
8010322a:	89 d0                	mov    %edx,%eax
8010322c:	c1 e0 02             	shl    $0x2,%eax
8010322f:	01 d0                	add    %edx,%eax
80103231:	01 c0                	add    %eax,%eax
80103233:	89 c2                	mov    %eax,%edx
80103235:	8b 45 e0             	mov    -0x20(%ebp),%eax
80103238:	83 e0 0f             	and    $0xf,%eax
8010323b:	01 d0                	add    %edx,%eax
8010323d:	89 45 e0             	mov    %eax,-0x20(%ebp)
    CONV(day   );
80103240:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103243:	c1 e8 04             	shr    $0x4,%eax
80103246:	89 c2                	mov    %eax,%edx
80103248:	89 d0                	mov    %edx,%eax
8010324a:	c1 e0 02             	shl    $0x2,%eax
8010324d:	01 d0                	add    %edx,%eax
8010324f:	01 c0                	add    %eax,%eax
80103251:	89 c2                	mov    %eax,%edx
80103253:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103256:	83 e0 0f             	and    $0xf,%eax
80103259:	01 d0                	add    %edx,%eax
8010325b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    CONV(month );
8010325e:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103261:	c1 e8 04             	shr    $0x4,%eax
80103264:	89 c2                	mov    %eax,%edx
80103266:	89 d0                	mov    %edx,%eax
80103268:	c1 e0 02             	shl    $0x2,%eax
8010326b:	01 d0                	add    %edx,%eax
8010326d:	01 c0                	add    %eax,%eax
8010326f:	89 c2                	mov    %eax,%edx
80103271:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103274:	83 e0 0f             	and    $0xf,%eax
80103277:	01 d0                	add    %edx,%eax
80103279:	89 45 e8             	mov    %eax,-0x18(%ebp)
    CONV(year  );
8010327c:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010327f:	c1 e8 04             	shr    $0x4,%eax
80103282:	89 c2                	mov    %eax,%edx
80103284:	89 d0                	mov    %edx,%eax
80103286:	c1 e0 02             	shl    $0x2,%eax
80103289:	01 d0                	add    %edx,%eax
8010328b:	01 c0                	add    %eax,%eax
8010328d:	89 c2                	mov    %eax,%edx
8010328f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103292:	83 e0 0f             	and    $0xf,%eax
80103295:	01 d0                	add    %edx,%eax
80103297:	89 45 ec             	mov    %eax,-0x14(%ebp)
#undef     CONV
  }

  *r = t1;
8010329a:	8b 45 08             	mov    0x8(%ebp),%eax
8010329d:	8b 55 d8             	mov    -0x28(%ebp),%edx
801032a0:	89 10                	mov    %edx,(%eax)
801032a2:	8b 55 dc             	mov    -0x24(%ebp),%edx
801032a5:	89 50 04             	mov    %edx,0x4(%eax)
801032a8:	8b 55 e0             	mov    -0x20(%ebp),%edx
801032ab:	89 50 08             	mov    %edx,0x8(%eax)
801032ae:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801032b1:	89 50 0c             	mov    %edx,0xc(%eax)
801032b4:	8b 55 e8             	mov    -0x18(%ebp),%edx
801032b7:	89 50 10             	mov    %edx,0x10(%eax)
801032ba:	8b 55 ec             	mov    -0x14(%ebp),%edx
801032bd:	89 50 14             	mov    %edx,0x14(%eax)
  r->year += 2000;
801032c0:	8b 45 08             	mov    0x8(%ebp),%eax
801032c3:	8b 40 14             	mov    0x14(%eax),%eax
801032c6:	8d 90 d0 07 00 00    	lea    0x7d0(%eax),%edx
801032cc:	8b 45 08             	mov    0x8(%ebp),%eax
801032cf:	89 50 14             	mov    %edx,0x14(%eax)
}
801032d2:	c9                   	leave  
801032d3:	c3                   	ret    

801032d4 <initlog>:
static void recover_from_log(void);
static void commit();

void
initlog(int dev)
{
801032d4:	55                   	push   %ebp
801032d5:	89 e5                	mov    %esp,%ebp
801032d7:	83 ec 28             	sub    $0x28,%esp
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
801032da:	83 ec 08             	sub    $0x8,%esp
801032dd:	68 9c 89 10 80       	push   $0x8010899c
801032e2:	68 00 25 11 80       	push   $0x80112500
801032e7:	e8 3a 1f 00 00       	call   80105226 <initlock>
801032ec:	83 c4 10             	add    $0x10,%esp
  readsb(dev, &sb);
801032ef:	83 ec 08             	sub    $0x8,%esp
801032f2:	8d 45 dc             	lea    -0x24(%ebp),%eax
801032f5:	50                   	push   %eax
801032f6:	ff 75 08             	pushl  0x8(%ebp)
801032f9:	e8 4c e0 ff ff       	call   8010134a <readsb>
801032fe:	83 c4 10             	add    $0x10,%esp
  log.start = sb.logstart;
80103301:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103304:	a3 34 25 11 80       	mov    %eax,0x80112534
  log.size = sb.nlog;
80103309:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010330c:	a3 38 25 11 80       	mov    %eax,0x80112538
  log.dev = dev;
80103311:	8b 45 08             	mov    0x8(%ebp),%eax
80103314:	a3 44 25 11 80       	mov    %eax,0x80112544
  recover_from_log();
80103319:	e8 ae 01 00 00       	call   801034cc <recover_from_log>
}
8010331e:	c9                   	leave  
8010331f:	c3                   	ret    

80103320 <install_trans>:

// Copy committed blocks from log to their home location
static void 
install_trans(void)
{
80103320:	55                   	push   %ebp
80103321:	89 e5                	mov    %esp,%ebp
80103323:	83 ec 18             	sub    $0x18,%esp
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80103326:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010332d:	e9 95 00 00 00       	jmp    801033c7 <install_trans+0xa7>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80103332:	8b 15 34 25 11 80    	mov    0x80112534,%edx
80103338:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010333b:	01 d0                	add    %edx,%eax
8010333d:	83 c0 01             	add    $0x1,%eax
80103340:	89 c2                	mov    %eax,%edx
80103342:	a1 44 25 11 80       	mov    0x80112544,%eax
80103347:	83 ec 08             	sub    $0x8,%esp
8010334a:	52                   	push   %edx
8010334b:	50                   	push   %eax
8010334c:	e8 63 ce ff ff       	call   801001b4 <bread>
80103351:	83 c4 10             	add    $0x10,%esp
80103354:	89 45 f0             	mov    %eax,-0x10(%ebp)
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80103357:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010335a:	83 c0 10             	add    $0x10,%eax
8010335d:	8b 04 85 0c 25 11 80 	mov    -0x7feedaf4(,%eax,4),%eax
80103364:	89 c2                	mov    %eax,%edx
80103366:	a1 44 25 11 80       	mov    0x80112544,%eax
8010336b:	83 ec 08             	sub    $0x8,%esp
8010336e:	52                   	push   %edx
8010336f:	50                   	push   %eax
80103370:	e8 3f ce ff ff       	call   801001b4 <bread>
80103375:	83 c4 10             	add    $0x10,%esp
80103378:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
8010337b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010337e:	8d 50 18             	lea    0x18(%eax),%edx
80103381:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103384:	83 c0 18             	add    $0x18,%eax
80103387:	83 ec 04             	sub    $0x4,%esp
8010338a:	68 00 02 00 00       	push   $0x200
8010338f:	52                   	push   %edx
80103390:	50                   	push   %eax
80103391:	e8 cc 21 00 00       	call   80105562 <memmove>
80103396:	83 c4 10             	add    $0x10,%esp
    bwrite(dbuf);  // write dst to disk
80103399:	83 ec 0c             	sub    $0xc,%esp
8010339c:	ff 75 ec             	pushl  -0x14(%ebp)
8010339f:	e8 49 ce ff ff       	call   801001ed <bwrite>
801033a4:	83 c4 10             	add    $0x10,%esp
    brelse(lbuf); 
801033a7:	83 ec 0c             	sub    $0xc,%esp
801033aa:	ff 75 f0             	pushl  -0x10(%ebp)
801033ad:	e8 79 ce ff ff       	call   8010022b <brelse>
801033b2:	83 c4 10             	add    $0x10,%esp
    brelse(dbuf);
801033b5:	83 ec 0c             	sub    $0xc,%esp
801033b8:	ff 75 ec             	pushl  -0x14(%ebp)
801033bb:	e8 6b ce ff ff       	call   8010022b <brelse>
801033c0:	83 c4 10             	add    $0x10,%esp
static void 
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
801033c3:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801033c7:	a1 48 25 11 80       	mov    0x80112548,%eax
801033cc:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801033cf:	0f 8f 5d ff ff ff    	jg     80103332 <install_trans+0x12>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    bwrite(dbuf);  // write dst to disk
    brelse(lbuf); 
    brelse(dbuf);
  }
}
801033d5:	c9                   	leave  
801033d6:	c3                   	ret    

801033d7 <read_head>:

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
801033d7:	55                   	push   %ebp
801033d8:	89 e5                	mov    %esp,%ebp
801033da:	83 ec 18             	sub    $0x18,%esp
  struct buf *buf = bread(log.dev, log.start);
801033dd:	a1 34 25 11 80       	mov    0x80112534,%eax
801033e2:	89 c2                	mov    %eax,%edx
801033e4:	a1 44 25 11 80       	mov    0x80112544,%eax
801033e9:	83 ec 08             	sub    $0x8,%esp
801033ec:	52                   	push   %edx
801033ed:	50                   	push   %eax
801033ee:	e8 c1 cd ff ff       	call   801001b4 <bread>
801033f3:	83 c4 10             	add    $0x10,%esp
801033f6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  struct logheader *lh = (struct logheader *) (buf->data);
801033f9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801033fc:	83 c0 18             	add    $0x18,%eax
801033ff:	89 45 ec             	mov    %eax,-0x14(%ebp)
  int i;
  log.lh.n = lh->n;
80103402:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103405:	8b 00                	mov    (%eax),%eax
80103407:	a3 48 25 11 80       	mov    %eax,0x80112548
  for (i = 0; i < log.lh.n; i++) {
8010340c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103413:	eb 1b                	jmp    80103430 <read_head+0x59>
    log.lh.block[i] = lh->block[i];
80103415:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103418:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010341b:	8b 44 90 04          	mov    0x4(%eax,%edx,4),%eax
8010341f:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103422:	83 c2 10             	add    $0x10,%edx
80103425:	89 04 95 0c 25 11 80 	mov    %eax,-0x7feedaf4(,%edx,4)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
  for (i = 0; i < log.lh.n; i++) {
8010342c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80103430:	a1 48 25 11 80       	mov    0x80112548,%eax
80103435:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80103438:	7f db                	jg     80103415 <read_head+0x3e>
    log.lh.block[i] = lh->block[i];
  }
  brelse(buf);
8010343a:	83 ec 0c             	sub    $0xc,%esp
8010343d:	ff 75 f0             	pushl  -0x10(%ebp)
80103440:	e8 e6 cd ff ff       	call   8010022b <brelse>
80103445:	83 c4 10             	add    $0x10,%esp
}
80103448:	c9                   	leave  
80103449:	c3                   	ret    

8010344a <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
8010344a:	55                   	push   %ebp
8010344b:	89 e5                	mov    %esp,%ebp
8010344d:	83 ec 18             	sub    $0x18,%esp
  struct buf *buf = bread(log.dev, log.start);
80103450:	a1 34 25 11 80       	mov    0x80112534,%eax
80103455:	89 c2                	mov    %eax,%edx
80103457:	a1 44 25 11 80       	mov    0x80112544,%eax
8010345c:	83 ec 08             	sub    $0x8,%esp
8010345f:	52                   	push   %edx
80103460:	50                   	push   %eax
80103461:	e8 4e cd ff ff       	call   801001b4 <bread>
80103466:	83 c4 10             	add    $0x10,%esp
80103469:	89 45 f0             	mov    %eax,-0x10(%ebp)
  struct logheader *hb = (struct logheader *) (buf->data);
8010346c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010346f:	83 c0 18             	add    $0x18,%eax
80103472:	89 45 ec             	mov    %eax,-0x14(%ebp)
  int i;
  hb->n = log.lh.n;
80103475:	8b 15 48 25 11 80    	mov    0x80112548,%edx
8010347b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010347e:	89 10                	mov    %edx,(%eax)
  for (i = 0; i < log.lh.n; i++) {
80103480:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103487:	eb 1b                	jmp    801034a4 <write_head+0x5a>
    hb->block[i] = log.lh.block[i];
80103489:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010348c:	83 c0 10             	add    $0x10,%eax
8010348f:	8b 0c 85 0c 25 11 80 	mov    -0x7feedaf4(,%eax,4),%ecx
80103496:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103499:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010349c:	89 4c 90 04          	mov    %ecx,0x4(%eax,%edx,4)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
801034a0:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801034a4:	a1 48 25 11 80       	mov    0x80112548,%eax
801034a9:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801034ac:	7f db                	jg     80103489 <write_head+0x3f>
    hb->block[i] = log.lh.block[i];
  }
  bwrite(buf);
801034ae:	83 ec 0c             	sub    $0xc,%esp
801034b1:	ff 75 f0             	pushl  -0x10(%ebp)
801034b4:	e8 34 cd ff ff       	call   801001ed <bwrite>
801034b9:	83 c4 10             	add    $0x10,%esp
  brelse(buf);
801034bc:	83 ec 0c             	sub    $0xc,%esp
801034bf:	ff 75 f0             	pushl  -0x10(%ebp)
801034c2:	e8 64 cd ff ff       	call   8010022b <brelse>
801034c7:	83 c4 10             	add    $0x10,%esp
}
801034ca:	c9                   	leave  
801034cb:	c3                   	ret    

801034cc <recover_from_log>:

static void
recover_from_log(void)
{
801034cc:	55                   	push   %ebp
801034cd:	89 e5                	mov    %esp,%ebp
801034cf:	83 ec 08             	sub    $0x8,%esp
  read_head();      
801034d2:	e8 00 ff ff ff       	call   801033d7 <read_head>
  install_trans(); // if committed, copy from log to disk
801034d7:	e8 44 fe ff ff       	call   80103320 <install_trans>
  log.lh.n = 0;
801034dc:	c7 05 48 25 11 80 00 	movl   $0x0,0x80112548
801034e3:	00 00 00 
  write_head(); // clear the log
801034e6:	e8 5f ff ff ff       	call   8010344a <write_head>
}
801034eb:	c9                   	leave  
801034ec:	c3                   	ret    

801034ed <begin_op>:

// called at the start of each FS system call.
void
begin_op(void)
{
801034ed:	55                   	push   %ebp
801034ee:	89 e5                	mov    %esp,%ebp
801034f0:	83 ec 08             	sub    $0x8,%esp
  acquire(&log.lock);
801034f3:	83 ec 0c             	sub    $0xc,%esp
801034f6:	68 00 25 11 80       	push   $0x80112500
801034fb:	e8 47 1d 00 00       	call   80105247 <acquire>
80103500:	83 c4 10             	add    $0x10,%esp
  while(1){
    if(log.committing){
80103503:	a1 40 25 11 80       	mov    0x80112540,%eax
80103508:	85 c0                	test   %eax,%eax
8010350a:	74 17                	je     80103523 <begin_op+0x36>
      sleep(&log, &log.lock);
8010350c:	83 ec 08             	sub    $0x8,%esp
8010350f:	68 00 25 11 80       	push   $0x80112500
80103514:	68 00 25 11 80       	push   $0x80112500
80103519:	e8 03 1a 00 00       	call   80104f21 <sleep>
8010351e:	83 c4 10             	add    $0x10,%esp
80103521:	eb 54                	jmp    80103577 <begin_op+0x8a>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80103523:	8b 0d 48 25 11 80    	mov    0x80112548,%ecx
80103529:	a1 3c 25 11 80       	mov    0x8011253c,%eax
8010352e:	8d 50 01             	lea    0x1(%eax),%edx
80103531:	89 d0                	mov    %edx,%eax
80103533:	c1 e0 02             	shl    $0x2,%eax
80103536:	01 d0                	add    %edx,%eax
80103538:	01 c0                	add    %eax,%eax
8010353a:	01 c8                	add    %ecx,%eax
8010353c:	83 f8 1e             	cmp    $0x1e,%eax
8010353f:	7e 17                	jle    80103558 <begin_op+0x6b>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
80103541:	83 ec 08             	sub    $0x8,%esp
80103544:	68 00 25 11 80       	push   $0x80112500
80103549:	68 00 25 11 80       	push   $0x80112500
8010354e:	e8 ce 19 00 00       	call   80104f21 <sleep>
80103553:	83 c4 10             	add    $0x10,%esp
80103556:	eb 1f                	jmp    80103577 <begin_op+0x8a>
    } else {
      log.outstanding += 1;
80103558:	a1 3c 25 11 80       	mov    0x8011253c,%eax
8010355d:	83 c0 01             	add    $0x1,%eax
80103560:	a3 3c 25 11 80       	mov    %eax,0x8011253c
      release(&log.lock);
80103565:	83 ec 0c             	sub    $0xc,%esp
80103568:	68 00 25 11 80       	push   $0x80112500
8010356d:	e8 3b 1d 00 00       	call   801052ad <release>
80103572:	83 c4 10             	add    $0x10,%esp
      break;
80103575:	eb 02                	jmp    80103579 <begin_op+0x8c>
    }
  }
80103577:	eb 8a                	jmp    80103503 <begin_op+0x16>
}
80103579:	c9                   	leave  
8010357a:	c3                   	ret    

8010357b <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
8010357b:	55                   	push   %ebp
8010357c:	89 e5                	mov    %esp,%ebp
8010357e:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;
80103581:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

  acquire(&log.lock);
80103588:	83 ec 0c             	sub    $0xc,%esp
8010358b:	68 00 25 11 80       	push   $0x80112500
80103590:	e8 b2 1c 00 00       	call   80105247 <acquire>
80103595:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80103598:	a1 3c 25 11 80       	mov    0x8011253c,%eax
8010359d:	83 e8 01             	sub    $0x1,%eax
801035a0:	a3 3c 25 11 80       	mov    %eax,0x8011253c
  if(log.committing)
801035a5:	a1 40 25 11 80       	mov    0x80112540,%eax
801035aa:	85 c0                	test   %eax,%eax
801035ac:	74 0d                	je     801035bb <end_op+0x40>
    panic("log.committing");
801035ae:	83 ec 0c             	sub    $0xc,%esp
801035b1:	68 a0 89 10 80       	push   $0x801089a0
801035b6:	e8 a1 cf ff ff       	call   8010055c <panic>
  if(log.outstanding == 0){
801035bb:	a1 3c 25 11 80       	mov    0x8011253c,%eax
801035c0:	85 c0                	test   %eax,%eax
801035c2:	75 13                	jne    801035d7 <end_op+0x5c>
    do_commit = 1;
801035c4:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
    log.committing = 1;
801035cb:	c7 05 40 25 11 80 01 	movl   $0x1,0x80112540
801035d2:	00 00 00 
801035d5:	eb 10                	jmp    801035e7 <end_op+0x6c>
  } else {
    // begin_op() may be waiting for log space.
    wakeup(&log);
801035d7:	83 ec 0c             	sub    $0xc,%esp
801035da:	68 00 25 11 80       	push   $0x80112500
801035df:	e8 49 1a 00 00       	call   8010502d <wakeup>
801035e4:	83 c4 10             	add    $0x10,%esp
  }
  release(&log.lock);
801035e7:	83 ec 0c             	sub    $0xc,%esp
801035ea:	68 00 25 11 80       	push   $0x80112500
801035ef:	e8 b9 1c 00 00       	call   801052ad <release>
801035f4:	83 c4 10             	add    $0x10,%esp

  if(do_commit){
801035f7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801035fb:	74 3f                	je     8010363c <end_op+0xc1>
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
801035fd:	e8 f3 00 00 00       	call   801036f5 <commit>
    acquire(&log.lock);
80103602:	83 ec 0c             	sub    $0xc,%esp
80103605:	68 00 25 11 80       	push   $0x80112500
8010360a:	e8 38 1c 00 00       	call   80105247 <acquire>
8010360f:	83 c4 10             	add    $0x10,%esp
    log.committing = 0;
80103612:	c7 05 40 25 11 80 00 	movl   $0x0,0x80112540
80103619:	00 00 00 
    wakeup(&log);
8010361c:	83 ec 0c             	sub    $0xc,%esp
8010361f:	68 00 25 11 80       	push   $0x80112500
80103624:	e8 04 1a 00 00       	call   8010502d <wakeup>
80103629:	83 c4 10             	add    $0x10,%esp
    release(&log.lock);
8010362c:	83 ec 0c             	sub    $0xc,%esp
8010362f:	68 00 25 11 80       	push   $0x80112500
80103634:	e8 74 1c 00 00       	call   801052ad <release>
80103639:	83 c4 10             	add    $0x10,%esp
  }
}
8010363c:	c9                   	leave  
8010363d:	c3                   	ret    

8010363e <write_log>:

// Copy modified blocks from cache to log.
static void 
write_log(void)
{
8010363e:	55                   	push   %ebp
8010363f:	89 e5                	mov    %esp,%ebp
80103641:	83 ec 18             	sub    $0x18,%esp
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80103644:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010364b:	e9 95 00 00 00       	jmp    801036e5 <write_log+0xa7>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80103650:	8b 15 34 25 11 80    	mov    0x80112534,%edx
80103656:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103659:	01 d0                	add    %edx,%eax
8010365b:	83 c0 01             	add    $0x1,%eax
8010365e:	89 c2                	mov    %eax,%edx
80103660:	a1 44 25 11 80       	mov    0x80112544,%eax
80103665:	83 ec 08             	sub    $0x8,%esp
80103668:	52                   	push   %edx
80103669:	50                   	push   %eax
8010366a:	e8 45 cb ff ff       	call   801001b4 <bread>
8010366f:	83 c4 10             	add    $0x10,%esp
80103672:	89 45 f0             	mov    %eax,-0x10(%ebp)
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80103675:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103678:	83 c0 10             	add    $0x10,%eax
8010367b:	8b 04 85 0c 25 11 80 	mov    -0x7feedaf4(,%eax,4),%eax
80103682:	89 c2                	mov    %eax,%edx
80103684:	a1 44 25 11 80       	mov    0x80112544,%eax
80103689:	83 ec 08             	sub    $0x8,%esp
8010368c:	52                   	push   %edx
8010368d:	50                   	push   %eax
8010368e:	e8 21 cb ff ff       	call   801001b4 <bread>
80103693:	83 c4 10             	add    $0x10,%esp
80103696:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(to->data, from->data, BSIZE);
80103699:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010369c:	8d 50 18             	lea    0x18(%eax),%edx
8010369f:	8b 45 f0             	mov    -0x10(%ebp),%eax
801036a2:	83 c0 18             	add    $0x18,%eax
801036a5:	83 ec 04             	sub    $0x4,%esp
801036a8:	68 00 02 00 00       	push   $0x200
801036ad:	52                   	push   %edx
801036ae:	50                   	push   %eax
801036af:	e8 ae 1e 00 00       	call   80105562 <memmove>
801036b4:	83 c4 10             	add    $0x10,%esp
    bwrite(to);  // write the log
801036b7:	83 ec 0c             	sub    $0xc,%esp
801036ba:	ff 75 f0             	pushl  -0x10(%ebp)
801036bd:	e8 2b cb ff ff       	call   801001ed <bwrite>
801036c2:	83 c4 10             	add    $0x10,%esp
    brelse(from); 
801036c5:	83 ec 0c             	sub    $0xc,%esp
801036c8:	ff 75 ec             	pushl  -0x14(%ebp)
801036cb:	e8 5b cb ff ff       	call   8010022b <brelse>
801036d0:	83 c4 10             	add    $0x10,%esp
    brelse(to);
801036d3:	83 ec 0c             	sub    $0xc,%esp
801036d6:	ff 75 f0             	pushl  -0x10(%ebp)
801036d9:	e8 4d cb ff ff       	call   8010022b <brelse>
801036de:	83 c4 10             	add    $0x10,%esp
static void 
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
801036e1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801036e5:	a1 48 25 11 80       	mov    0x80112548,%eax
801036ea:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801036ed:	0f 8f 5d ff ff ff    	jg     80103650 <write_log+0x12>
    memmove(to->data, from->data, BSIZE);
    bwrite(to);  // write the log
    brelse(from); 
    brelse(to);
  }
}
801036f3:	c9                   	leave  
801036f4:	c3                   	ret    

801036f5 <commit>:

static void
commit()
{
801036f5:	55                   	push   %ebp
801036f6:	89 e5                	mov    %esp,%ebp
801036f8:	83 ec 08             	sub    $0x8,%esp
  if (log.lh.n > 0) {
801036fb:	a1 48 25 11 80       	mov    0x80112548,%eax
80103700:	85 c0                	test   %eax,%eax
80103702:	7e 1e                	jle    80103722 <commit+0x2d>
    write_log();     // Write modified blocks from cache to log
80103704:	e8 35 ff ff ff       	call   8010363e <write_log>
    write_head();    // Write header to disk -- the real commit
80103709:	e8 3c fd ff ff       	call   8010344a <write_head>
    install_trans(); // Now install writes to home locations
8010370e:	e8 0d fc ff ff       	call   80103320 <install_trans>
    log.lh.n = 0; 
80103713:	c7 05 48 25 11 80 00 	movl   $0x0,0x80112548
8010371a:	00 00 00 
    write_head();    // Erase the transaction from the log
8010371d:	e8 28 fd ff ff       	call   8010344a <write_head>
  }
}
80103722:	c9                   	leave  
80103723:	c3                   	ret    

80103724 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80103724:	55                   	push   %ebp
80103725:	89 e5                	mov    %esp,%ebp
80103727:	83 ec 18             	sub    $0x18,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
8010372a:	a1 48 25 11 80       	mov    0x80112548,%eax
8010372f:	83 f8 1d             	cmp    $0x1d,%eax
80103732:	7f 12                	jg     80103746 <log_write+0x22>
80103734:	a1 48 25 11 80       	mov    0x80112548,%eax
80103739:	8b 15 38 25 11 80    	mov    0x80112538,%edx
8010373f:	83 ea 01             	sub    $0x1,%edx
80103742:	39 d0                	cmp    %edx,%eax
80103744:	7c 0d                	jl     80103753 <log_write+0x2f>
    panic("too big a transaction");
80103746:	83 ec 0c             	sub    $0xc,%esp
80103749:	68 af 89 10 80       	push   $0x801089af
8010374e:	e8 09 ce ff ff       	call   8010055c <panic>
  if (log.outstanding < 1)
80103753:	a1 3c 25 11 80       	mov    0x8011253c,%eax
80103758:	85 c0                	test   %eax,%eax
8010375a:	7f 0d                	jg     80103769 <log_write+0x45>
    panic("log_write outside of trans");
8010375c:	83 ec 0c             	sub    $0xc,%esp
8010375f:	68 c5 89 10 80       	push   $0x801089c5
80103764:	e8 f3 cd ff ff       	call   8010055c <panic>

  acquire(&log.lock);
80103769:	83 ec 0c             	sub    $0xc,%esp
8010376c:	68 00 25 11 80       	push   $0x80112500
80103771:	e8 d1 1a 00 00       	call   80105247 <acquire>
80103776:	83 c4 10             	add    $0x10,%esp
  for (i = 0; i < log.lh.n; i++) {
80103779:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103780:	eb 1f                	jmp    801037a1 <log_write+0x7d>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103782:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103785:	83 c0 10             	add    $0x10,%eax
80103788:	8b 04 85 0c 25 11 80 	mov    -0x7feedaf4(,%eax,4),%eax
8010378f:	89 c2                	mov    %eax,%edx
80103791:	8b 45 08             	mov    0x8(%ebp),%eax
80103794:	8b 40 08             	mov    0x8(%eax),%eax
80103797:	39 c2                	cmp    %eax,%edx
80103799:	75 02                	jne    8010379d <log_write+0x79>
      break;
8010379b:	eb 0e                	jmp    801037ab <log_write+0x87>
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
8010379d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801037a1:	a1 48 25 11 80       	mov    0x80112548,%eax
801037a6:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801037a9:	7f d7                	jg     80103782 <log_write+0x5e>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
801037ab:	8b 45 08             	mov    0x8(%ebp),%eax
801037ae:	8b 40 08             	mov    0x8(%eax),%eax
801037b1:	89 c2                	mov    %eax,%edx
801037b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801037b6:	83 c0 10             	add    $0x10,%eax
801037b9:	89 14 85 0c 25 11 80 	mov    %edx,-0x7feedaf4(,%eax,4)
  if (i == log.lh.n)
801037c0:	a1 48 25 11 80       	mov    0x80112548,%eax
801037c5:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801037c8:	75 0d                	jne    801037d7 <log_write+0xb3>
    log.lh.n++;
801037ca:	a1 48 25 11 80       	mov    0x80112548,%eax
801037cf:	83 c0 01             	add    $0x1,%eax
801037d2:	a3 48 25 11 80       	mov    %eax,0x80112548
  b->flags |= B_DIRTY; // prevent eviction
801037d7:	8b 45 08             	mov    0x8(%ebp),%eax
801037da:	8b 00                	mov    (%eax),%eax
801037dc:	83 c8 04             	or     $0x4,%eax
801037df:	89 c2                	mov    %eax,%edx
801037e1:	8b 45 08             	mov    0x8(%ebp),%eax
801037e4:	89 10                	mov    %edx,(%eax)
  release(&log.lock);
801037e6:	83 ec 0c             	sub    $0xc,%esp
801037e9:	68 00 25 11 80       	push   $0x80112500
801037ee:	e8 ba 1a 00 00       	call   801052ad <release>
801037f3:	83 c4 10             	add    $0x10,%esp
}
801037f6:	c9                   	leave  
801037f7:	c3                   	ret    

801037f8 <v2p>:
801037f8:	55                   	push   %ebp
801037f9:	89 e5                	mov    %esp,%ebp
801037fb:	8b 45 08             	mov    0x8(%ebp),%eax
801037fe:	05 00 00 00 80       	add    $0x80000000,%eax
80103803:	5d                   	pop    %ebp
80103804:	c3                   	ret    

80103805 <p2v>:
static inline void *p2v(uint a) { return (void *) ((a) + KERNBASE); }
80103805:	55                   	push   %ebp
80103806:	89 e5                	mov    %esp,%ebp
80103808:	8b 45 08             	mov    0x8(%ebp),%eax
8010380b:	05 00 00 00 80       	add    $0x80000000,%eax
80103810:	5d                   	pop    %ebp
80103811:	c3                   	ret    

80103812 <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
80103812:	55                   	push   %ebp
80103813:	89 e5                	mov    %esp,%ebp
80103815:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80103818:	8b 55 08             	mov    0x8(%ebp),%edx
8010381b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010381e:	8b 4d 08             	mov    0x8(%ebp),%ecx
80103821:	f0 87 02             	lock xchg %eax,(%edx)
80103824:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
80103827:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
8010382a:	c9                   	leave  
8010382b:	c3                   	ret    

8010382c <main>:
// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
8010382c:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80103830:	83 e4 f0             	and    $0xfffffff0,%esp
80103833:	ff 71 fc             	pushl  -0x4(%ecx)
80103836:	55                   	push   %ebp
80103837:	89 e5                	mov    %esp,%ebp
80103839:	51                   	push   %ecx
8010383a:	83 ec 04             	sub    $0x4,%esp
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
8010383d:	83 ec 08             	sub    $0x8,%esp
80103840:	68 00 00 40 80       	push   $0x80400000
80103845:	68 1c 55 11 80       	push   $0x8011551c
8010384a:	e8 92 f2 ff ff       	call   80102ae1 <kinit1>
8010384f:	83 c4 10             	add    $0x10,%esp
  kvmalloc();      // kernel page table
80103852:	e8 6b 47 00 00       	call   80107fc2 <kvmalloc>
  mpinit();        // collect info about this machine
80103857:	e8 40 04 00 00       	call   80103c9c <mpinit>
  lapicinit();
8010385c:	e8 f8 f5 ff ff       	call   80102e59 <lapicinit>
  seginit();       // set up segments
80103861:	e8 04 41 00 00       	call   8010796a <seginit>
  cprintf("\ncpu%d: starting xv6\n\n", cpu->id);
80103866:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010386c:	0f b6 00             	movzbl (%eax),%eax
8010386f:	0f b6 c0             	movzbl %al,%eax
80103872:	83 ec 08             	sub    $0x8,%esp
80103875:	50                   	push   %eax
80103876:	68 e0 89 10 80       	push   $0x801089e0
8010387b:	e8 3f cb ff ff       	call   801003bf <cprintf>
80103880:	83 c4 10             	add    $0x10,%esp
  picinit();       // interrupt controller
80103883:	e8 65 06 00 00       	call   80103eed <picinit>
  ioapicinit();    // another interrupt controller
80103888:	e8 4c f1 ff ff       	call   801029d9 <ioapicinit>
  consoleinit();   // I/O devices & their interrupts
8010388d:	e8 51 d2 ff ff       	call   80100ae3 <consoleinit>
  uartinit();      // serial port
80103892:	e8 36 34 00 00       	call   80106ccd <uartinit>
  pinit();         // process table
80103897:	e8 ea 0c 00 00       	call   80104586 <pinit>
  tvinit();        // trap vectors
8010389c:	e8 23 30 00 00       	call   801068c4 <tvinit>
  binit();         // buffer cache
801038a1:	e8 8e c7 ff ff       	call   80100034 <binit>
  fileinit();      // file table
801038a6:	e8 93 d6 ff ff       	call   80100f3e <fileinit>
  ideinit();       // disk
801038ab:	e8 35 ed ff ff       	call   801025e5 <ideinit>
  if(!ismp)
801038b0:	a1 04 26 11 80       	mov    0x80112604,%eax
801038b5:	85 c0                	test   %eax,%eax
801038b7:	75 05                	jne    801038be <main+0x92>
    timerinit();   // uniprocessor timer
801038b9:	e8 65 2f 00 00       	call   80106823 <timerinit>
  startothers();   // start other processors
801038be:	e8 7f 00 00 00       	call   80103942 <startothers>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
801038c3:	83 ec 08             	sub    $0x8,%esp
801038c6:	68 00 00 00 8e       	push   $0x8e000000
801038cb:	68 00 00 40 80       	push   $0x80400000
801038d0:	e8 44 f2 ff ff       	call   80102b19 <kinit2>
801038d5:	83 c4 10             	add    $0x10,%esp
  userinit();      // first user process
801038d8:	e8 ea 0d 00 00       	call   801046c7 <userinit>
  // Finish setting up this processor in mpmain.
  mpmain();
801038dd:	e8 1a 00 00 00       	call   801038fc <mpmain>

801038e2 <mpenter>:
}

// Other CPUs jump here from entryother.S.
static void
mpenter(void)
{
801038e2:	55                   	push   %ebp
801038e3:	89 e5                	mov    %esp,%ebp
801038e5:	83 ec 08             	sub    $0x8,%esp
  switchkvm(); 
801038e8:	e8 ec 46 00 00       	call   80107fd9 <switchkvm>
  seginit();
801038ed:	e8 78 40 00 00       	call   8010796a <seginit>
  lapicinit();
801038f2:	e8 62 f5 ff ff       	call   80102e59 <lapicinit>
  mpmain();
801038f7:	e8 00 00 00 00       	call   801038fc <mpmain>

801038fc <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
801038fc:	55                   	push   %ebp
801038fd:	89 e5                	mov    %esp,%ebp
801038ff:	83 ec 08             	sub    $0x8,%esp
  cprintf("cpu%d: starting\n", cpu->id);
80103902:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80103908:	0f b6 00             	movzbl (%eax),%eax
8010390b:	0f b6 c0             	movzbl %al,%eax
8010390e:	83 ec 08             	sub    $0x8,%esp
80103911:	50                   	push   %eax
80103912:	68 f7 89 10 80       	push   $0x801089f7
80103917:	e8 a3 ca ff ff       	call   801003bf <cprintf>
8010391c:	83 c4 10             	add    $0x10,%esp
  idtinit();       // load idt register
8010391f:	e8 15 31 00 00       	call   80106a39 <idtinit>
  xchg(&cpu->started, 1); // tell startothers() we're up
80103924:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010392a:	05 a8 00 00 00       	add    $0xa8,%eax
8010392f:	83 ec 08             	sub    $0x8,%esp
80103932:	6a 01                	push   $0x1
80103934:	50                   	push   %eax
80103935:	e8 d8 fe ff ff       	call   80103812 <xchg>
8010393a:	83 c4 10             	add    $0x10,%esp
  scheduler();     // start running processes
8010393d:	e8 b2 13 00 00       	call   80104cf4 <scheduler>

80103942 <startothers>:
pde_t entrypgdir[];  // For entry.S

// Start the non-boot (AP) processors.
static void
startothers(void)
{
80103942:	55                   	push   %ebp
80103943:	89 e5                	mov    %esp,%ebp
80103945:	53                   	push   %ebx
80103946:	83 ec 14             	sub    $0x14,%esp
  char *stack;

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = p2v(0x7000);
80103949:	68 00 70 00 00       	push   $0x7000
8010394e:	e8 b2 fe ff ff       	call   80103805 <p2v>
80103953:	83 c4 04             	add    $0x4,%esp
80103956:	89 45 f0             	mov    %eax,-0x10(%ebp)
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80103959:	b8 8a 00 00 00       	mov    $0x8a,%eax
8010395e:	83 ec 04             	sub    $0x4,%esp
80103961:	50                   	push   %eax
80103962:	68 2c b5 10 80       	push   $0x8010b52c
80103967:	ff 75 f0             	pushl  -0x10(%ebp)
8010396a:	e8 f3 1b 00 00       	call   80105562 <memmove>
8010396f:	83 c4 10             	add    $0x10,%esp

  for(c = cpus; c < cpus+ncpu; c++){
80103972:	c7 45 f4 40 26 11 80 	movl   $0x80112640,-0xc(%ebp)
80103979:	e9 8f 00 00 00       	jmp    80103a0d <startothers+0xcb>
    if(c == cpus+cpunum())  // We've started already.
8010397e:	e8 f2 f5 ff ff       	call   80102f75 <cpunum>
80103983:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80103989:	05 40 26 11 80       	add    $0x80112640,%eax
8010398e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80103991:	75 02                	jne    80103995 <startothers+0x53>
      continue;
80103993:	eb 71                	jmp    80103a06 <startothers+0xc4>

    // Tell entryother.S what stack to use, where to enter, and what 
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103995:	e8 7a f2 ff ff       	call   80102c14 <kalloc>
8010399a:	89 45 ec             	mov    %eax,-0x14(%ebp)
    *(void**)(code-4) = stack + KSTACKSIZE;
8010399d:	8b 45 f0             	mov    -0x10(%ebp),%eax
801039a0:	83 e8 04             	sub    $0x4,%eax
801039a3:	8b 55 ec             	mov    -0x14(%ebp),%edx
801039a6:	81 c2 00 10 00 00    	add    $0x1000,%edx
801039ac:	89 10                	mov    %edx,(%eax)
    *(void**)(code-8) = mpenter;
801039ae:	8b 45 f0             	mov    -0x10(%ebp),%eax
801039b1:	83 e8 08             	sub    $0x8,%eax
801039b4:	c7 00 e2 38 10 80    	movl   $0x801038e2,(%eax)
    *(int**)(code-12) = (void *) v2p(entrypgdir);
801039ba:	8b 45 f0             	mov    -0x10(%ebp),%eax
801039bd:	8d 58 f4             	lea    -0xc(%eax),%ebx
801039c0:	83 ec 0c             	sub    $0xc,%esp
801039c3:	68 00 a0 10 80       	push   $0x8010a000
801039c8:	e8 2b fe ff ff       	call   801037f8 <v2p>
801039cd:	83 c4 10             	add    $0x10,%esp
801039d0:	89 03                	mov    %eax,(%ebx)

    lapicstartap(c->id, v2p(code));
801039d2:	83 ec 0c             	sub    $0xc,%esp
801039d5:	ff 75 f0             	pushl  -0x10(%ebp)
801039d8:	e8 1b fe ff ff       	call   801037f8 <v2p>
801039dd:	83 c4 10             	add    $0x10,%esp
801039e0:	89 c2                	mov    %eax,%edx
801039e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801039e5:	0f b6 00             	movzbl (%eax),%eax
801039e8:	0f b6 c0             	movzbl %al,%eax
801039eb:	83 ec 08             	sub    $0x8,%esp
801039ee:	52                   	push   %edx
801039ef:	50                   	push   %eax
801039f0:	e8 f8 f5 ff ff       	call   80102fed <lapicstartap>
801039f5:	83 c4 10             	add    $0x10,%esp

    // wait for cpu to finish mpmain()
    while(c->started == 0)
801039f8:	90                   	nop
801039f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801039fc:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
80103a02:	85 c0                	test   %eax,%eax
80103a04:	74 f3                	je     801039f9 <startothers+0xb7>
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = p2v(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
80103a06:	81 45 f4 bc 00 00 00 	addl   $0xbc,-0xc(%ebp)
80103a0d:	a1 20 2c 11 80       	mov    0x80112c20,%eax
80103a12:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80103a18:	05 40 26 11 80       	add    $0x80112640,%eax
80103a1d:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80103a20:	0f 87 58 ff ff ff    	ja     8010397e <startothers+0x3c>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
      ;
  }
}
80103a26:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103a29:	c9                   	leave  
80103a2a:	c3                   	ret    

80103a2b <p2v>:
80103a2b:	55                   	push   %ebp
80103a2c:	89 e5                	mov    %esp,%ebp
80103a2e:	8b 45 08             	mov    0x8(%ebp),%eax
80103a31:	05 00 00 00 80       	add    $0x80000000,%eax
80103a36:	5d                   	pop    %ebp
80103a37:	c3                   	ret    

80103a38 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
80103a38:	55                   	push   %ebp
80103a39:	89 e5                	mov    %esp,%ebp
80103a3b:	83 ec 14             	sub    $0x14,%esp
80103a3e:	8b 45 08             	mov    0x8(%ebp),%eax
80103a41:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103a45:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80103a49:	89 c2                	mov    %eax,%edx
80103a4b:	ec                   	in     (%dx),%al
80103a4c:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80103a4f:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80103a53:	c9                   	leave  
80103a54:	c3                   	ret    

80103a55 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80103a55:	55                   	push   %ebp
80103a56:	89 e5                	mov    %esp,%ebp
80103a58:	83 ec 08             	sub    $0x8,%esp
80103a5b:	8b 55 08             	mov    0x8(%ebp),%edx
80103a5e:	8b 45 0c             	mov    0xc(%ebp),%eax
80103a61:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80103a65:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103a68:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80103a6c:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80103a70:	ee                   	out    %al,(%dx)
}
80103a71:	c9                   	leave  
80103a72:	c3                   	ret    

80103a73 <mpbcpu>:
int ncpu;
uchar ioapicid;

int
mpbcpu(void)
{
80103a73:	55                   	push   %ebp
80103a74:	89 e5                	mov    %esp,%ebp
  return bcpu-cpus;
80103a76:	a1 64 b6 10 80       	mov    0x8010b664,%eax
80103a7b:	89 c2                	mov    %eax,%edx
80103a7d:	b8 40 26 11 80       	mov    $0x80112640,%eax
80103a82:	29 c2                	sub    %eax,%edx
80103a84:	89 d0                	mov    %edx,%eax
80103a86:	c1 f8 02             	sar    $0x2,%eax
80103a89:	69 c0 cf 46 7d 67    	imul   $0x677d46cf,%eax,%eax
}
80103a8f:	5d                   	pop    %ebp
80103a90:	c3                   	ret    

80103a91 <sum>:

static uchar
sum(uchar *addr, int len)
{
80103a91:	55                   	push   %ebp
80103a92:	89 e5                	mov    %esp,%ebp
80103a94:	83 ec 10             	sub    $0x10,%esp
  int i, sum;
  
  sum = 0;
80103a97:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  for(i=0; i<len; i++)
80103a9e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
80103aa5:	eb 15                	jmp    80103abc <sum+0x2b>
    sum += addr[i];
80103aa7:	8b 55 fc             	mov    -0x4(%ebp),%edx
80103aaa:	8b 45 08             	mov    0x8(%ebp),%eax
80103aad:	01 d0                	add    %edx,%eax
80103aaf:	0f b6 00             	movzbl (%eax),%eax
80103ab2:	0f b6 c0             	movzbl %al,%eax
80103ab5:	01 45 f8             	add    %eax,-0x8(%ebp)
sum(uchar *addr, int len)
{
  int i, sum;
  
  sum = 0;
  for(i=0; i<len; i++)
80103ab8:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80103abc:	8b 45 fc             	mov    -0x4(%ebp),%eax
80103abf:	3b 45 0c             	cmp    0xc(%ebp),%eax
80103ac2:	7c e3                	jl     80103aa7 <sum+0x16>
    sum += addr[i];
  return sum;
80103ac4:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
80103ac7:	c9                   	leave  
80103ac8:	c3                   	ret    

80103ac9 <mpsearch1>:

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103ac9:	55                   	push   %ebp
80103aca:	89 e5                	mov    %esp,%ebp
80103acc:	83 ec 18             	sub    $0x18,%esp
  uchar *e, *p, *addr;

  addr = p2v(a);
80103acf:	ff 75 08             	pushl  0x8(%ebp)
80103ad2:	e8 54 ff ff ff       	call   80103a2b <p2v>
80103ad7:	83 c4 04             	add    $0x4,%esp
80103ada:	89 45 f0             	mov    %eax,-0x10(%ebp)
  e = addr+len;
80103add:	8b 55 0c             	mov    0xc(%ebp),%edx
80103ae0:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103ae3:	01 d0                	add    %edx,%eax
80103ae5:	89 45 ec             	mov    %eax,-0x14(%ebp)
  for(p = addr; p < e; p += sizeof(struct mp))
80103ae8:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103aeb:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103aee:	eb 36                	jmp    80103b26 <mpsearch1+0x5d>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103af0:	83 ec 04             	sub    $0x4,%esp
80103af3:	6a 04                	push   $0x4
80103af5:	68 08 8a 10 80       	push   $0x80108a08
80103afa:	ff 75 f4             	pushl  -0xc(%ebp)
80103afd:	e8 08 1a 00 00       	call   8010550a <memcmp>
80103b02:	83 c4 10             	add    $0x10,%esp
80103b05:	85 c0                	test   %eax,%eax
80103b07:	75 19                	jne    80103b22 <mpsearch1+0x59>
80103b09:	83 ec 08             	sub    $0x8,%esp
80103b0c:	6a 10                	push   $0x10
80103b0e:	ff 75 f4             	pushl  -0xc(%ebp)
80103b11:	e8 7b ff ff ff       	call   80103a91 <sum>
80103b16:	83 c4 10             	add    $0x10,%esp
80103b19:	84 c0                	test   %al,%al
80103b1b:	75 05                	jne    80103b22 <mpsearch1+0x59>
      return (struct mp*)p;
80103b1d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103b20:	eb 11                	jmp    80103b33 <mpsearch1+0x6a>
{
  uchar *e, *p, *addr;

  addr = p2v(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
80103b22:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
80103b26:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103b29:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80103b2c:	72 c2                	jb     80103af0 <mpsearch1+0x27>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
80103b2e:	b8 00 00 00 00       	mov    $0x0,%eax
}
80103b33:	c9                   	leave  
80103b34:	c3                   	ret    

80103b35 <mpsearch>:
// 1) in the first KB of the EBDA;
// 2) in the last KB of system base memory;
// 3) in the BIOS ROM between 0xE0000 and 0xFFFFF.
static struct mp*
mpsearch(void)
{
80103b35:	55                   	push   %ebp
80103b36:	89 e5                	mov    %esp,%ebp
80103b38:	83 ec 18             	sub    $0x18,%esp
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
80103b3b:	c7 45 f4 00 04 00 80 	movl   $0x80000400,-0xc(%ebp)
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103b42:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103b45:	83 c0 0f             	add    $0xf,%eax
80103b48:	0f b6 00             	movzbl (%eax),%eax
80103b4b:	0f b6 c0             	movzbl %al,%eax
80103b4e:	c1 e0 08             	shl    $0x8,%eax
80103b51:	89 c2                	mov    %eax,%edx
80103b53:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103b56:	83 c0 0e             	add    $0xe,%eax
80103b59:	0f b6 00             	movzbl (%eax),%eax
80103b5c:	0f b6 c0             	movzbl %al,%eax
80103b5f:	09 d0                	or     %edx,%eax
80103b61:	c1 e0 04             	shl    $0x4,%eax
80103b64:	89 45 f0             	mov    %eax,-0x10(%ebp)
80103b67:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80103b6b:	74 21                	je     80103b8e <mpsearch+0x59>
    if((mp = mpsearch1(p, 1024)))
80103b6d:	83 ec 08             	sub    $0x8,%esp
80103b70:	68 00 04 00 00       	push   $0x400
80103b75:	ff 75 f0             	pushl  -0x10(%ebp)
80103b78:	e8 4c ff ff ff       	call   80103ac9 <mpsearch1>
80103b7d:	83 c4 10             	add    $0x10,%esp
80103b80:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103b83:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80103b87:	74 51                	je     80103bda <mpsearch+0xa5>
      return mp;
80103b89:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103b8c:	eb 61                	jmp    80103bef <mpsearch+0xba>
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103b8e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103b91:	83 c0 14             	add    $0x14,%eax
80103b94:	0f b6 00             	movzbl (%eax),%eax
80103b97:	0f b6 c0             	movzbl %al,%eax
80103b9a:	c1 e0 08             	shl    $0x8,%eax
80103b9d:	89 c2                	mov    %eax,%edx
80103b9f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103ba2:	83 c0 13             	add    $0x13,%eax
80103ba5:	0f b6 00             	movzbl (%eax),%eax
80103ba8:	0f b6 c0             	movzbl %al,%eax
80103bab:	09 d0                	or     %edx,%eax
80103bad:	c1 e0 0a             	shl    $0xa,%eax
80103bb0:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if((mp = mpsearch1(p-1024, 1024)))
80103bb3:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103bb6:	2d 00 04 00 00       	sub    $0x400,%eax
80103bbb:	83 ec 08             	sub    $0x8,%esp
80103bbe:	68 00 04 00 00       	push   $0x400
80103bc3:	50                   	push   %eax
80103bc4:	e8 00 ff ff ff       	call   80103ac9 <mpsearch1>
80103bc9:	83 c4 10             	add    $0x10,%esp
80103bcc:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103bcf:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80103bd3:	74 05                	je     80103bda <mpsearch+0xa5>
      return mp;
80103bd5:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103bd8:	eb 15                	jmp    80103bef <mpsearch+0xba>
  }
  return mpsearch1(0xF0000, 0x10000);
80103bda:	83 ec 08             	sub    $0x8,%esp
80103bdd:	68 00 00 01 00       	push   $0x10000
80103be2:	68 00 00 0f 00       	push   $0xf0000
80103be7:	e8 dd fe ff ff       	call   80103ac9 <mpsearch1>
80103bec:	83 c4 10             	add    $0x10,%esp
}
80103bef:	c9                   	leave  
80103bf0:	c3                   	ret    

80103bf1 <mpconfig>:
// Check for correct signature, calculate the checksum and,
// if correct, check the version.
// To do: check extended table checksum.
static struct mpconf*
mpconfig(struct mp **pmp)
{
80103bf1:	55                   	push   %ebp
80103bf2:	89 e5                	mov    %esp,%ebp
80103bf4:	83 ec 18             	sub    $0x18,%esp
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103bf7:	e8 39 ff ff ff       	call   80103b35 <mpsearch>
80103bfc:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103bff:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80103c03:	74 0a                	je     80103c0f <mpconfig+0x1e>
80103c05:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103c08:	8b 40 04             	mov    0x4(%eax),%eax
80103c0b:	85 c0                	test   %eax,%eax
80103c0d:	75 0a                	jne    80103c19 <mpconfig+0x28>
    return 0;
80103c0f:	b8 00 00 00 00       	mov    $0x0,%eax
80103c14:	e9 81 00 00 00       	jmp    80103c9a <mpconfig+0xa9>
  conf = (struct mpconf*) p2v((uint) mp->physaddr);
80103c19:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103c1c:	8b 40 04             	mov    0x4(%eax),%eax
80103c1f:	83 ec 0c             	sub    $0xc,%esp
80103c22:	50                   	push   %eax
80103c23:	e8 03 fe ff ff       	call   80103a2b <p2v>
80103c28:	83 c4 10             	add    $0x10,%esp
80103c2b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
80103c2e:	83 ec 04             	sub    $0x4,%esp
80103c31:	6a 04                	push   $0x4
80103c33:	68 0d 8a 10 80       	push   $0x80108a0d
80103c38:	ff 75 f0             	pushl  -0x10(%ebp)
80103c3b:	e8 ca 18 00 00       	call   8010550a <memcmp>
80103c40:	83 c4 10             	add    $0x10,%esp
80103c43:	85 c0                	test   %eax,%eax
80103c45:	74 07                	je     80103c4e <mpconfig+0x5d>
    return 0;
80103c47:	b8 00 00 00 00       	mov    $0x0,%eax
80103c4c:	eb 4c                	jmp    80103c9a <mpconfig+0xa9>
  if(conf->version != 1 && conf->version != 4)
80103c4e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103c51:	0f b6 40 06          	movzbl 0x6(%eax),%eax
80103c55:	3c 01                	cmp    $0x1,%al
80103c57:	74 12                	je     80103c6b <mpconfig+0x7a>
80103c59:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103c5c:	0f b6 40 06          	movzbl 0x6(%eax),%eax
80103c60:	3c 04                	cmp    $0x4,%al
80103c62:	74 07                	je     80103c6b <mpconfig+0x7a>
    return 0;
80103c64:	b8 00 00 00 00       	mov    $0x0,%eax
80103c69:	eb 2f                	jmp    80103c9a <mpconfig+0xa9>
  if(sum((uchar*)conf, conf->length) != 0)
80103c6b:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103c6e:	0f b7 40 04          	movzwl 0x4(%eax),%eax
80103c72:	0f b7 c0             	movzwl %ax,%eax
80103c75:	83 ec 08             	sub    $0x8,%esp
80103c78:	50                   	push   %eax
80103c79:	ff 75 f0             	pushl  -0x10(%ebp)
80103c7c:	e8 10 fe ff ff       	call   80103a91 <sum>
80103c81:	83 c4 10             	add    $0x10,%esp
80103c84:	84 c0                	test   %al,%al
80103c86:	74 07                	je     80103c8f <mpconfig+0x9e>
    return 0;
80103c88:	b8 00 00 00 00       	mov    $0x0,%eax
80103c8d:	eb 0b                	jmp    80103c9a <mpconfig+0xa9>
  *pmp = mp;
80103c8f:	8b 45 08             	mov    0x8(%ebp),%eax
80103c92:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103c95:	89 10                	mov    %edx,(%eax)
  return conf;
80103c97:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80103c9a:	c9                   	leave  
80103c9b:	c3                   	ret    

80103c9c <mpinit>:

void
mpinit(void)
{
80103c9c:	55                   	push   %ebp
80103c9d:	89 e5                	mov    %esp,%ebp
80103c9f:	83 ec 28             	sub    $0x28,%esp
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  bcpu = &cpus[0];
80103ca2:	c7 05 64 b6 10 80 40 	movl   $0x80112640,0x8010b664
80103ca9:	26 11 80 
  if((conf = mpconfig(&mp)) == 0)
80103cac:	83 ec 0c             	sub    $0xc,%esp
80103caf:	8d 45 e0             	lea    -0x20(%ebp),%eax
80103cb2:	50                   	push   %eax
80103cb3:	e8 39 ff ff ff       	call   80103bf1 <mpconfig>
80103cb8:	83 c4 10             	add    $0x10,%esp
80103cbb:	89 45 f0             	mov    %eax,-0x10(%ebp)
80103cbe:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80103cc2:	75 05                	jne    80103cc9 <mpinit+0x2d>
    return;
80103cc4:	e9 94 01 00 00       	jmp    80103e5d <mpinit+0x1c1>
  ismp = 1;
80103cc9:	c7 05 04 26 11 80 01 	movl   $0x1,0x80112604
80103cd0:	00 00 00 
  lapic = (uint*)conf->lapicaddr;
80103cd3:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103cd6:	8b 40 24             	mov    0x24(%eax),%eax
80103cd9:	a3 dc 24 11 80       	mov    %eax,0x801124dc
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103cde:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103ce1:	83 c0 2c             	add    $0x2c,%eax
80103ce4:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103ce7:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103cea:	0f b7 40 04          	movzwl 0x4(%eax),%eax
80103cee:	0f b7 d0             	movzwl %ax,%edx
80103cf1:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103cf4:	01 d0                	add    %edx,%eax
80103cf6:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103cf9:	e9 f2 00 00 00       	jmp    80103df0 <mpinit+0x154>
    switch(*p){
80103cfe:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103d01:	0f b6 00             	movzbl (%eax),%eax
80103d04:	0f b6 c0             	movzbl %al,%eax
80103d07:	83 f8 04             	cmp    $0x4,%eax
80103d0a:	0f 87 bc 00 00 00    	ja     80103dcc <mpinit+0x130>
80103d10:	8b 04 85 50 8a 10 80 	mov    -0x7fef75b0(,%eax,4),%eax
80103d17:	ff e0                	jmp    *%eax
    case MPPROC:
      proc = (struct mpproc*)p;
80103d19:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103d1c:	89 45 e8             	mov    %eax,-0x18(%ebp)
      if(ncpu != proc->apicid){
80103d1f:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103d22:	0f b6 40 01          	movzbl 0x1(%eax),%eax
80103d26:	0f b6 d0             	movzbl %al,%edx
80103d29:	a1 20 2c 11 80       	mov    0x80112c20,%eax
80103d2e:	39 c2                	cmp    %eax,%edx
80103d30:	74 2b                	je     80103d5d <mpinit+0xc1>
        cprintf("mpinit: ncpu=%d apicid=%d\n", ncpu, proc->apicid);
80103d32:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103d35:	0f b6 40 01          	movzbl 0x1(%eax),%eax
80103d39:	0f b6 d0             	movzbl %al,%edx
80103d3c:	a1 20 2c 11 80       	mov    0x80112c20,%eax
80103d41:	83 ec 04             	sub    $0x4,%esp
80103d44:	52                   	push   %edx
80103d45:	50                   	push   %eax
80103d46:	68 12 8a 10 80       	push   $0x80108a12
80103d4b:	e8 6f c6 ff ff       	call   801003bf <cprintf>
80103d50:	83 c4 10             	add    $0x10,%esp
        ismp = 0;
80103d53:	c7 05 04 26 11 80 00 	movl   $0x0,0x80112604
80103d5a:	00 00 00 
      }
      if(proc->flags & MPBOOT)
80103d5d:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103d60:	0f b6 40 03          	movzbl 0x3(%eax),%eax
80103d64:	0f b6 c0             	movzbl %al,%eax
80103d67:	83 e0 02             	and    $0x2,%eax
80103d6a:	85 c0                	test   %eax,%eax
80103d6c:	74 15                	je     80103d83 <mpinit+0xe7>
        bcpu = &cpus[ncpu];
80103d6e:	a1 20 2c 11 80       	mov    0x80112c20,%eax
80103d73:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80103d79:	05 40 26 11 80       	add    $0x80112640,%eax
80103d7e:	a3 64 b6 10 80       	mov    %eax,0x8010b664
      cpus[ncpu].id = ncpu;
80103d83:	a1 20 2c 11 80       	mov    0x80112c20,%eax
80103d88:	8b 15 20 2c 11 80    	mov    0x80112c20,%edx
80103d8e:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80103d94:	05 40 26 11 80       	add    $0x80112640,%eax
80103d99:	88 10                	mov    %dl,(%eax)
      ncpu++;
80103d9b:	a1 20 2c 11 80       	mov    0x80112c20,%eax
80103da0:	83 c0 01             	add    $0x1,%eax
80103da3:	a3 20 2c 11 80       	mov    %eax,0x80112c20
      p += sizeof(struct mpproc);
80103da8:	83 45 f4 14          	addl   $0x14,-0xc(%ebp)
      continue;
80103dac:	eb 42                	jmp    80103df0 <mpinit+0x154>
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
80103dae:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103db1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      ioapicid = ioapic->apicno;
80103db4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103db7:	0f b6 40 01          	movzbl 0x1(%eax),%eax
80103dbb:	a2 00 26 11 80       	mov    %al,0x80112600
      p += sizeof(struct mpioapic);
80103dc0:	83 45 f4 08          	addl   $0x8,-0xc(%ebp)
      continue;
80103dc4:	eb 2a                	jmp    80103df0 <mpinit+0x154>
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103dc6:	83 45 f4 08          	addl   $0x8,-0xc(%ebp)
      continue;
80103dca:	eb 24                	jmp    80103df0 <mpinit+0x154>
    default:
      cprintf("mpinit: unknown config type %x\n", *p);
80103dcc:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103dcf:	0f b6 00             	movzbl (%eax),%eax
80103dd2:	0f b6 c0             	movzbl %al,%eax
80103dd5:	83 ec 08             	sub    $0x8,%esp
80103dd8:	50                   	push   %eax
80103dd9:	68 30 8a 10 80       	push   $0x80108a30
80103dde:	e8 dc c5 ff ff       	call   801003bf <cprintf>
80103de3:	83 c4 10             	add    $0x10,%esp
      ismp = 0;
80103de6:	c7 05 04 26 11 80 00 	movl   $0x0,0x80112604
80103ded:	00 00 00 
  bcpu = &cpus[0];
  if((conf = mpconfig(&mp)) == 0)
    return;
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103df0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103df3:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80103df6:	0f 82 02 ff ff ff    	jb     80103cfe <mpinit+0x62>
    default:
      cprintf("mpinit: unknown config type %x\n", *p);
      ismp = 0;
    }
  }
  if(!ismp){
80103dfc:	a1 04 26 11 80       	mov    0x80112604,%eax
80103e01:	85 c0                	test   %eax,%eax
80103e03:	75 1d                	jne    80103e22 <mpinit+0x186>
    // Didn't like what we found; fall back to no MP.
    ncpu = 1;
80103e05:	c7 05 20 2c 11 80 01 	movl   $0x1,0x80112c20
80103e0c:	00 00 00 
    lapic = 0;
80103e0f:	c7 05 dc 24 11 80 00 	movl   $0x0,0x801124dc
80103e16:	00 00 00 
    ioapicid = 0;
80103e19:	c6 05 00 26 11 80 00 	movb   $0x0,0x80112600
    return;
80103e20:	eb 3b                	jmp    80103e5d <mpinit+0x1c1>
  }

  if(mp->imcrp){
80103e22:	8b 45 e0             	mov    -0x20(%ebp),%eax
80103e25:	0f b6 40 0c          	movzbl 0xc(%eax),%eax
80103e29:	84 c0                	test   %al,%al
80103e2b:	74 30                	je     80103e5d <mpinit+0x1c1>
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
80103e2d:	83 ec 08             	sub    $0x8,%esp
80103e30:	6a 70                	push   $0x70
80103e32:	6a 22                	push   $0x22
80103e34:	e8 1c fc ff ff       	call   80103a55 <outb>
80103e39:	83 c4 10             	add    $0x10,%esp
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80103e3c:	83 ec 0c             	sub    $0xc,%esp
80103e3f:	6a 23                	push   $0x23
80103e41:	e8 f2 fb ff ff       	call   80103a38 <inb>
80103e46:	83 c4 10             	add    $0x10,%esp
80103e49:	83 c8 01             	or     $0x1,%eax
80103e4c:	0f b6 c0             	movzbl %al,%eax
80103e4f:	83 ec 08             	sub    $0x8,%esp
80103e52:	50                   	push   %eax
80103e53:	6a 23                	push   $0x23
80103e55:	e8 fb fb ff ff       	call   80103a55 <outb>
80103e5a:	83 c4 10             	add    $0x10,%esp
  }
}
80103e5d:	c9                   	leave  
80103e5e:	c3                   	ret    

80103e5f <outb>:
80103e5f:	55                   	push   %ebp
80103e60:	89 e5                	mov    %esp,%ebp
80103e62:	83 ec 08             	sub    $0x8,%esp
80103e65:	8b 55 08             	mov    0x8(%ebp),%edx
80103e68:	8b 45 0c             	mov    0xc(%ebp),%eax
80103e6b:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80103e6f:	88 45 f8             	mov    %al,-0x8(%ebp)
80103e72:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80103e76:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80103e7a:	ee                   	out    %al,(%dx)
80103e7b:	c9                   	leave  
80103e7c:	c3                   	ret    

80103e7d <picsetmask>:
80103e7d:	55                   	push   %ebp
80103e7e:	89 e5                	mov    %esp,%ebp
80103e80:	83 ec 04             	sub    $0x4,%esp
80103e83:	8b 45 08             	mov    0x8(%ebp),%eax
80103e86:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
80103e8a:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80103e8e:	66 a3 00 b0 10 80    	mov    %ax,0x8010b000
80103e94:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80103e98:	0f b6 c0             	movzbl %al,%eax
80103e9b:	50                   	push   %eax
80103e9c:	6a 21                	push   $0x21
80103e9e:	e8 bc ff ff ff       	call   80103e5f <outb>
80103ea3:	83 c4 08             	add    $0x8,%esp
80103ea6:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80103eaa:	66 c1 e8 08          	shr    $0x8,%ax
80103eae:	0f b6 c0             	movzbl %al,%eax
80103eb1:	50                   	push   %eax
80103eb2:	68 a1 00 00 00       	push   $0xa1
80103eb7:	e8 a3 ff ff ff       	call   80103e5f <outb>
80103ebc:	83 c4 08             	add    $0x8,%esp
80103ebf:	c9                   	leave  
80103ec0:	c3                   	ret    

80103ec1 <picenable>:
80103ec1:	55                   	push   %ebp
80103ec2:	89 e5                	mov    %esp,%ebp
80103ec4:	8b 45 08             	mov    0x8(%ebp),%eax
80103ec7:	ba 01 00 00 00       	mov    $0x1,%edx
80103ecc:	89 c1                	mov    %eax,%ecx
80103ece:	d3 e2                	shl    %cl,%edx
80103ed0:	89 d0                	mov    %edx,%eax
80103ed2:	f7 d0                	not    %eax
80103ed4:	89 c2                	mov    %eax,%edx
80103ed6:	0f b7 05 00 b0 10 80 	movzwl 0x8010b000,%eax
80103edd:	21 d0                	and    %edx,%eax
80103edf:	0f b7 c0             	movzwl %ax,%eax
80103ee2:	50                   	push   %eax
80103ee3:	e8 95 ff ff ff       	call   80103e7d <picsetmask>
80103ee8:	83 c4 04             	add    $0x4,%esp
80103eeb:	c9                   	leave  
80103eec:	c3                   	ret    

80103eed <picinit>:
80103eed:	55                   	push   %ebp
80103eee:	89 e5                	mov    %esp,%ebp
80103ef0:	68 ff 00 00 00       	push   $0xff
80103ef5:	6a 21                	push   $0x21
80103ef7:	e8 63 ff ff ff       	call   80103e5f <outb>
80103efc:	83 c4 08             	add    $0x8,%esp
80103eff:	68 ff 00 00 00       	push   $0xff
80103f04:	68 a1 00 00 00       	push   $0xa1
80103f09:	e8 51 ff ff ff       	call   80103e5f <outb>
80103f0e:	83 c4 08             	add    $0x8,%esp
80103f11:	6a 11                	push   $0x11
80103f13:	6a 20                	push   $0x20
80103f15:	e8 45 ff ff ff       	call   80103e5f <outb>
80103f1a:	83 c4 08             	add    $0x8,%esp
80103f1d:	6a 20                	push   $0x20
80103f1f:	6a 21                	push   $0x21
80103f21:	e8 39 ff ff ff       	call   80103e5f <outb>
80103f26:	83 c4 08             	add    $0x8,%esp
80103f29:	6a 04                	push   $0x4
80103f2b:	6a 21                	push   $0x21
80103f2d:	e8 2d ff ff ff       	call   80103e5f <outb>
80103f32:	83 c4 08             	add    $0x8,%esp
80103f35:	6a 03                	push   $0x3
80103f37:	6a 21                	push   $0x21
80103f39:	e8 21 ff ff ff       	call   80103e5f <outb>
80103f3e:	83 c4 08             	add    $0x8,%esp
80103f41:	6a 11                	push   $0x11
80103f43:	68 a0 00 00 00       	push   $0xa0
80103f48:	e8 12 ff ff ff       	call   80103e5f <outb>
80103f4d:	83 c4 08             	add    $0x8,%esp
80103f50:	6a 28                	push   $0x28
80103f52:	68 a1 00 00 00       	push   $0xa1
80103f57:	e8 03 ff ff ff       	call   80103e5f <outb>
80103f5c:	83 c4 08             	add    $0x8,%esp
80103f5f:	6a 02                	push   $0x2
80103f61:	68 a1 00 00 00       	push   $0xa1
80103f66:	e8 f4 fe ff ff       	call   80103e5f <outb>
80103f6b:	83 c4 08             	add    $0x8,%esp
80103f6e:	6a 03                	push   $0x3
80103f70:	68 a1 00 00 00       	push   $0xa1
80103f75:	e8 e5 fe ff ff       	call   80103e5f <outb>
80103f7a:	83 c4 08             	add    $0x8,%esp
80103f7d:	6a 68                	push   $0x68
80103f7f:	6a 20                	push   $0x20
80103f81:	e8 d9 fe ff ff       	call   80103e5f <outb>
80103f86:	83 c4 08             	add    $0x8,%esp
80103f89:	6a 0a                	push   $0xa
80103f8b:	6a 20                	push   $0x20
80103f8d:	e8 cd fe ff ff       	call   80103e5f <outb>
80103f92:	83 c4 08             	add    $0x8,%esp
80103f95:	6a 68                	push   $0x68
80103f97:	68 a0 00 00 00       	push   $0xa0
80103f9c:	e8 be fe ff ff       	call   80103e5f <outb>
80103fa1:	83 c4 08             	add    $0x8,%esp
80103fa4:	6a 0a                	push   $0xa
80103fa6:	68 a0 00 00 00       	push   $0xa0
80103fab:	e8 af fe ff ff       	call   80103e5f <outb>
80103fb0:	83 c4 08             	add    $0x8,%esp
80103fb3:	0f b7 05 00 b0 10 80 	movzwl 0x8010b000,%eax
80103fba:	66 83 f8 ff          	cmp    $0xffff,%ax
80103fbe:	74 13                	je     80103fd3 <picinit+0xe6>
80103fc0:	0f b7 05 00 b0 10 80 	movzwl 0x8010b000,%eax
80103fc7:	0f b7 c0             	movzwl %ax,%eax
80103fca:	50                   	push   %eax
80103fcb:	e8 ad fe ff ff       	call   80103e7d <picsetmask>
80103fd0:	83 c4 04             	add    $0x4,%esp
80103fd3:	c9                   	leave  
80103fd4:	c3                   	ret    

80103fd5 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103fd5:	55                   	push   %ebp
80103fd6:	89 e5                	mov    %esp,%ebp
80103fd8:	83 ec 18             	sub    $0x18,%esp
  struct pipe *p;

  p = 0;
80103fdb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  *f0 = *f1 = 0;
80103fe2:	8b 45 0c             	mov    0xc(%ebp),%eax
80103fe5:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80103feb:	8b 45 0c             	mov    0xc(%ebp),%eax
80103fee:	8b 10                	mov    (%eax),%edx
80103ff0:	8b 45 08             	mov    0x8(%ebp),%eax
80103ff3:	89 10                	mov    %edx,(%eax)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
80103ff5:	e8 61 cf ff ff       	call   80100f5b <filealloc>
80103ffa:	89 c2                	mov    %eax,%edx
80103ffc:	8b 45 08             	mov    0x8(%ebp),%eax
80103fff:	89 10                	mov    %edx,(%eax)
80104001:	8b 45 08             	mov    0x8(%ebp),%eax
80104004:	8b 00                	mov    (%eax),%eax
80104006:	85 c0                	test   %eax,%eax
80104008:	0f 84 cb 00 00 00    	je     801040d9 <pipealloc+0x104>
8010400e:	e8 48 cf ff ff       	call   80100f5b <filealloc>
80104013:	89 c2                	mov    %eax,%edx
80104015:	8b 45 0c             	mov    0xc(%ebp),%eax
80104018:	89 10                	mov    %edx,(%eax)
8010401a:	8b 45 0c             	mov    0xc(%ebp),%eax
8010401d:	8b 00                	mov    (%eax),%eax
8010401f:	85 c0                	test   %eax,%eax
80104021:	0f 84 b2 00 00 00    	je     801040d9 <pipealloc+0x104>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80104027:	e8 e8 eb ff ff       	call   80102c14 <kalloc>
8010402c:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010402f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80104033:	75 05                	jne    8010403a <pipealloc+0x65>
    goto bad;
80104035:	e9 9f 00 00 00       	jmp    801040d9 <pipealloc+0x104>
  p->readopen = 1;
8010403a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010403d:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
80104044:	00 00 00 
  p->writeopen = 1;
80104047:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010404a:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
80104051:	00 00 00 
  p->nwrite = 0;
80104054:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104057:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
8010405e:	00 00 00 
  p->nread = 0;
80104061:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104064:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
8010406b:	00 00 00 
  initlock(&p->lock, "pipe");
8010406e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104071:	83 ec 08             	sub    $0x8,%esp
80104074:	68 64 8a 10 80       	push   $0x80108a64
80104079:	50                   	push   %eax
8010407a:	e8 a7 11 00 00       	call   80105226 <initlock>
8010407f:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
80104082:	8b 45 08             	mov    0x8(%ebp),%eax
80104085:	8b 00                	mov    (%eax),%eax
80104087:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
8010408d:	8b 45 08             	mov    0x8(%ebp),%eax
80104090:	8b 00                	mov    (%eax),%eax
80104092:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
80104096:	8b 45 08             	mov    0x8(%ebp),%eax
80104099:	8b 00                	mov    (%eax),%eax
8010409b:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
8010409f:	8b 45 08             	mov    0x8(%ebp),%eax
801040a2:	8b 00                	mov    (%eax),%eax
801040a4:	8b 55 f4             	mov    -0xc(%ebp),%edx
801040a7:	89 50 0c             	mov    %edx,0xc(%eax)
  (*f1)->type = FD_PIPE;
801040aa:	8b 45 0c             	mov    0xc(%ebp),%eax
801040ad:	8b 00                	mov    (%eax),%eax
801040af:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
801040b5:	8b 45 0c             	mov    0xc(%ebp),%eax
801040b8:	8b 00                	mov    (%eax),%eax
801040ba:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
801040be:	8b 45 0c             	mov    0xc(%ebp),%eax
801040c1:	8b 00                	mov    (%eax),%eax
801040c3:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
801040c7:	8b 45 0c             	mov    0xc(%ebp),%eax
801040ca:	8b 00                	mov    (%eax),%eax
801040cc:	8b 55 f4             	mov    -0xc(%ebp),%edx
801040cf:	89 50 0c             	mov    %edx,0xc(%eax)
  return 0;
801040d2:	b8 00 00 00 00       	mov    $0x0,%eax
801040d7:	eb 4d                	jmp    80104126 <pipealloc+0x151>

//PAGEBREAK: 20
 bad:
  if(p)
801040d9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801040dd:	74 0e                	je     801040ed <pipealloc+0x118>
    kfree((char*)p);
801040df:	83 ec 0c             	sub    $0xc,%esp
801040e2:	ff 75 f4             	pushl  -0xc(%ebp)
801040e5:	e8 8e ea ff ff       	call   80102b78 <kfree>
801040ea:	83 c4 10             	add    $0x10,%esp
  if(*f0)
801040ed:	8b 45 08             	mov    0x8(%ebp),%eax
801040f0:	8b 00                	mov    (%eax),%eax
801040f2:	85 c0                	test   %eax,%eax
801040f4:	74 11                	je     80104107 <pipealloc+0x132>
    fileclose(*f0);
801040f6:	8b 45 08             	mov    0x8(%ebp),%eax
801040f9:	8b 00                	mov    (%eax),%eax
801040fb:	83 ec 0c             	sub    $0xc,%esp
801040fe:	50                   	push   %eax
801040ff:	e8 14 cf ff ff       	call   80101018 <fileclose>
80104104:	83 c4 10             	add    $0x10,%esp
  if(*f1)
80104107:	8b 45 0c             	mov    0xc(%ebp),%eax
8010410a:	8b 00                	mov    (%eax),%eax
8010410c:	85 c0                	test   %eax,%eax
8010410e:	74 11                	je     80104121 <pipealloc+0x14c>
    fileclose(*f1);
80104110:	8b 45 0c             	mov    0xc(%ebp),%eax
80104113:	8b 00                	mov    (%eax),%eax
80104115:	83 ec 0c             	sub    $0xc,%esp
80104118:	50                   	push   %eax
80104119:	e8 fa ce ff ff       	call   80101018 <fileclose>
8010411e:	83 c4 10             	add    $0x10,%esp
  return -1;
80104121:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104126:	c9                   	leave  
80104127:	c3                   	ret    

80104128 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80104128:	55                   	push   %ebp
80104129:	89 e5                	mov    %esp,%ebp
8010412b:	83 ec 08             	sub    $0x8,%esp
  acquire(&p->lock);
8010412e:	8b 45 08             	mov    0x8(%ebp),%eax
80104131:	83 ec 0c             	sub    $0xc,%esp
80104134:	50                   	push   %eax
80104135:	e8 0d 11 00 00       	call   80105247 <acquire>
8010413a:	83 c4 10             	add    $0x10,%esp
  if(writable){
8010413d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80104141:	74 23                	je     80104166 <pipeclose+0x3e>
    p->writeopen = 0;
80104143:	8b 45 08             	mov    0x8(%ebp),%eax
80104146:	c7 80 40 02 00 00 00 	movl   $0x0,0x240(%eax)
8010414d:	00 00 00 
    wakeup(&p->nread);
80104150:	8b 45 08             	mov    0x8(%ebp),%eax
80104153:	05 34 02 00 00       	add    $0x234,%eax
80104158:	83 ec 0c             	sub    $0xc,%esp
8010415b:	50                   	push   %eax
8010415c:	e8 cc 0e 00 00       	call   8010502d <wakeup>
80104161:	83 c4 10             	add    $0x10,%esp
80104164:	eb 21                	jmp    80104187 <pipeclose+0x5f>
  } else {
    p->readopen = 0;
80104166:	8b 45 08             	mov    0x8(%ebp),%eax
80104169:	c7 80 3c 02 00 00 00 	movl   $0x0,0x23c(%eax)
80104170:	00 00 00 
    wakeup(&p->nwrite);
80104173:	8b 45 08             	mov    0x8(%ebp),%eax
80104176:	05 38 02 00 00       	add    $0x238,%eax
8010417b:	83 ec 0c             	sub    $0xc,%esp
8010417e:	50                   	push   %eax
8010417f:	e8 a9 0e 00 00       	call   8010502d <wakeup>
80104184:	83 c4 10             	add    $0x10,%esp
  }
  if(p->readopen == 0 && p->writeopen == 0){
80104187:	8b 45 08             	mov    0x8(%ebp),%eax
8010418a:	8b 80 3c 02 00 00    	mov    0x23c(%eax),%eax
80104190:	85 c0                	test   %eax,%eax
80104192:	75 2c                	jne    801041c0 <pipeclose+0x98>
80104194:	8b 45 08             	mov    0x8(%ebp),%eax
80104197:	8b 80 40 02 00 00    	mov    0x240(%eax),%eax
8010419d:	85 c0                	test   %eax,%eax
8010419f:	75 1f                	jne    801041c0 <pipeclose+0x98>
    release(&p->lock);
801041a1:	8b 45 08             	mov    0x8(%ebp),%eax
801041a4:	83 ec 0c             	sub    $0xc,%esp
801041a7:	50                   	push   %eax
801041a8:	e8 00 11 00 00       	call   801052ad <release>
801041ad:	83 c4 10             	add    $0x10,%esp
    kfree((char*)p);
801041b0:	83 ec 0c             	sub    $0xc,%esp
801041b3:	ff 75 08             	pushl  0x8(%ebp)
801041b6:	e8 bd e9 ff ff       	call   80102b78 <kfree>
801041bb:	83 c4 10             	add    $0x10,%esp
801041be:	eb 0f                	jmp    801041cf <pipeclose+0xa7>
  } else
    release(&p->lock);
801041c0:	8b 45 08             	mov    0x8(%ebp),%eax
801041c3:	83 ec 0c             	sub    $0xc,%esp
801041c6:	50                   	push   %eax
801041c7:	e8 e1 10 00 00       	call   801052ad <release>
801041cc:	83 c4 10             	add    $0x10,%esp
}
801041cf:	c9                   	leave  
801041d0:	c3                   	ret    

801041d1 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
801041d1:	55                   	push   %ebp
801041d2:	89 e5                	mov    %esp,%ebp
801041d4:	83 ec 18             	sub    $0x18,%esp
  int i;

  acquire(&p->lock);
801041d7:	8b 45 08             	mov    0x8(%ebp),%eax
801041da:	83 ec 0c             	sub    $0xc,%esp
801041dd:	50                   	push   %eax
801041de:	e8 64 10 00 00       	call   80105247 <acquire>
801041e3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < n; i++){
801041e6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801041ed:	e9 af 00 00 00       	jmp    801042a1 <pipewrite+0xd0>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801041f2:	eb 60                	jmp    80104254 <pipewrite+0x83>
      if(p->readopen == 0 || proc->killed){
801041f4:	8b 45 08             	mov    0x8(%ebp),%eax
801041f7:	8b 80 3c 02 00 00    	mov    0x23c(%eax),%eax
801041fd:	85 c0                	test   %eax,%eax
801041ff:	74 0d                	je     8010420e <pipewrite+0x3d>
80104201:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104207:	8b 40 24             	mov    0x24(%eax),%eax
8010420a:	85 c0                	test   %eax,%eax
8010420c:	74 19                	je     80104227 <pipewrite+0x56>
        release(&p->lock);
8010420e:	8b 45 08             	mov    0x8(%ebp),%eax
80104211:	83 ec 0c             	sub    $0xc,%esp
80104214:	50                   	push   %eax
80104215:	e8 93 10 00 00       	call   801052ad <release>
8010421a:	83 c4 10             	add    $0x10,%esp
        return -1;
8010421d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104222:	e9 ac 00 00 00       	jmp    801042d3 <pipewrite+0x102>
      }
      wakeup(&p->nread);
80104227:	8b 45 08             	mov    0x8(%ebp),%eax
8010422a:	05 34 02 00 00       	add    $0x234,%eax
8010422f:	83 ec 0c             	sub    $0xc,%esp
80104232:	50                   	push   %eax
80104233:	e8 f5 0d 00 00       	call   8010502d <wakeup>
80104238:	83 c4 10             	add    $0x10,%esp
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
8010423b:	8b 45 08             	mov    0x8(%ebp),%eax
8010423e:	8b 55 08             	mov    0x8(%ebp),%edx
80104241:	81 c2 38 02 00 00    	add    $0x238,%edx
80104247:	83 ec 08             	sub    $0x8,%esp
8010424a:	50                   	push   %eax
8010424b:	52                   	push   %edx
8010424c:	e8 d0 0c 00 00       	call   80104f21 <sleep>
80104251:	83 c4 10             	add    $0x10,%esp
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80104254:	8b 45 08             	mov    0x8(%ebp),%eax
80104257:	8b 90 38 02 00 00    	mov    0x238(%eax),%edx
8010425d:	8b 45 08             	mov    0x8(%ebp),%eax
80104260:	8b 80 34 02 00 00    	mov    0x234(%eax),%eax
80104266:	05 00 02 00 00       	add    $0x200,%eax
8010426b:	39 c2                	cmp    %eax,%edx
8010426d:	74 85                	je     801041f4 <pipewrite+0x23>
        return -1;
      }
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
8010426f:	8b 45 08             	mov    0x8(%ebp),%eax
80104272:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
80104278:	8d 48 01             	lea    0x1(%eax),%ecx
8010427b:	8b 55 08             	mov    0x8(%ebp),%edx
8010427e:	89 8a 38 02 00 00    	mov    %ecx,0x238(%edx)
80104284:	25 ff 01 00 00       	and    $0x1ff,%eax
80104289:	89 c1                	mov    %eax,%ecx
8010428b:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010428e:	8b 45 0c             	mov    0xc(%ebp),%eax
80104291:	01 d0                	add    %edx,%eax
80104293:	0f b6 10             	movzbl (%eax),%edx
80104296:	8b 45 08             	mov    0x8(%ebp),%eax
80104299:	88 54 08 34          	mov    %dl,0x34(%eax,%ecx,1)
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
8010429d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801042a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801042a4:	3b 45 10             	cmp    0x10(%ebp),%eax
801042a7:	0f 8c 45 ff ff ff    	jl     801041f2 <pipewrite+0x21>
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
801042ad:	8b 45 08             	mov    0x8(%ebp),%eax
801042b0:	05 34 02 00 00       	add    $0x234,%eax
801042b5:	83 ec 0c             	sub    $0xc,%esp
801042b8:	50                   	push   %eax
801042b9:	e8 6f 0d 00 00       	call   8010502d <wakeup>
801042be:	83 c4 10             	add    $0x10,%esp
  release(&p->lock);
801042c1:	8b 45 08             	mov    0x8(%ebp),%eax
801042c4:	83 ec 0c             	sub    $0xc,%esp
801042c7:	50                   	push   %eax
801042c8:	e8 e0 0f 00 00       	call   801052ad <release>
801042cd:	83 c4 10             	add    $0x10,%esp
  return n;
801042d0:	8b 45 10             	mov    0x10(%ebp),%eax
}
801042d3:	c9                   	leave  
801042d4:	c3                   	ret    

801042d5 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
801042d5:	55                   	push   %ebp
801042d6:	89 e5                	mov    %esp,%ebp
801042d8:	53                   	push   %ebx
801042d9:	83 ec 14             	sub    $0x14,%esp
  int i;

  acquire(&p->lock);
801042dc:	8b 45 08             	mov    0x8(%ebp),%eax
801042df:	83 ec 0c             	sub    $0xc,%esp
801042e2:	50                   	push   %eax
801042e3:	e8 5f 0f 00 00       	call   80105247 <acquire>
801042e8:	83 c4 10             	add    $0x10,%esp
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801042eb:	eb 3f                	jmp    8010432c <piperead+0x57>
    if(proc->killed){
801042ed:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801042f3:	8b 40 24             	mov    0x24(%eax),%eax
801042f6:	85 c0                	test   %eax,%eax
801042f8:	74 19                	je     80104313 <piperead+0x3e>
      release(&p->lock);
801042fa:	8b 45 08             	mov    0x8(%ebp),%eax
801042fd:	83 ec 0c             	sub    $0xc,%esp
80104300:	50                   	push   %eax
80104301:	e8 a7 0f 00 00       	call   801052ad <release>
80104306:	83 c4 10             	add    $0x10,%esp
      return -1;
80104309:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010430e:	e9 be 00 00 00       	jmp    801043d1 <piperead+0xfc>
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80104313:	8b 45 08             	mov    0x8(%ebp),%eax
80104316:	8b 55 08             	mov    0x8(%ebp),%edx
80104319:	81 c2 34 02 00 00    	add    $0x234,%edx
8010431f:	83 ec 08             	sub    $0x8,%esp
80104322:	50                   	push   %eax
80104323:	52                   	push   %edx
80104324:	e8 f8 0b 00 00       	call   80104f21 <sleep>
80104329:	83 c4 10             	add    $0x10,%esp
piperead(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010432c:	8b 45 08             	mov    0x8(%ebp),%eax
8010432f:	8b 90 34 02 00 00    	mov    0x234(%eax),%edx
80104335:	8b 45 08             	mov    0x8(%ebp),%eax
80104338:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
8010433e:	39 c2                	cmp    %eax,%edx
80104340:	75 0d                	jne    8010434f <piperead+0x7a>
80104342:	8b 45 08             	mov    0x8(%ebp),%eax
80104345:	8b 80 40 02 00 00    	mov    0x240(%eax),%eax
8010434b:	85 c0                	test   %eax,%eax
8010434d:	75 9e                	jne    801042ed <piperead+0x18>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
8010434f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80104356:	eb 4b                	jmp    801043a3 <piperead+0xce>
    if(p->nread == p->nwrite)
80104358:	8b 45 08             	mov    0x8(%ebp),%eax
8010435b:	8b 90 34 02 00 00    	mov    0x234(%eax),%edx
80104361:	8b 45 08             	mov    0x8(%ebp),%eax
80104364:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
8010436a:	39 c2                	cmp    %eax,%edx
8010436c:	75 02                	jne    80104370 <piperead+0x9b>
      break;
8010436e:	eb 3b                	jmp    801043ab <piperead+0xd6>
    addr[i] = p->data[p->nread++ % PIPESIZE];
80104370:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104373:	8b 45 0c             	mov    0xc(%ebp),%eax
80104376:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
80104379:	8b 45 08             	mov    0x8(%ebp),%eax
8010437c:	8b 80 34 02 00 00    	mov    0x234(%eax),%eax
80104382:	8d 48 01             	lea    0x1(%eax),%ecx
80104385:	8b 55 08             	mov    0x8(%ebp),%edx
80104388:	89 8a 34 02 00 00    	mov    %ecx,0x234(%edx)
8010438e:	25 ff 01 00 00       	and    $0x1ff,%eax
80104393:	89 c2                	mov    %eax,%edx
80104395:	8b 45 08             	mov    0x8(%ebp),%eax
80104398:	0f b6 44 10 34       	movzbl 0x34(%eax,%edx,1),%eax
8010439d:	88 03                	mov    %al,(%ebx)
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
8010439f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801043a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801043a6:	3b 45 10             	cmp    0x10(%ebp),%eax
801043a9:	7c ad                	jl     80104358 <piperead+0x83>
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
801043ab:	8b 45 08             	mov    0x8(%ebp),%eax
801043ae:	05 38 02 00 00       	add    $0x238,%eax
801043b3:	83 ec 0c             	sub    $0xc,%esp
801043b6:	50                   	push   %eax
801043b7:	e8 71 0c 00 00       	call   8010502d <wakeup>
801043bc:	83 c4 10             	add    $0x10,%esp
  release(&p->lock);
801043bf:	8b 45 08             	mov    0x8(%ebp),%eax
801043c2:	83 ec 0c             	sub    $0xc,%esp
801043c5:	50                   	push   %eax
801043c6:	e8 e2 0e 00 00       	call   801052ad <release>
801043cb:	83 c4 10             	add    $0x10,%esp
  return i;
801043ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801043d1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801043d4:	c9                   	leave  
801043d5:	c3                   	ret    

801043d6 <readeflags>:
  asm volatile("ltr %0" : : "r" (sel));
}

static inline uint
readeflags(void)
{
801043d6:	55                   	push   %ebp
801043d7:	89 e5                	mov    %esp,%ebp
801043d9:	83 ec 10             	sub    $0x10,%esp
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801043dc:	9c                   	pushf  
801043dd:	58                   	pop    %eax
801043de:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return eflags;
801043e1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
801043e4:	c9                   	leave  
801043e5:	c3                   	ret    

801043e6 <sti>:
  asm volatile("cli");
}

static inline void
sti(void)
{
801043e6:	55                   	push   %ebp
801043e7:	89 e5                	mov    %esp,%ebp
  asm volatile("sti");
801043e9:	fb                   	sti    
}
801043ea:	5d                   	pop    %ebp
801043eb:	c3                   	ret    

801043ec <inifila>:
} fila;

static fila filaP;

// Inicializar fila de processos prontos
void inifila(fila* pfila, char* lockKey){
801043ec:	55                   	push   %ebp
801043ed:	89 e5                	mov    %esp,%ebp
801043ef:	83 ec 08             	sub    $0x8,%esp
  initlock(&pfila->lock, lockKey);
801043f2:	8b 45 08             	mov    0x8(%ebp),%eax
801043f5:	83 ec 08             	sub    $0x8,%esp
801043f8:	ff 75 0c             	pushl  0xc(%ebp)
801043fb:	50                   	push   %eax
801043fc:	e8 25 0e 00 00       	call   80105226 <initlock>
80104401:	83 c4 10             	add    $0x10,%esp
  pfila->inicio = 0;
80104404:	8b 45 08             	mov    0x8(%ebp),%eax
80104407:	c7 80 34 01 00 00 00 	movl   $0x0,0x134(%eax)
8010440e:	00 00 00 
  pfila->fim = -1;
80104411:	8b 45 08             	mov    0x8(%ebp),%eax
80104414:	c7 80 38 01 00 00 ff 	movl   $0xffffffff,0x138(%eax)
8010441b:	ff ff ff 
  pfila->num = 0;
8010441e:	8b 45 08             	mov    0x8(%ebp),%eax
80104421:	c7 80 3c 01 00 00 00 	movl   $0x0,0x13c(%eax)
80104428:	00 00 00 
}
8010442b:	c9                   	leave  
8010442c:	c3                   	ret    

8010442d <inserir>:

//Adiciona o processo que esta pronto no final da fila
void inserir(fila* pfila, struct proc * x){
8010442d:	55                   	push   %ebp
8010442e:	89 e5                	mov    %esp,%ebp
80104430:	83 ec 08             	sub    $0x8,%esp
    acquire(&pfila->lock);
80104433:	8b 45 08             	mov    0x8(%ebp),%eax
80104436:	83 ec 0c             	sub    $0xc,%esp
80104439:	50                   	push   %eax
8010443a:	e8 08 0e 00 00       	call   80105247 <acquire>
8010443f:	83 c4 10             	add    $0x10,%esp
    if (pfila->num < NPROC) {
80104442:	8b 45 08             	mov    0x8(%ebp),%eax
80104445:	8b 80 3c 01 00 00    	mov    0x13c(%eax),%eax
8010444b:	83 f8 3f             	cmp    $0x3f,%eax
8010444e:	7f 53                	jg     801044a3 <inserir+0x76>
        pfila->fim = (pfila->fim+1) % NPROC;
80104450:	8b 45 08             	mov    0x8(%ebp),%eax
80104453:	8b 80 38 01 00 00    	mov    0x138(%eax),%eax
80104459:	8d 50 01             	lea    0x1(%eax),%edx
8010445c:	89 d0                	mov    %edx,%eax
8010445e:	c1 f8 1f             	sar    $0x1f,%eax
80104461:	c1 e8 1a             	shr    $0x1a,%eax
80104464:	01 c2                	add    %eax,%edx
80104466:	83 e2 3f             	and    $0x3f,%edx
80104469:	29 c2                	sub    %eax,%edx
8010446b:	89 d0                	mov    %edx,%eax
8010446d:	89 c2                	mov    %eax,%edx
8010446f:	8b 45 08             	mov    0x8(%ebp),%eax
80104472:	89 90 38 01 00 00    	mov    %edx,0x138(%eax)
        pfila->vp[ pfila->fim ] = x;
80104478:	8b 45 08             	mov    0x8(%ebp),%eax
8010447b:	8b 90 38 01 00 00    	mov    0x138(%eax),%edx
80104481:	8b 45 08             	mov    0x8(%ebp),%eax
80104484:	8d 4a 0c             	lea    0xc(%edx),%ecx
80104487:	8b 55 0c             	mov    0xc(%ebp),%edx
8010448a:	89 54 88 04          	mov    %edx,0x4(%eax,%ecx,4)
        pfila->num = pfila->num + 1;
8010448e:	8b 45 08             	mov    0x8(%ebp),%eax
80104491:	8b 80 3c 01 00 00    	mov    0x13c(%eax),%eax
80104497:	8d 50 01             	lea    0x1(%eax),%edx
8010449a:	8b 45 08             	mov    0x8(%ebp),%eax
8010449d:	89 90 3c 01 00 00    	mov    %edx,0x13c(%eax)
    }
    release(&pfila->lock);
801044a3:	8b 45 08             	mov    0x8(%ebp),%eax
801044a6:	83 ec 0c             	sub    $0xc,%esp
801044a9:	50                   	push   %eax
801044aa:	e8 fe 0d 00 00       	call   801052ad <release>
801044af:	83 c4 10             	add    $0x10,%esp
}
801044b2:	c9                   	leave  
801044b3:	c3                   	ret    

801044b4 <remover>:

//Remove o primeiro processo da fila de prontos
struct proc * remover(fila* pfila){
801044b4:	55                   	push   %ebp
801044b5:	89 e5                	mov    %esp,%ebp
801044b7:	83 ec 18             	sub    $0x18,%esp
    acquire(&pfila->lock);
801044ba:	8b 45 08             	mov    0x8(%ebp),%eax
801044bd:	83 ec 0c             	sub    $0xc,%esp
801044c0:	50                   	push   %eax
801044c1:	e8 81 0d 00 00       	call   80105247 <acquire>
801044c6:	83 c4 10             	add    $0x10,%esp
    struct proc * x;
  if (pfila->num > 0) {
801044c9:	8b 45 08             	mov    0x8(%ebp),%eax
801044cc:	8b 80 3c 01 00 00    	mov    0x13c(%eax),%eax
801044d2:	85 c0                	test   %eax,%eax
801044d4:	0f 8e 98 00 00 00    	jle    80104572 <remover+0xbe>
    if(pfila->num == 1 || pfila->inicio == NPROC -1){
801044da:	8b 45 08             	mov    0x8(%ebp),%eax
801044dd:	8b 80 3c 01 00 00    	mov    0x13c(%eax),%eax
801044e3:	83 f8 01             	cmp    $0x1,%eax
801044e6:	74 0e                	je     801044f6 <remover+0x42>
801044e8:	8b 45 08             	mov    0x8(%ebp),%eax
801044eb:	8b 80 34 01 00 00    	mov    0x134(%eax),%eax
801044f1:	83 f8 3f             	cmp    $0x3f,%eax
801044f4:	75 29                	jne    8010451f <remover+0x6b>
      pfila->inicio = 0;
801044f6:	8b 45 08             	mov    0x8(%ebp),%eax
801044f9:	c7 80 34 01 00 00 00 	movl   $0x0,0x134(%eax)
80104500:	00 00 00 
      pfila->fim = -1;
80104503:	8b 45 08             	mov    0x8(%ebp),%eax
80104506:	c7 80 38 01 00 00 ff 	movl   $0xffffffff,0x138(%eax)
8010450d:	ff ff ff 
      pfila->num = 0;
80104510:	8b 45 08             	mov    0x8(%ebp),%eax
80104513:	c7 80 3c 01 00 00 00 	movl   $0x0,0x13c(%eax)
8010451a:	00 00 00 
8010451d:	eb 53                	jmp    80104572 <remover+0xbe>
    }else{
      x = pfila->vp[ pfila->inicio ];
8010451f:	8b 45 08             	mov    0x8(%ebp),%eax
80104522:	8b 90 34 01 00 00    	mov    0x134(%eax),%edx
80104528:	8b 45 08             	mov    0x8(%ebp),%eax
8010452b:	83 c2 0c             	add    $0xc,%edx
8010452e:	8b 44 90 04          	mov    0x4(%eax,%edx,4),%eax
80104532:	89 45 f4             	mov    %eax,-0xc(%ebp)
      pfila->inicio = (pfila->inicio+1) % NPROC;
80104535:	8b 45 08             	mov    0x8(%ebp),%eax
80104538:	8b 80 34 01 00 00    	mov    0x134(%eax),%eax
8010453e:	8d 50 01             	lea    0x1(%eax),%edx
80104541:	89 d0                	mov    %edx,%eax
80104543:	c1 f8 1f             	sar    $0x1f,%eax
80104546:	c1 e8 1a             	shr    $0x1a,%eax
80104549:	01 c2                	add    %eax,%edx
8010454b:	83 e2 3f             	and    $0x3f,%edx
8010454e:	29 c2                	sub    %eax,%edx
80104550:	89 d0                	mov    %edx,%eax
80104552:	89 c2                	mov    %eax,%edx
80104554:	8b 45 08             	mov    0x8(%ebp),%eax
80104557:	89 90 34 01 00 00    	mov    %edx,0x134(%eax)
      pfila->num = pfila->num - 1;
8010455d:	8b 45 08             	mov    0x8(%ebp),%eax
80104560:	8b 80 3c 01 00 00    	mov    0x13c(%eax),%eax
80104566:	8d 50 ff             	lea    -0x1(%eax),%edx
80104569:	8b 45 08             	mov    0x8(%ebp),%eax
8010456c:	89 90 3c 01 00 00    	mov    %edx,0x13c(%eax)
    }
   }
    release(&pfila->lock);
80104572:	8b 45 08             	mov    0x8(%ebp),%eax
80104575:	83 ec 0c             	sub    $0xc,%esp
80104578:	50                   	push   %eax
80104579:	e8 2f 0d 00 00       	call   801052ad <release>
8010457e:	83 c4 10             	add    $0x10,%esp
   
    return(x);
80104581:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80104584:	c9                   	leave  
80104585:	c3                   	ret    

80104586 <pinit>:


void
pinit(void)
{
80104586:	55                   	push   %ebp
80104587:	89 e5                	mov    %esp,%ebp
80104589:	83 ec 08             	sub    $0x8,%esp
  initlock(&ptable.lock, "ptable");  
8010458c:	83 ec 08             	sub    $0x8,%esp
8010458f:	68 6c 8a 10 80       	push   $0x80108a6c
80104594:	68 40 2c 11 80       	push   $0x80112c40
80104599:	e8 88 0c 00 00       	call   80105226 <initlock>
8010459e:	83 c4 10             	add    $0x10,%esp
  
  //Inicializar fila
  inifila(&filaP, "FCFS");
801045a1:	83 ec 08             	sub    $0x8,%esp
801045a4:	68 73 8a 10 80       	push   $0x80108a73
801045a9:	68 c0 b6 10 80       	push   $0x8010b6c0
801045ae:	e8 39 fe ff ff       	call   801043ec <inifila>
801045b3:	83 c4 10             	add    $0x10,%esp

}
801045b6:	c9                   	leave  
801045b7:	c3                   	ret    

801045b8 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
801045b8:	55                   	push   %ebp
801045b9:	89 e5                	mov    %esp,%ebp
801045bb:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
801045be:	83 ec 0c             	sub    $0xc,%esp
801045c1:	68 40 2c 11 80       	push   $0x80112c40
801045c6:	e8 7c 0c 00 00       	call   80105247 <acquire>
801045cb:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801045ce:	c7 45 f4 74 2c 11 80 	movl   $0x80112c74,-0xc(%ebp)
801045d5:	eb 60                	jmp    80104637 <allocproc+0x7f>
    if(p->state == UNUSED)
801045d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801045da:	8b 40 0c             	mov    0xc(%eax),%eax
801045dd:	85 c0                	test   %eax,%eax
801045df:	75 52                	jne    80104633 <allocproc+0x7b>
      goto found;
801045e1:	90                   	nop
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;  
801045e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801045e5:	c7 40 0c 01 00 00 00 	movl   $0x1,0xc(%eax)
  p->pid = nextpid++;
801045ec:	a1 04 b0 10 80       	mov    0x8010b004,%eax
801045f1:	8d 50 01             	lea    0x1(%eax),%edx
801045f4:	89 15 04 b0 10 80    	mov    %edx,0x8010b004
801045fa:	8b 55 f4             	mov    -0xc(%ebp),%edx
801045fd:	89 42 10             	mov    %eax,0x10(%edx)
  
  //Inicializar o cont do processo
  p->cont=0;
80104600:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104603:	c7 40 7c 00 00 00 00 	movl   $0x0,0x7c(%eax)

  release(&ptable.lock);
8010460a:	83 ec 0c             	sub    $0xc,%esp
8010460d:	68 40 2c 11 80       	push   $0x80112c40
80104612:	e8 96 0c 00 00       	call   801052ad <release>
80104617:	83 c4 10             	add    $0x10,%esp

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
8010461a:	e8 f5 e5 ff ff       	call   80102c14 <kalloc>
8010461f:	89 c2                	mov    %eax,%edx
80104621:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104624:	89 50 08             	mov    %edx,0x8(%eax)
80104627:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010462a:	8b 40 08             	mov    0x8(%eax),%eax
8010462d:	85 c0                	test   %eax,%eax
8010462f:	75 37                	jne    80104668 <allocproc+0xb0>
80104631:	eb 24                	jmp    80104657 <allocproc+0x9f>
{
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104633:	83 6d f4 80          	subl   $0xffffff80,-0xc(%ebp)
80104637:	81 7d f4 74 4c 11 80 	cmpl   $0x80114c74,-0xc(%ebp)
8010463e:	72 97                	jb     801045d7 <allocproc+0x1f>
    if(p->state == UNUSED)
      goto found;
  release(&ptable.lock);
80104640:	83 ec 0c             	sub    $0xc,%esp
80104643:	68 40 2c 11 80       	push   $0x80112c40
80104648:	e8 60 0c 00 00       	call   801052ad <release>
8010464d:	83 c4 10             	add    $0x10,%esp
  return 0;
80104650:	b8 00 00 00 00       	mov    $0x0,%eax
80104655:	eb 6e                	jmp    801046c5 <allocproc+0x10d>

  release(&ptable.lock);

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
    p->state = UNUSED;
80104657:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010465a:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    return 0;
80104661:	b8 00 00 00 00       	mov    $0x0,%eax
80104666:	eb 5d                	jmp    801046c5 <allocproc+0x10d>
  }
  sp = p->kstack + KSTACKSIZE;
80104668:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010466b:	8b 40 08             	mov    0x8(%eax),%eax
8010466e:	05 00 10 00 00       	add    $0x1000,%eax
80104673:	89 45 f0             	mov    %eax,-0x10(%ebp)
  
  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80104676:	83 6d f0 4c          	subl   $0x4c,-0x10(%ebp)
  p->tf = (struct trapframe*)sp;
8010467a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010467d:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104680:	89 50 18             	mov    %edx,0x18(%eax)
  
  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
80104683:	83 6d f0 04          	subl   $0x4,-0x10(%ebp)
  *(uint*)sp = (uint)trapret;
80104687:	ba 7f 68 10 80       	mov    $0x8010687f,%edx
8010468c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010468f:	89 10                	mov    %edx,(%eax)

  sp -= sizeof *p->context;
80104691:	83 6d f0 14          	subl   $0x14,-0x10(%ebp)
  p->context = (struct context*)sp;
80104695:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104698:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010469b:	89 50 1c             	mov    %edx,0x1c(%eax)
  memset(p->context, 0, sizeof *p->context);
8010469e:	8b 45 f4             	mov    -0xc(%ebp),%eax
801046a1:	8b 40 1c             	mov    0x1c(%eax),%eax
801046a4:	83 ec 04             	sub    $0x4,%esp
801046a7:	6a 14                	push   $0x14
801046a9:	6a 00                	push   $0x0
801046ab:	50                   	push   %eax
801046ac:	e8 f2 0d 00 00       	call   801054a3 <memset>
801046b1:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
801046b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801046b7:	8b 40 1c             	mov    0x1c(%eax),%eax
801046ba:	ba dc 4e 10 80       	mov    $0x80104edc,%edx
801046bf:	89 50 10             	mov    %edx,0x10(%eax)

  return p;
801046c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801046c5:	c9                   	leave  
801046c6:	c3                   	ret    

801046c7 <userinit>:

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
801046c7:	55                   	push   %ebp
801046c8:	89 e5                	mov    %esp,%ebp
801046ca:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];
  
  p = allocproc();
801046cd:	e8 e6 fe ff ff       	call   801045b8 <allocproc>
801046d2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  initproc = p;
801046d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801046d8:	a3 80 b6 10 80       	mov    %eax,0x8010b680
  if((p->pgdir = setupkvm()) == 0)
801046dd:	e8 2e 38 00 00       	call   80107f10 <setupkvm>
801046e2:	89 c2                	mov    %eax,%edx
801046e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801046e7:	89 50 04             	mov    %edx,0x4(%eax)
801046ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
801046ed:	8b 40 04             	mov    0x4(%eax),%eax
801046f0:	85 c0                	test   %eax,%eax
801046f2:	75 0d                	jne    80104701 <userinit+0x3a>
    panic("userinit: out of memory?");
801046f4:	83 ec 0c             	sub    $0xc,%esp
801046f7:	68 78 8a 10 80       	push   $0x80108a78
801046fc:	e8 5b be ff ff       	call   8010055c <panic>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80104701:	ba 2c 00 00 00       	mov    $0x2c,%edx
80104706:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104709:	8b 40 04             	mov    0x4(%eax),%eax
8010470c:	83 ec 04             	sub    $0x4,%esp
8010470f:	52                   	push   %edx
80104710:	68 00 b5 10 80       	push   $0x8010b500
80104715:	50                   	push   %eax
80104716:	e8 4c 3a 00 00       	call   80108167 <inituvm>
8010471b:	83 c4 10             	add    $0x10,%esp
  p->sz = PGSIZE;
8010471e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104721:	c7 00 00 10 00 00    	movl   $0x1000,(%eax)
  memset(p->tf, 0, sizeof(*p->tf));
80104727:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010472a:	8b 40 18             	mov    0x18(%eax),%eax
8010472d:	83 ec 04             	sub    $0x4,%esp
80104730:	6a 4c                	push   $0x4c
80104732:	6a 00                	push   $0x0
80104734:	50                   	push   %eax
80104735:	e8 69 0d 00 00       	call   801054a3 <memset>
8010473a:	83 c4 10             	add    $0x10,%esp
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010473d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104740:	8b 40 18             	mov    0x18(%eax),%eax
80104743:	66 c7 40 3c 23 00    	movw   $0x23,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80104749:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010474c:	8b 40 18             	mov    0x18(%eax),%eax
8010474f:	66 c7 40 2c 2b 00    	movw   $0x2b,0x2c(%eax)
  p->tf->es = p->tf->ds;
80104755:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104758:	8b 40 18             	mov    0x18(%eax),%eax
8010475b:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010475e:	8b 52 18             	mov    0x18(%edx),%edx
80104761:	0f b7 52 2c          	movzwl 0x2c(%edx),%edx
80104765:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80104769:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010476c:	8b 40 18             	mov    0x18(%eax),%eax
8010476f:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104772:	8b 52 18             	mov    0x18(%edx),%edx
80104775:	0f b7 52 2c          	movzwl 0x2c(%edx),%edx
80104779:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
8010477d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104780:	8b 40 18             	mov    0x18(%eax),%eax
80104783:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
8010478a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010478d:	8b 40 18             	mov    0x18(%eax),%eax
80104790:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80104797:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010479a:	8b 40 18             	mov    0x18(%eax),%eax
8010479d:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)

  safestrcpy(p->name, "initcode", sizeof(p->name));
801047a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801047a7:	83 c0 6c             	add    $0x6c,%eax
801047aa:	83 ec 04             	sub    $0x4,%esp
801047ad:	6a 10                	push   $0x10
801047af:	68 91 8a 10 80       	push   $0x80108a91
801047b4:	50                   	push   %eax
801047b5:	e8 ee 0e 00 00       	call   801056a8 <safestrcpy>
801047ba:	83 c4 10             	add    $0x10,%esp
  p->cwd = namei("/");
801047bd:	83 ec 0c             	sub    $0xc,%esp
801047c0:	68 9a 8a 10 80       	push   $0x80108a9a
801047c5:	e8 1a dd ff ff       	call   801024e4 <namei>
801047ca:	83 c4 10             	add    $0x10,%esp
801047cd:	89 c2                	mov    %eax,%edx
801047cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
801047d2:	89 50 68             	mov    %edx,0x68(%eax)

  p->state = RUNNABLE;
801047d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801047d8:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  
  //Adiciona na fila de Prontos
  inserir(&filaP, p);
801047df:	83 ec 08             	sub    $0x8,%esp
801047e2:	ff 75 f4             	pushl  -0xc(%ebp)
801047e5:	68 c0 b6 10 80       	push   $0x8010b6c0
801047ea:	e8 3e fc ff ff       	call   8010442d <inserir>
801047ef:	83 c4 10             	add    $0x10,%esp
}
801047f2:	c9                   	leave  
801047f3:	c3                   	ret    

801047f4 <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
801047f4:	55                   	push   %ebp
801047f5:	89 e5                	mov    %esp,%ebp
801047f7:	83 ec 18             	sub    $0x18,%esp
  uint sz;
  
  sz = proc->sz;
801047fa:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104800:	8b 00                	mov    (%eax),%eax
80104802:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(n > 0){
80104805:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80104809:	7e 31                	jle    8010483c <growproc+0x48>
    if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0)
8010480b:	8b 55 08             	mov    0x8(%ebp),%edx
8010480e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104811:	01 c2                	add    %eax,%edx
80104813:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104819:	8b 40 04             	mov    0x4(%eax),%eax
8010481c:	83 ec 04             	sub    $0x4,%esp
8010481f:	52                   	push   %edx
80104820:	ff 75 f4             	pushl  -0xc(%ebp)
80104823:	50                   	push   %eax
80104824:	e8 8a 3a 00 00       	call   801082b3 <allocuvm>
80104829:	83 c4 10             	add    $0x10,%esp
8010482c:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010482f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80104833:	75 3e                	jne    80104873 <growproc+0x7f>
      return -1;
80104835:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010483a:	eb 59                	jmp    80104895 <growproc+0xa1>
  } else if(n < 0){
8010483c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80104840:	79 31                	jns    80104873 <growproc+0x7f>
    if((sz = deallocuvm(proc->pgdir, sz, sz + n)) == 0)
80104842:	8b 55 08             	mov    0x8(%ebp),%edx
80104845:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104848:	01 c2                	add    %eax,%edx
8010484a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104850:	8b 40 04             	mov    0x4(%eax),%eax
80104853:	83 ec 04             	sub    $0x4,%esp
80104856:	52                   	push   %edx
80104857:	ff 75 f4             	pushl  -0xc(%ebp)
8010485a:	50                   	push   %eax
8010485b:	e8 1c 3b 00 00       	call   8010837c <deallocuvm>
80104860:	83 c4 10             	add    $0x10,%esp
80104863:	89 45 f4             	mov    %eax,-0xc(%ebp)
80104866:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010486a:	75 07                	jne    80104873 <growproc+0x7f>
      return -1;
8010486c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104871:	eb 22                	jmp    80104895 <growproc+0xa1>
  }
  proc->sz = sz;
80104873:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104879:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010487c:	89 10                	mov    %edx,(%eax)
  switchuvm(proc);
8010487e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104884:	83 ec 0c             	sub    $0xc,%esp
80104887:	50                   	push   %eax
80104888:	e8 68 37 00 00       	call   80107ff5 <switchuvm>
8010488d:	83 c4 10             	add    $0x10,%esp
  return 0;
80104890:	b8 00 00 00 00       	mov    $0x0,%eax
}
80104895:	c9                   	leave  
80104896:	c3                   	ret    

80104897 <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
80104897:	55                   	push   %ebp
80104898:	89 e5                	mov    %esp,%ebp
8010489a:	57                   	push   %edi
8010489b:	56                   	push   %esi
8010489c:	53                   	push   %ebx
8010489d:	83 ec 1c             	sub    $0x1c,%esp
  int i, pid;
  struct proc *np;

  // Allocate process.
  if((np = allocproc()) == 0)
801048a0:	e8 13 fd ff ff       	call   801045b8 <allocproc>
801048a5:	89 45 e0             	mov    %eax,-0x20(%ebp)
801048a8:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
801048ac:	75 0a                	jne    801048b8 <fork+0x21>
    return -1;
801048ae:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801048b3:	e9 b2 01 00 00       	jmp    80104a6a <fork+0x1d3>

  // Copy process state from p.
  if((np->pgdir = copyuvm(proc->pgdir, proc->sz)) == 0){
801048b8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801048be:	8b 10                	mov    (%eax),%edx
801048c0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801048c6:	8b 40 04             	mov    0x4(%eax),%eax
801048c9:	83 ec 08             	sub    $0x8,%esp
801048cc:	52                   	push   %edx
801048cd:	50                   	push   %eax
801048ce:	e8 45 3c 00 00       	call   80108518 <copyuvm>
801048d3:	83 c4 10             	add    $0x10,%esp
801048d6:	89 c2                	mov    %eax,%edx
801048d8:	8b 45 e0             	mov    -0x20(%ebp),%eax
801048db:	89 50 04             	mov    %edx,0x4(%eax)
801048de:	8b 45 e0             	mov    -0x20(%ebp),%eax
801048e1:	8b 40 04             	mov    0x4(%eax),%eax
801048e4:	85 c0                	test   %eax,%eax
801048e6:	75 30                	jne    80104918 <fork+0x81>
    kfree(np->kstack);
801048e8:	8b 45 e0             	mov    -0x20(%ebp),%eax
801048eb:	8b 40 08             	mov    0x8(%eax),%eax
801048ee:	83 ec 0c             	sub    $0xc,%esp
801048f1:	50                   	push   %eax
801048f2:	e8 81 e2 ff ff       	call   80102b78 <kfree>
801048f7:	83 c4 10             	add    $0x10,%esp
    np->kstack = 0;
801048fa:	8b 45 e0             	mov    -0x20(%ebp),%eax
801048fd:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
    np->state = UNUSED;
80104904:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104907:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    return -1;
8010490e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104913:	e9 52 01 00 00       	jmp    80104a6a <fork+0x1d3>
  }
  np->sz = proc->sz;
80104918:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010491e:	8b 10                	mov    (%eax),%edx
80104920:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104923:	89 10                	mov    %edx,(%eax)
  np->parent = proc;
80104925:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
8010492c:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010492f:	89 50 14             	mov    %edx,0x14(%eax)
  *np->tf = *proc->tf;
80104932:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104935:	8b 50 18             	mov    0x18(%eax),%edx
80104938:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010493e:	8b 40 18             	mov    0x18(%eax),%eax
80104941:	89 c3                	mov    %eax,%ebx
80104943:	b8 13 00 00 00       	mov    $0x13,%eax
80104948:	89 d7                	mov    %edx,%edi
8010494a:	89 de                	mov    %ebx,%esi
8010494c:	89 c1                	mov    %eax,%ecx
8010494e:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;
80104950:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104953:	8b 40 18             	mov    0x18(%eax),%eax
80104956:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)

  for(i = 0; i < NOFILE; i++)
8010495d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80104964:	eb 43                	jmp    801049a9 <fork+0x112>
    if(proc->ofile[i])
80104966:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010496c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010496f:	83 c2 08             	add    $0x8,%edx
80104972:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80104976:	85 c0                	test   %eax,%eax
80104978:	74 2b                	je     801049a5 <fork+0x10e>
      np->ofile[i] = filedup(proc->ofile[i]);
8010497a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104980:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80104983:	83 c2 08             	add    $0x8,%edx
80104986:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
8010498a:	83 ec 0c             	sub    $0xc,%esp
8010498d:	50                   	push   %eax
8010498e:	e8 34 c6 ff ff       	call   80100fc7 <filedup>
80104993:	83 c4 10             	add    $0x10,%esp
80104996:	89 c1                	mov    %eax,%ecx
80104998:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010499b:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010499e:	83 c2 08             	add    $0x8,%edx
801049a1:	89 4c 90 08          	mov    %ecx,0x8(%eax,%edx,4)
  *np->tf = *proc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
801049a5:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
801049a9:	83 7d e4 0f          	cmpl   $0xf,-0x1c(%ebp)
801049ad:	7e b7                	jle    80104966 <fork+0xcf>
    if(proc->ofile[i])
      np->ofile[i] = filedup(proc->ofile[i]);
  np->cwd = idup(proc->cwd);
801049af:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801049b5:	8b 40 68             	mov    0x68(%eax),%eax
801049b8:	83 ec 0c             	sub    $0xc,%esp
801049bb:	50                   	push   %eax
801049bc:	e8 2e cf ff ff       	call   801018ef <idup>
801049c1:	83 c4 10             	add    $0x10,%esp
801049c4:	89 c2                	mov    %eax,%edx
801049c6:	8b 45 e0             	mov    -0x20(%ebp),%eax
801049c9:	89 50 68             	mov    %edx,0x68(%eax)

  safestrcpy(np->name, proc->name, sizeof(proc->name));
801049cc:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801049d2:	8d 50 6c             	lea    0x6c(%eax),%edx
801049d5:	8b 45 e0             	mov    -0x20(%ebp),%eax
801049d8:	83 c0 6c             	add    $0x6c,%eax
801049db:	83 ec 04             	sub    $0x4,%esp
801049de:	6a 10                	push   $0x10
801049e0:	52                   	push   %edx
801049e1:	50                   	push   %eax
801049e2:	e8 c1 0c 00 00       	call   801056a8 <safestrcpy>
801049e7:	83 c4 10             	add    $0x10,%esp
 
  pid = np->pid;  
801049ea:	8b 45 e0             	mov    -0x20(%ebp),%eax
801049ed:	8b 40 10             	mov    0x10(%eax),%eax
801049f0:	89 45 dc             	mov    %eax,-0x24(%ebp)
  
  // lock to force the compiler to emit the np->state write last.
  acquire(&ptable.lock);
801049f3:	83 ec 0c             	sub    $0xc,%esp
801049f6:	68 40 2c 11 80       	push   $0x80112c40
801049fb:	e8 47 08 00 00       	call   80105247 <acquire>
80104a00:	83 c4 10             	add    $0x10,%esp
  np->state = RUNNABLE;
80104a03:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104a06:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  
  //Adiciona o processo na fila de Prontos
  inserir(&filaP, np);
80104a0d:	83 ec 08             	sub    $0x8,%esp
80104a10:	ff 75 e0             	pushl  -0x20(%ebp)
80104a13:	68 c0 b6 10 80       	push   $0x8010b6c0
80104a18:	e8 10 fa ff ff       	call   8010442d <inserir>
80104a1d:	83 c4 10             	add    $0x10,%esp
  cprintf("CRIOU... Nome:%s Pid:%d \n",filaP.vp[filaP.fim]->name, filaP.vp[filaP.fim]->pid);
80104a20:	a1 f8 b7 10 80       	mov    0x8010b7f8,%eax
80104a25:	83 c0 0c             	add    $0xc,%eax
80104a28:	8b 04 85 c4 b6 10 80 	mov    -0x7fef493c(,%eax,4),%eax
80104a2f:	8b 40 10             	mov    0x10(%eax),%eax
80104a32:	8b 15 f8 b7 10 80    	mov    0x8010b7f8,%edx
80104a38:	83 c2 0c             	add    $0xc,%edx
80104a3b:	8b 14 95 c4 b6 10 80 	mov    -0x7fef493c(,%edx,4),%edx
80104a42:	83 c2 6c             	add    $0x6c,%edx
80104a45:	83 ec 04             	sub    $0x4,%esp
80104a48:	50                   	push   %eax
80104a49:	52                   	push   %edx
80104a4a:	68 9c 8a 10 80       	push   $0x80108a9c
80104a4f:	e8 6b b9 ff ff       	call   801003bf <cprintf>
80104a54:	83 c4 10             	add    $0x10,%esp
  
  release(&ptable.lock);
80104a57:	83 ec 0c             	sub    $0xc,%esp
80104a5a:	68 40 2c 11 80       	push   $0x80112c40
80104a5f:	e8 49 08 00 00       	call   801052ad <release>
80104a64:	83 c4 10             	add    $0x10,%esp
  return pid;
80104a67:	8b 45 dc             	mov    -0x24(%ebp),%eax
}
80104a6a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104a6d:	5b                   	pop    %ebx
80104a6e:	5e                   	pop    %esi
80104a6f:	5f                   	pop    %edi
80104a70:	5d                   	pop    %ebp
80104a71:	c3                   	ret    

80104a72 <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
80104a72:	55                   	push   %ebp
80104a73:	89 e5                	mov    %esp,%ebp
80104a75:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  int fd;

  if(proc == initproc)
80104a78:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104a7f:	a1 80 b6 10 80       	mov    0x8010b680,%eax
80104a84:	39 c2                	cmp    %eax,%edx
80104a86:	75 0d                	jne    80104a95 <exit+0x23>
    panic("init exiting");
80104a88:	83 ec 0c             	sub    $0xc,%esp
80104a8b:	68 b6 8a 10 80       	push   $0x80108ab6
80104a90:	e8 c7 ba ff ff       	call   8010055c <panic>

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
80104a95:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
80104a9c:	eb 48                	jmp    80104ae6 <exit+0x74>
    if(proc->ofile[fd]){
80104a9e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104aa4:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104aa7:	83 c2 08             	add    $0x8,%edx
80104aaa:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80104aae:	85 c0                	test   %eax,%eax
80104ab0:	74 30                	je     80104ae2 <exit+0x70>
      fileclose(proc->ofile[fd]);
80104ab2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104ab8:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104abb:	83 c2 08             	add    $0x8,%edx
80104abe:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80104ac2:	83 ec 0c             	sub    $0xc,%esp
80104ac5:	50                   	push   %eax
80104ac6:	e8 4d c5 ff ff       	call   80101018 <fileclose>
80104acb:	83 c4 10             	add    $0x10,%esp
      proc->ofile[fd] = 0;
80104ace:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104ad4:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104ad7:	83 c2 08             	add    $0x8,%edx
80104ada:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
80104ae1:	00 

  if(proc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
80104ae2:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
80104ae6:	83 7d f0 0f          	cmpl   $0xf,-0x10(%ebp)
80104aea:	7e b2                	jle    80104a9e <exit+0x2c>
      fileclose(proc->ofile[fd]);
      proc->ofile[fd] = 0;
    }
  }

  begin_op();
80104aec:	e8 fc e9 ff ff       	call   801034ed <begin_op>
  iput(proc->cwd);
80104af1:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104af7:	8b 40 68             	mov    0x68(%eax),%eax
80104afa:	83 ec 0c             	sub    $0xc,%esp
80104afd:	50                   	push   %eax
80104afe:	e8 f4 cf ff ff       	call   80101af7 <iput>
80104b03:	83 c4 10             	add    $0x10,%esp
  end_op();
80104b06:	e8 70 ea ff ff       	call   8010357b <end_op>
  proc->cwd = 0;
80104b0b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104b11:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%eax)

  acquire(&ptable.lock);
80104b18:	83 ec 0c             	sub    $0xc,%esp
80104b1b:	68 40 2c 11 80       	push   $0x80112c40
80104b20:	e8 22 07 00 00       	call   80105247 <acquire>
80104b25:	83 c4 10             	add    $0x10,%esp

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);
80104b28:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104b2e:	8b 40 14             	mov    0x14(%eax),%eax
80104b31:	83 ec 0c             	sub    $0xc,%esp
80104b34:	50                   	push   %eax
80104b35:	e8 a2 04 00 00       	call   80104fdc <wakeup1>
80104b3a:	83 c4 10             	add    $0x10,%esp

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104b3d:	c7 45 f4 74 2c 11 80 	movl   $0x80112c74,-0xc(%ebp)
80104b44:	eb 3c                	jmp    80104b82 <exit+0x110>
    if(p->parent == proc){
80104b46:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b49:	8b 50 14             	mov    0x14(%eax),%edx
80104b4c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104b52:	39 c2                	cmp    %eax,%edx
80104b54:	75 28                	jne    80104b7e <exit+0x10c>
      p->parent = initproc;
80104b56:	8b 15 80 b6 10 80    	mov    0x8010b680,%edx
80104b5c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b5f:	89 50 14             	mov    %edx,0x14(%eax)
      if(p->state == ZOMBIE)
80104b62:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b65:	8b 40 0c             	mov    0xc(%eax),%eax
80104b68:	83 f8 05             	cmp    $0x5,%eax
80104b6b:	75 11                	jne    80104b7e <exit+0x10c>
        wakeup1(initproc);
80104b6d:	a1 80 b6 10 80       	mov    0x8010b680,%eax
80104b72:	83 ec 0c             	sub    $0xc,%esp
80104b75:	50                   	push   %eax
80104b76:	e8 61 04 00 00       	call   80104fdc <wakeup1>
80104b7b:	83 c4 10             	add    $0x10,%esp

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104b7e:	83 6d f4 80          	subl   $0xffffff80,-0xc(%ebp)
80104b82:	81 7d f4 74 4c 11 80 	cmpl   $0x80114c74,-0xc(%ebp)
80104b89:	72 bb                	jb     80104b46 <exit+0xd4>
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  proc->state = ZOMBIE;
80104b8b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104b91:	c7 40 0c 05 00 00 00 	movl   $0x5,0xc(%eax)

        
  sched();
80104b98:	e8 33 02 00 00       	call   80104dd0 <sched>
  panic("zombie exit");
80104b9d:	83 ec 0c             	sub    $0xc,%esp
80104ba0:	68 c3 8a 10 80       	push   $0x80108ac3
80104ba5:	e8 b2 b9 ff ff       	call   8010055c <panic>

80104baa <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
80104baa:	55                   	push   %ebp
80104bab:	89 e5                	mov    %esp,%ebp
80104bad:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  int havekids, pid;

  acquire(&ptable.lock);
80104bb0:	83 ec 0c             	sub    $0xc,%esp
80104bb3:	68 40 2c 11 80       	push   $0x80112c40
80104bb8:	e8 8a 06 00 00       	call   80105247 <acquire>
80104bbd:	83 c4 10             	add    $0x10,%esp
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
80104bc0:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104bc7:	c7 45 f4 74 2c 11 80 	movl   $0x80112c74,-0xc(%ebp)
80104bce:	e9 cc 00 00 00       	jmp    80104c9f <wait+0xf5>
      if(p->parent != proc)
80104bd3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104bd6:	8b 50 14             	mov    0x14(%eax),%edx
80104bd9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104bdf:	39 c2                	cmp    %eax,%edx
80104be1:	74 05                	je     80104be8 <wait+0x3e>
        continue;
80104be3:	e9 b3 00 00 00       	jmp    80104c9b <wait+0xf1>
      havekids = 1;
80104be8:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
      if(p->state == ZOMBIE){
80104bef:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104bf2:	8b 40 0c             	mov    0xc(%eax),%eax
80104bf5:	83 f8 05             	cmp    $0x5,%eax
80104bf8:	0f 85 9d 00 00 00    	jne    80104c9b <wait+0xf1>
      //MOSTRAR QUE O PROCESSO TERMINOU
        cprintf("TERMINOU... Nome:%s Pid:%d TimesOnCpu:%d\n",p->name, p->pid, p->cont);
80104bfe:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104c01:	8b 50 7c             	mov    0x7c(%eax),%edx
80104c04:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104c07:	8b 40 10             	mov    0x10(%eax),%eax
80104c0a:	8b 4d f4             	mov    -0xc(%ebp),%ecx
80104c0d:	83 c1 6c             	add    $0x6c,%ecx
80104c10:	52                   	push   %edx
80104c11:	50                   	push   %eax
80104c12:	51                   	push   %ecx
80104c13:	68 d0 8a 10 80       	push   $0x80108ad0
80104c18:	e8 a2 b7 ff ff       	call   801003bf <cprintf>
80104c1d:	83 c4 10             	add    $0x10,%esp
        
        // Found one.
        pid = p->pid;
80104c20:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104c23:	8b 40 10             	mov    0x10(%eax),%eax
80104c26:	89 45 ec             	mov    %eax,-0x14(%ebp)
        kfree(p->kstack);
80104c29:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104c2c:	8b 40 08             	mov    0x8(%eax),%eax
80104c2f:	83 ec 0c             	sub    $0xc,%esp
80104c32:	50                   	push   %eax
80104c33:	e8 40 df ff ff       	call   80102b78 <kfree>
80104c38:	83 c4 10             	add    $0x10,%esp
        p->kstack = 0;
80104c3b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104c3e:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
        freevm(p->pgdir);
80104c45:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104c48:	8b 40 04             	mov    0x4(%eax),%eax
80104c4b:	83 ec 0c             	sub    $0xc,%esp
80104c4e:	50                   	push   %eax
80104c4f:	e8 e5 37 00 00       	call   80108439 <freevm>
80104c54:	83 c4 10             	add    $0x10,%esp
        p->state = UNUSED;
80104c57:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104c5a:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
        p->pid = 0;
80104c61:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104c64:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
        p->parent = 0;
80104c6b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104c6e:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        p->name[0] = 0;
80104c75:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104c78:	c6 40 6c 00          	movb   $0x0,0x6c(%eax)
        p->killed = 0;        
80104c7c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104c7f:	c7 40 24 00 00 00 00 	movl   $0x0,0x24(%eax)
        release(&ptable.lock);
80104c86:	83 ec 0c             	sub    $0xc,%esp
80104c89:	68 40 2c 11 80       	push   $0x80112c40
80104c8e:	e8 1a 06 00 00       	call   801052ad <release>
80104c93:	83 c4 10             	add    $0x10,%esp
        return pid;
80104c96:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104c99:	eb 57                	jmp    80104cf2 <wait+0x148>

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104c9b:	83 6d f4 80          	subl   $0xffffff80,-0xc(%ebp)
80104c9f:	81 7d f4 74 4c 11 80 	cmpl   $0x80114c74,-0xc(%ebp)
80104ca6:	0f 82 27 ff ff ff    	jb     80104bd3 <wait+0x29>
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
80104cac:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80104cb0:	74 0d                	je     80104cbf <wait+0x115>
80104cb2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104cb8:	8b 40 24             	mov    0x24(%eax),%eax
80104cbb:	85 c0                	test   %eax,%eax
80104cbd:	74 17                	je     80104cd6 <wait+0x12c>
      release(&ptable.lock);
80104cbf:	83 ec 0c             	sub    $0xc,%esp
80104cc2:	68 40 2c 11 80       	push   $0x80112c40
80104cc7:	e8 e1 05 00 00       	call   801052ad <release>
80104ccc:	83 c4 10             	add    $0x10,%esp
      return -1;
80104ccf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104cd4:	eb 1c                	jmp    80104cf2 <wait+0x148>
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
80104cd6:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104cdc:	83 ec 08             	sub    $0x8,%esp
80104cdf:	68 40 2c 11 80       	push   $0x80112c40
80104ce4:	50                   	push   %eax
80104ce5:	e8 37 02 00 00       	call   80104f21 <sleep>
80104cea:	83 c4 10             	add    $0x10,%esp
  }
80104ced:	e9 ce fe ff ff       	jmp    80104bc0 <wait+0x16>
}
80104cf2:	c9                   	leave  
80104cf3:	c3                   	ret    

80104cf4 <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
80104cf4:	55                   	push   %ebp
80104cf5:	89 e5                	mov    %esp,%ebp
80104cf7:	83 ec 18             	sub    $0x18,%esp
  
  struct proc *p;

  for(;;){
    // Enable interrupts on this processor.
    sti();
80104cfa:	e8 e7 f6 ff ff       	call   801043e6 <sti>
    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80104cff:	83 ec 0c             	sub    $0xc,%esp
80104d02:	68 40 2c 11 80       	push   $0x80112c40
80104d07:	e8 3b 05 00 00       	call   80105247 <acquire>
80104d0c:	83 c4 10             	add    $0x10,%esp
    
    //Remove da fila de prontos
   if(filaP.num > 0) {
80104d0f:	a1 fc b7 10 80       	mov    0x8010b7fc,%eax
80104d14:	85 c0                	test   %eax,%eax
80104d16:	7e 22                	jle    80104d3a <scheduler+0x46>
     p = filaP.vp[filaP.inicio];
80104d18:	a1 f4 b7 10 80       	mov    0x8010b7f4,%eax
80104d1d:	83 c0 0c             	add    $0xc,%eax
80104d20:	8b 04 85 c4 b6 10 80 	mov    -0x7fef493c(,%eax,4),%eax
80104d27:	89 45 f4             	mov    %eax,-0xc(%ebp)
     remover(&filaP);
80104d2a:	83 ec 0c             	sub    $0xc,%esp
80104d2d:	68 c0 b6 10 80       	push   $0x8010b6c0
80104d32:	e8 7d f7 ff ff       	call   801044b4 <remover>
80104d37:	83 c4 10             	add    $0x10,%esp
   }
    
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104d3a:	c7 45 f4 74 2c 11 80 	movl   $0x80112c74,-0xc(%ebp)
80104d41:	eb 64                	jmp    80104da7 <scheduler+0xb3>
       if(p->state == RUNNABLE){
80104d43:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104d46:	8b 40 0c             	mov    0xc(%eax),%eax
80104d49:	83 f8 03             	cmp    $0x3,%eax
80104d4c:	75 55                	jne    80104da3 <scheduler+0xaf>
        // Switch to chosen process.  It is the process's job
        // to release ptable.lock and then reacquire it
        // before jumping back to us.
        proc = p;
80104d4e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104d51:	65 a3 04 00 00 00    	mov    %eax,%gs:0x4
        switchuvm(p);
80104d57:	83 ec 0c             	sub    $0xc,%esp
80104d5a:	ff 75 f4             	pushl  -0xc(%ebp)
80104d5d:	e8 93 32 00 00       	call   80107ff5 <switchuvm>
80104d62:	83 c4 10             	add    $0x10,%esp
        p->state = RUNNING;
80104d65:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104d68:	c7 40 0c 04 00 00 00 	movl   $0x4,0xc(%eax)
        p->cont++;
80104d6f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104d72:	8b 40 7c             	mov    0x7c(%eax),%eax
80104d75:	8d 50 01             	lea    0x1(%eax),%edx
80104d78:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104d7b:	89 50 7c             	mov    %edx,0x7c(%eax)
        swtch(&cpu->scheduler, proc->context);
80104d7e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104d84:	8b 40 1c             	mov    0x1c(%eax),%eax
80104d87:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80104d8e:	83 c2 04             	add    $0x4,%edx
80104d91:	83 ec 08             	sub    $0x8,%esp
80104d94:	50                   	push   %eax
80104d95:	52                   	push   %edx
80104d96:	e8 7e 09 00 00       	call   80105719 <swtch>
80104d9b:	83 c4 10             	add    $0x10,%esp
        switchkvm();
80104d9e:	e8 36 32 00 00       	call   80107fd9 <switchkvm>
   if(filaP.num > 0) {
     p = filaP.vp[filaP.inicio];
     remover(&filaP);
   }
    
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104da3:	83 6d f4 80          	subl   $0xffffff80,-0xc(%ebp)
80104da7:	81 7d f4 74 4c 11 80 	cmpl   $0x80114c74,-0xc(%ebp)
80104dae:	72 93                	jb     80104d43 <scheduler+0x4f>
      }
      }
      
      // Process is done running for now.
    // It should have changed its p->state before coming back.
    proc = 0;
80104db0:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
80104db7:	00 00 00 00 

     release(&ptable.lock);  
80104dbb:	83 ec 0c             	sub    $0xc,%esp
80104dbe:	68 40 2c 11 80       	push   $0x80112c40
80104dc3:	e8 e5 04 00 00       	call   801052ad <release>
80104dc8:	83 c4 10             	add    $0x10,%esp

   }
80104dcb:	e9 2a ff ff ff       	jmp    80104cfa <scheduler+0x6>

80104dd0 <sched>:

// Enter scheduler.  Must hold only ptable.lock
// and have changed proc->state.
void
sched(void)
{
80104dd0:	55                   	push   %ebp
80104dd1:	89 e5                	mov    %esp,%ebp
80104dd3:	83 ec 18             	sub    $0x18,%esp
  int intena;

  if(!holding(&ptable.lock))
80104dd6:	83 ec 0c             	sub    $0xc,%esp
80104dd9:	68 40 2c 11 80       	push   $0x80112c40
80104dde:	e8 94 05 00 00       	call   80105377 <holding>
80104de3:	83 c4 10             	add    $0x10,%esp
80104de6:	85 c0                	test   %eax,%eax
80104de8:	75 0d                	jne    80104df7 <sched+0x27>
    panic("sched ptable.lock");
80104dea:	83 ec 0c             	sub    $0xc,%esp
80104ded:	68 fa 8a 10 80       	push   $0x80108afa
80104df2:	e8 65 b7 ff ff       	call   8010055c <panic>
  if(cpu->ncli != 1)
80104df7:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104dfd:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
80104e03:	83 f8 01             	cmp    $0x1,%eax
80104e06:	74 0d                	je     80104e15 <sched+0x45>
    panic("sched locks");
80104e08:	83 ec 0c             	sub    $0xc,%esp
80104e0b:	68 0c 8b 10 80       	push   $0x80108b0c
80104e10:	e8 47 b7 ff ff       	call   8010055c <panic>
  if(proc->state == RUNNING)
80104e15:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104e1b:	8b 40 0c             	mov    0xc(%eax),%eax
80104e1e:	83 f8 04             	cmp    $0x4,%eax
80104e21:	75 0d                	jne    80104e30 <sched+0x60>
    panic("sched running");
80104e23:	83 ec 0c             	sub    $0xc,%esp
80104e26:	68 18 8b 10 80       	push   $0x80108b18
80104e2b:	e8 2c b7 ff ff       	call   8010055c <panic>
  if(readeflags()&FL_IF)
80104e30:	e8 a1 f5 ff ff       	call   801043d6 <readeflags>
80104e35:	25 00 02 00 00       	and    $0x200,%eax
80104e3a:	85 c0                	test   %eax,%eax
80104e3c:	74 0d                	je     80104e4b <sched+0x7b>
    panic("sched interruptible");
80104e3e:	83 ec 0c             	sub    $0xc,%esp
80104e41:	68 26 8b 10 80       	push   $0x80108b26
80104e46:	e8 11 b7 ff ff       	call   8010055c <panic>
  intena = cpu->intena;
80104e4b:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104e51:	8b 80 b0 00 00 00    	mov    0xb0(%eax),%eax
80104e57:	89 45 f4             	mov    %eax,-0xc(%ebp)
  swtch(&proc->context, cpu->scheduler);
80104e5a:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104e60:	8b 40 04             	mov    0x4(%eax),%eax
80104e63:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104e6a:	83 c2 1c             	add    $0x1c,%edx
80104e6d:	83 ec 08             	sub    $0x8,%esp
80104e70:	50                   	push   %eax
80104e71:	52                   	push   %edx
80104e72:	e8 a2 08 00 00       	call   80105719 <swtch>
80104e77:	83 c4 10             	add    $0x10,%esp
  cpu->intena = intena;
80104e7a:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104e80:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104e83:	89 90 b0 00 00 00    	mov    %edx,0xb0(%eax)
}
80104e89:	c9                   	leave  
80104e8a:	c3                   	ret    

80104e8b <yield>:

// Give up the CPU for one scheduling round.
void
yield(void)
{
80104e8b:	55                   	push   %ebp
80104e8c:	89 e5                	mov    %esp,%ebp
80104e8e:	83 ec 08             	sub    $0x8,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80104e91:	83 ec 0c             	sub    $0xc,%esp
80104e94:	68 40 2c 11 80       	push   $0x80112c40
80104e99:	e8 a9 03 00 00       	call   80105247 <acquire>
80104e9e:	83 c4 10             	add    $0x10,%esp
  proc->state = RUNNABLE;
80104ea1:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104ea7:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  
  //Adiciona na fila de Prontos de prontos
  inserir(&filaP, proc);
80104eae:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104eb4:	83 ec 08             	sub    $0x8,%esp
80104eb7:	50                   	push   %eax
80104eb8:	68 c0 b6 10 80       	push   $0x8010b6c0
80104ebd:	e8 6b f5 ff ff       	call   8010442d <inserir>
80104ec2:	83 c4 10             	add    $0x10,%esp
  
  sched();
80104ec5:	e8 06 ff ff ff       	call   80104dd0 <sched>
  release(&ptable.lock);
80104eca:	83 ec 0c             	sub    $0xc,%esp
80104ecd:	68 40 2c 11 80       	push   $0x80112c40
80104ed2:	e8 d6 03 00 00       	call   801052ad <release>
80104ed7:	83 c4 10             	add    $0x10,%esp
}
80104eda:	c9                   	leave  
80104edb:	c3                   	ret    

80104edc <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80104edc:	55                   	push   %ebp
80104edd:	89 e5                	mov    %esp,%ebp
80104edf:	83 ec 08             	sub    $0x8,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80104ee2:	83 ec 0c             	sub    $0xc,%esp
80104ee5:	68 40 2c 11 80       	push   $0x80112c40
80104eea:	e8 be 03 00 00       	call   801052ad <release>
80104eef:	83 c4 10             	add    $0x10,%esp

  if (first) {
80104ef2:	a1 08 b0 10 80       	mov    0x8010b008,%eax
80104ef7:	85 c0                	test   %eax,%eax
80104ef9:	74 24                	je     80104f1f <forkret+0x43>
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot 
    // be run from main().
    first = 0;
80104efb:	c7 05 08 b0 10 80 00 	movl   $0x0,0x8010b008
80104f02:	00 00 00 
    iinit(ROOTDEV);
80104f05:	83 ec 0c             	sub    $0xc,%esp
80104f08:	6a 01                	push   $0x1
80104f0a:	e8 f1 c6 ff ff       	call   80101600 <iinit>
80104f0f:	83 c4 10             	add    $0x10,%esp
    initlog(ROOTDEV);
80104f12:	83 ec 0c             	sub    $0xc,%esp
80104f15:	6a 01                	push   $0x1
80104f17:	e8 b8 e3 ff ff       	call   801032d4 <initlog>
80104f1c:	83 c4 10             	add    $0x10,%esp
  }
  
  // Return to "caller", actually trapret (see allocproc).
}
80104f1f:	c9                   	leave  
80104f20:	c3                   	ret    

80104f21 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
80104f21:	55                   	push   %ebp
80104f22:	89 e5                	mov    %esp,%ebp
80104f24:	83 ec 08             	sub    $0x8,%esp
  if(proc == 0)
80104f27:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104f2d:	85 c0                	test   %eax,%eax
80104f2f:	75 0d                	jne    80104f3e <sleep+0x1d>
    panic("sleep");
80104f31:	83 ec 0c             	sub    $0xc,%esp
80104f34:	68 3a 8b 10 80       	push   $0x80108b3a
80104f39:	e8 1e b6 ff ff       	call   8010055c <panic>

  if(lk == 0)
80104f3e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80104f42:	75 0d                	jne    80104f51 <sleep+0x30>
    panic("sleep without lk");
80104f44:	83 ec 0c             	sub    $0xc,%esp
80104f47:	68 40 8b 10 80       	push   $0x80108b40
80104f4c:	e8 0b b6 ff ff       	call   8010055c <panic>
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
80104f51:	81 7d 0c 40 2c 11 80 	cmpl   $0x80112c40,0xc(%ebp)
80104f58:	74 1e                	je     80104f78 <sleep+0x57>
    acquire(&ptable.lock);  //DOC: sleeplock1
80104f5a:	83 ec 0c             	sub    $0xc,%esp
80104f5d:	68 40 2c 11 80       	push   $0x80112c40
80104f62:	e8 e0 02 00 00       	call   80105247 <acquire>
80104f67:	83 c4 10             	add    $0x10,%esp
    release(lk);
80104f6a:	83 ec 0c             	sub    $0xc,%esp
80104f6d:	ff 75 0c             	pushl  0xc(%ebp)
80104f70:	e8 38 03 00 00       	call   801052ad <release>
80104f75:	83 c4 10             	add    $0x10,%esp
  }

  // Go to sleep.
  proc->chan = chan;
80104f78:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104f7e:	8b 55 08             	mov    0x8(%ebp),%edx
80104f81:	89 50 20             	mov    %edx,0x20(%eax)
  proc->state = SLEEPING;
80104f84:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104f8a:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
          
   //Remove da fila de prontos
  remover(&filaP);
80104f91:	83 ec 0c             	sub    $0xc,%esp
80104f94:	68 c0 b6 10 80       	push   $0x8010b6c0
80104f99:	e8 16 f5 ff ff       	call   801044b4 <remover>
80104f9e:	83 c4 10             	add    $0x10,%esp
  
  sched();
80104fa1:	e8 2a fe ff ff       	call   80104dd0 <sched>

  // Tidy up.
  proc->chan = 0;
80104fa6:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104fac:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
80104fb3:	81 7d 0c 40 2c 11 80 	cmpl   $0x80112c40,0xc(%ebp)
80104fba:	74 1e                	je     80104fda <sleep+0xb9>
    release(&ptable.lock);
80104fbc:	83 ec 0c             	sub    $0xc,%esp
80104fbf:	68 40 2c 11 80       	push   $0x80112c40
80104fc4:	e8 e4 02 00 00       	call   801052ad <release>
80104fc9:	83 c4 10             	add    $0x10,%esp
    acquire(lk);
80104fcc:	83 ec 0c             	sub    $0xc,%esp
80104fcf:	ff 75 0c             	pushl  0xc(%ebp)
80104fd2:	e8 70 02 00 00       	call   80105247 <acquire>
80104fd7:	83 c4 10             	add    $0x10,%esp
  }
}
80104fda:	c9                   	leave  
80104fdb:	c3                   	ret    

80104fdc <wakeup1>:
//PAGEBREAK!
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
80104fdc:	55                   	push   %ebp
80104fdd:	89 e5                	mov    %esp,%ebp
80104fdf:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104fe2:	c7 45 f4 74 2c 11 80 	movl   $0x80112c74,-0xc(%ebp)
80104fe9:	eb 37                	jmp    80105022 <wakeup1+0x46>
    if(p->state == SLEEPING && p->chan == chan){
80104feb:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104fee:	8b 40 0c             	mov    0xc(%eax),%eax
80104ff1:	83 f8 02             	cmp    $0x2,%eax
80104ff4:	75 28                	jne    8010501e <wakeup1+0x42>
80104ff6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104ff9:	8b 40 20             	mov    0x20(%eax),%eax
80104ffc:	3b 45 08             	cmp    0x8(%ebp),%eax
80104fff:	75 1d                	jne    8010501e <wakeup1+0x42>
    p->state = RUNNABLE;
80105001:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105004:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
   //Adiciona na fila de Prontos de prontos
    inserir(&filaP, p);
8010500b:	83 ec 08             	sub    $0x8,%esp
8010500e:	ff 75 f4             	pushl  -0xc(%ebp)
80105011:	68 c0 b6 10 80       	push   $0x8010b6c0
80105016:	e8 12 f4 ff ff       	call   8010442d <inserir>
8010501b:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010501e:	83 6d f4 80          	subl   $0xffffff80,-0xc(%ebp)
80105022:	81 7d f4 74 4c 11 80 	cmpl   $0x80114c74,-0xc(%ebp)
80105029:	72 c0                	jb     80104feb <wakeup1+0xf>
   //Adiciona na fila de Prontos de prontos
    inserir(&filaP, p);
  }

  
}
8010502b:	c9                   	leave  
8010502c:	c3                   	ret    

8010502d <wakeup>:

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
8010502d:	55                   	push   %ebp
8010502e:	89 e5                	mov    %esp,%ebp
80105030:	83 ec 08             	sub    $0x8,%esp
  acquire(&ptable.lock);
80105033:	83 ec 0c             	sub    $0xc,%esp
80105036:	68 40 2c 11 80       	push   $0x80112c40
8010503b:	e8 07 02 00 00       	call   80105247 <acquire>
80105040:	83 c4 10             	add    $0x10,%esp
  wakeup1(chan);
80105043:	83 ec 0c             	sub    $0xc,%esp
80105046:	ff 75 08             	pushl  0x8(%ebp)
80105049:	e8 8e ff ff ff       	call   80104fdc <wakeup1>
8010504e:	83 c4 10             	add    $0x10,%esp
  release(&ptable.lock);
80105051:	83 ec 0c             	sub    $0xc,%esp
80105054:	68 40 2c 11 80       	push   $0x80112c40
80105059:	e8 4f 02 00 00       	call   801052ad <release>
8010505e:	83 c4 10             	add    $0x10,%esp
}
80105061:	c9                   	leave  
80105062:	c3                   	ret    

80105063 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80105063:	55                   	push   %ebp
80105064:	89 e5                	mov    %esp,%ebp
80105066:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;

  acquire(&ptable.lock);
80105069:	83 ec 0c             	sub    $0xc,%esp
8010506c:	68 40 2c 11 80       	push   $0x80112c40
80105071:	e8 d1 01 00 00       	call   80105247 <acquire>
80105076:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80105079:	c7 45 f4 74 2c 11 80 	movl   $0x80112c74,-0xc(%ebp)
80105080:	eb 58                	jmp    801050da <kill+0x77>
    if(p->pid == pid){
80105082:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105085:	8b 40 10             	mov    0x10(%eax),%eax
80105088:	3b 45 08             	cmp    0x8(%ebp),%eax
8010508b:	75 49                	jne    801050d6 <kill+0x73>
      p->killed = 1;
8010508d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105090:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING){
80105097:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010509a:	8b 40 0c             	mov    0xc(%eax),%eax
8010509d:	83 f8 02             	cmp    $0x2,%eax
801050a0:	75 1d                	jne    801050bf <kill+0x5c>
        p->state = RUNNABLE;
801050a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801050a5:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
    
      //Adiciona na fila de Prontos de prontos  
        inserir(&filaP, p);
801050ac:	83 ec 08             	sub    $0x8,%esp
801050af:	ff 75 f4             	pushl  -0xc(%ebp)
801050b2:	68 c0 b6 10 80       	push   $0x8010b6c0
801050b7:	e8 71 f3 ff ff       	call   8010442d <inserir>
801050bc:	83 c4 10             	add    $0x10,%esp
    }
      release(&ptable.lock);
801050bf:	83 ec 0c             	sub    $0xc,%esp
801050c2:	68 40 2c 11 80       	push   $0x80112c40
801050c7:	e8 e1 01 00 00       	call   801052ad <release>
801050cc:	83 c4 10             	add    $0x10,%esp
      return 0;
801050cf:	b8 00 00 00 00       	mov    $0x0,%eax
801050d4:	eb 22                	jmp    801050f8 <kill+0x95>
kill(int pid)
{
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801050d6:	83 6d f4 80          	subl   $0xffffff80,-0xc(%ebp)
801050da:	81 7d f4 74 4c 11 80 	cmpl   $0x80114c74,-0xc(%ebp)
801050e1:	72 9f                	jb     80105082 <kill+0x1f>
    }
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
801050e3:	83 ec 0c             	sub    $0xc,%esp
801050e6:	68 40 2c 11 80       	push   $0x80112c40
801050eb:	e8 bd 01 00 00       	call   801052ad <release>
801050f0:	83 c4 10             	add    $0x10,%esp
  return -1;
801050f3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801050f8:	c9                   	leave  
801050f9:	c3                   	ret    

801050fa <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
801050fa:	55                   	push   %ebp
801050fb:	89 e5                	mov    %esp,%ebp
801050fd:	83 ec 48             	sub    $0x48,%esp
  int i;
  struct proc *p;
  char *state;
  uint pc[10];
  
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80105100:	c7 45 f0 74 2c 11 80 	movl   $0x80112c74,-0x10(%ebp)
80105107:	e9 d5 00 00 00       	jmp    801051e1 <procdump+0xe7>
    if(p->state == UNUSED)
8010510c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010510f:	8b 40 0c             	mov    0xc(%eax),%eax
80105112:	85 c0                	test   %eax,%eax
80105114:	75 05                	jne    8010511b <procdump+0x21>
      continue;
80105116:	e9 c2 00 00 00       	jmp    801051dd <procdump+0xe3>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
8010511b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010511e:	8b 40 0c             	mov    0xc(%eax),%eax
80105121:	83 f8 05             	cmp    $0x5,%eax
80105124:	77 23                	ja     80105149 <procdump+0x4f>
80105126:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105129:	8b 40 0c             	mov    0xc(%eax),%eax
8010512c:	8b 04 85 0c b0 10 80 	mov    -0x7fef4ff4(,%eax,4),%eax
80105133:	85 c0                	test   %eax,%eax
80105135:	74 12                	je     80105149 <procdump+0x4f>
      state = states[p->state];
80105137:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010513a:	8b 40 0c             	mov    0xc(%eax),%eax
8010513d:	8b 04 85 0c b0 10 80 	mov    -0x7fef4ff4(,%eax,4),%eax
80105144:	89 45 ec             	mov    %eax,-0x14(%ebp)
80105147:	eb 07                	jmp    80105150 <procdump+0x56>
    else
      state = "???";
80105149:	c7 45 ec 51 8b 10 80 	movl   $0x80108b51,-0x14(%ebp)
    cprintf("%d %s %s", p->pid, state, p->name);
80105150:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105153:	8d 50 6c             	lea    0x6c(%eax),%edx
80105156:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105159:	8b 40 10             	mov    0x10(%eax),%eax
8010515c:	52                   	push   %edx
8010515d:	ff 75 ec             	pushl  -0x14(%ebp)
80105160:	50                   	push   %eax
80105161:	68 55 8b 10 80       	push   $0x80108b55
80105166:	e8 54 b2 ff ff       	call   801003bf <cprintf>
8010516b:	83 c4 10             	add    $0x10,%esp
    if(p->state == SLEEPING){
8010516e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105171:	8b 40 0c             	mov    0xc(%eax),%eax
80105174:	83 f8 02             	cmp    $0x2,%eax
80105177:	75 54                	jne    801051cd <procdump+0xd3>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80105179:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010517c:	8b 40 1c             	mov    0x1c(%eax),%eax
8010517f:	8b 40 0c             	mov    0xc(%eax),%eax
80105182:	83 c0 08             	add    $0x8,%eax
80105185:	89 c2                	mov    %eax,%edx
80105187:	83 ec 08             	sub    $0x8,%esp
8010518a:	8d 45 c4             	lea    -0x3c(%ebp),%eax
8010518d:	50                   	push   %eax
8010518e:	52                   	push   %edx
8010518f:	e8 6a 01 00 00       	call   801052fe <getcallerpcs>
80105194:	83 c4 10             	add    $0x10,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
80105197:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010519e:	eb 1c                	jmp    801051bc <procdump+0xc2>
        cprintf(" %p", pc[i]);
801051a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801051a3:	8b 44 85 c4          	mov    -0x3c(%ebp,%eax,4),%eax
801051a7:	83 ec 08             	sub    $0x8,%esp
801051aa:	50                   	push   %eax
801051ab:	68 5e 8b 10 80       	push   $0x80108b5e
801051b0:	e8 0a b2 ff ff       	call   801003bf <cprintf>
801051b5:	83 c4 10             	add    $0x10,%esp
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
801051b8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801051bc:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
801051c0:	7f 0b                	jg     801051cd <procdump+0xd3>
801051c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801051c5:	8b 44 85 c4          	mov    -0x3c(%ebp,%eax,4),%eax
801051c9:	85 c0                	test   %eax,%eax
801051cb:	75 d3                	jne    801051a0 <procdump+0xa6>
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
801051cd:	83 ec 0c             	sub    $0xc,%esp
801051d0:	68 62 8b 10 80       	push   $0x80108b62
801051d5:	e8 e5 b1 ff ff       	call   801003bf <cprintf>
801051da:	83 c4 10             	add    $0x10,%esp
  int i;
  struct proc *p;
  char *state;
  uint pc[10];
  
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801051dd:	83 6d f0 80          	subl   $0xffffff80,-0x10(%ebp)
801051e1:	81 7d f0 74 4c 11 80 	cmpl   $0x80114c74,-0x10(%ebp)
801051e8:	0f 82 1e ff ff ff    	jb     8010510c <procdump+0x12>
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
  
}
801051ee:	c9                   	leave  
801051ef:	c3                   	ret    

801051f0 <readeflags>:
  asm volatile("ltr %0" : : "r" (sel));
}

static inline uint
readeflags(void)
{
801051f0:	55                   	push   %ebp
801051f1:	89 e5                	mov    %esp,%ebp
801051f3:	83 ec 10             	sub    $0x10,%esp
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801051f6:	9c                   	pushf  
801051f7:	58                   	pop    %eax
801051f8:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return eflags;
801051fb:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
801051fe:	c9                   	leave  
801051ff:	c3                   	ret    

80105200 <cli>:
  asm volatile("movw %0, %%gs" : : "r" (v));
}

static inline void
cli(void)
{
80105200:	55                   	push   %ebp
80105201:	89 e5                	mov    %esp,%ebp
  asm volatile("cli");
80105203:	fa                   	cli    
}
80105204:	5d                   	pop    %ebp
80105205:	c3                   	ret    

80105206 <sti>:

static inline void
sti(void)
{
80105206:	55                   	push   %ebp
80105207:	89 e5                	mov    %esp,%ebp
  asm volatile("sti");
80105209:	fb                   	sti    
}
8010520a:	5d                   	pop    %ebp
8010520b:	c3                   	ret    

8010520c <xchg>:

static inline uint
xchg(volatile uint *addr, uint newval)
{
8010520c:	55                   	push   %ebp
8010520d:	89 e5                	mov    %esp,%ebp
8010520f:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80105212:	8b 55 08             	mov    0x8(%ebp),%edx
80105215:	8b 45 0c             	mov    0xc(%ebp),%eax
80105218:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010521b:	f0 87 02             	lock xchg %eax,(%edx)
8010521e:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
80105221:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80105224:	c9                   	leave  
80105225:	c3                   	ret    

80105226 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80105226:	55                   	push   %ebp
80105227:	89 e5                	mov    %esp,%ebp
  lk->name = name;
80105229:	8b 45 08             	mov    0x8(%ebp),%eax
8010522c:	8b 55 0c             	mov    0xc(%ebp),%edx
8010522f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
80105232:	8b 45 08             	mov    0x8(%ebp),%eax
80105235:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->cpu = 0;
8010523b:	8b 45 08             	mov    0x8(%ebp),%eax
8010523e:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80105245:	5d                   	pop    %ebp
80105246:	c3                   	ret    

80105247 <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
80105247:	55                   	push   %ebp
80105248:	89 e5                	mov    %esp,%ebp
8010524a:	83 ec 08             	sub    $0x8,%esp
  pushcli(); // disable interrupts to avoid deadlock.
8010524d:	e8 4f 01 00 00       	call   801053a1 <pushcli>
  if(holding(lk))
80105252:	8b 45 08             	mov    0x8(%ebp),%eax
80105255:	83 ec 0c             	sub    $0xc,%esp
80105258:	50                   	push   %eax
80105259:	e8 19 01 00 00       	call   80105377 <holding>
8010525e:	83 c4 10             	add    $0x10,%esp
80105261:	85 c0                	test   %eax,%eax
80105263:	74 0d                	je     80105272 <acquire+0x2b>
    panic("acquire");
80105265:	83 ec 0c             	sub    $0xc,%esp
80105268:	68 8e 8b 10 80       	push   $0x80108b8e
8010526d:	e8 ea b2 ff ff       	call   8010055c <panic>

  // The xchg is atomic.
  // It also serializes, so that reads after acquire are not
  // reordered before it. 
  while(xchg(&lk->locked, 1) != 0)
80105272:	90                   	nop
80105273:	8b 45 08             	mov    0x8(%ebp),%eax
80105276:	83 ec 08             	sub    $0x8,%esp
80105279:	6a 01                	push   $0x1
8010527b:	50                   	push   %eax
8010527c:	e8 8b ff ff ff       	call   8010520c <xchg>
80105281:	83 c4 10             	add    $0x10,%esp
80105284:	85 c0                	test   %eax,%eax
80105286:	75 eb                	jne    80105273 <acquire+0x2c>
    ;

  // Record info about lock acquisition for debugging.
  lk->cpu = cpu;
80105288:	8b 45 08             	mov    0x8(%ebp),%eax
8010528b:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80105292:	89 50 08             	mov    %edx,0x8(%eax)
  getcallerpcs(&lk, lk->pcs);
80105295:	8b 45 08             	mov    0x8(%ebp),%eax
80105298:	83 c0 0c             	add    $0xc,%eax
8010529b:	83 ec 08             	sub    $0x8,%esp
8010529e:	50                   	push   %eax
8010529f:	8d 45 08             	lea    0x8(%ebp),%eax
801052a2:	50                   	push   %eax
801052a3:	e8 56 00 00 00       	call   801052fe <getcallerpcs>
801052a8:	83 c4 10             	add    $0x10,%esp
}
801052ab:	c9                   	leave  
801052ac:	c3                   	ret    

801052ad <release>:

// Release the lock.
void
release(struct spinlock *lk)
{
801052ad:	55                   	push   %ebp
801052ae:	89 e5                	mov    %esp,%ebp
801052b0:	83 ec 08             	sub    $0x8,%esp
  if(!holding(lk))
801052b3:	83 ec 0c             	sub    $0xc,%esp
801052b6:	ff 75 08             	pushl  0x8(%ebp)
801052b9:	e8 b9 00 00 00       	call   80105377 <holding>
801052be:	83 c4 10             	add    $0x10,%esp
801052c1:	85 c0                	test   %eax,%eax
801052c3:	75 0d                	jne    801052d2 <release+0x25>
    panic("release");
801052c5:	83 ec 0c             	sub    $0xc,%esp
801052c8:	68 96 8b 10 80       	push   $0x80108b96
801052cd:	e8 8a b2 ff ff       	call   8010055c <panic>

  lk->pcs[0] = 0;
801052d2:	8b 45 08             	mov    0x8(%ebp),%eax
801052d5:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  lk->cpu = 0;
801052dc:	8b 45 08             	mov    0x8(%ebp),%eax
801052df:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  // But the 2007 Intel 64 Architecture Memory Ordering White
  // Paper says that Intel 64 and IA-32 will not move a load
  // after a store. So lock->locked = 0 would work here.
  // The xchg being asm volatile ensures gcc emits it after
  // the above assignments (and after the critical section).
  xchg(&lk->locked, 0);
801052e6:	8b 45 08             	mov    0x8(%ebp),%eax
801052e9:	83 ec 08             	sub    $0x8,%esp
801052ec:	6a 00                	push   $0x0
801052ee:	50                   	push   %eax
801052ef:	e8 18 ff ff ff       	call   8010520c <xchg>
801052f4:	83 c4 10             	add    $0x10,%esp

  popcli();
801052f7:	e8 e9 00 00 00       	call   801053e5 <popcli>
}
801052fc:	c9                   	leave  
801052fd:	c3                   	ret    

801052fe <getcallerpcs>:

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
801052fe:	55                   	push   %ebp
801052ff:	89 e5                	mov    %esp,%ebp
80105301:	83 ec 10             	sub    $0x10,%esp
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
80105304:	8b 45 08             	mov    0x8(%ebp),%eax
80105307:	83 e8 08             	sub    $0x8,%eax
8010530a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  for(i = 0; i < 10; i++){
8010530d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
80105314:	eb 38                	jmp    8010534e <getcallerpcs+0x50>
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80105316:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
8010531a:	74 38                	je     80105354 <getcallerpcs+0x56>
8010531c:	81 7d fc ff ff ff 7f 	cmpl   $0x7fffffff,-0x4(%ebp)
80105323:	76 2f                	jbe    80105354 <getcallerpcs+0x56>
80105325:	83 7d fc ff          	cmpl   $0xffffffff,-0x4(%ebp)
80105329:	74 29                	je     80105354 <getcallerpcs+0x56>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010532b:	8b 45 f8             	mov    -0x8(%ebp),%eax
8010532e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80105335:	8b 45 0c             	mov    0xc(%ebp),%eax
80105338:	01 c2                	add    %eax,%edx
8010533a:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010533d:	8b 40 04             	mov    0x4(%eax),%eax
80105340:	89 02                	mov    %eax,(%edx)
    ebp = (uint*)ebp[0]; // saved %ebp
80105342:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105345:	8b 00                	mov    (%eax),%eax
80105347:	89 45 fc             	mov    %eax,-0x4(%ebp)
{
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
8010534a:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
8010534e:	83 7d f8 09          	cmpl   $0x9,-0x8(%ebp)
80105352:	7e c2                	jle    80105316 <getcallerpcs+0x18>
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
80105354:	eb 19                	jmp    8010536f <getcallerpcs+0x71>
    pcs[i] = 0;
80105356:	8b 45 f8             	mov    -0x8(%ebp),%eax
80105359:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80105360:	8b 45 0c             	mov    0xc(%ebp),%eax
80105363:	01 d0                	add    %edx,%eax
80105365:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
8010536b:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
8010536f:	83 7d f8 09          	cmpl   $0x9,-0x8(%ebp)
80105373:	7e e1                	jle    80105356 <getcallerpcs+0x58>
    pcs[i] = 0;
}
80105375:	c9                   	leave  
80105376:	c3                   	ret    

80105377 <holding>:

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
80105377:	55                   	push   %ebp
80105378:	89 e5                	mov    %esp,%ebp
  return lock->locked && lock->cpu == cpu;
8010537a:	8b 45 08             	mov    0x8(%ebp),%eax
8010537d:	8b 00                	mov    (%eax),%eax
8010537f:	85 c0                	test   %eax,%eax
80105381:	74 17                	je     8010539a <holding+0x23>
80105383:	8b 45 08             	mov    0x8(%ebp),%eax
80105386:	8b 50 08             	mov    0x8(%eax),%edx
80105389:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010538f:	39 c2                	cmp    %eax,%edx
80105391:	75 07                	jne    8010539a <holding+0x23>
80105393:	b8 01 00 00 00       	mov    $0x1,%eax
80105398:	eb 05                	jmp    8010539f <holding+0x28>
8010539a:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010539f:	5d                   	pop    %ebp
801053a0:	c3                   	ret    

801053a1 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
801053a1:	55                   	push   %ebp
801053a2:	89 e5                	mov    %esp,%ebp
801053a4:	83 ec 10             	sub    $0x10,%esp
  int eflags;
  
  eflags = readeflags();
801053a7:	e8 44 fe ff ff       	call   801051f0 <readeflags>
801053ac:	89 45 fc             	mov    %eax,-0x4(%ebp)
  cli();
801053af:	e8 4c fe ff ff       	call   80105200 <cli>
  if(cpu->ncli++ == 0)
801053b4:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
801053bb:	8b 82 ac 00 00 00    	mov    0xac(%edx),%eax
801053c1:	8d 48 01             	lea    0x1(%eax),%ecx
801053c4:	89 8a ac 00 00 00    	mov    %ecx,0xac(%edx)
801053ca:	85 c0                	test   %eax,%eax
801053cc:	75 15                	jne    801053e3 <pushcli+0x42>
    cpu->intena = eflags & FL_IF;
801053ce:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801053d4:	8b 55 fc             	mov    -0x4(%ebp),%edx
801053d7:	81 e2 00 02 00 00    	and    $0x200,%edx
801053dd:	89 90 b0 00 00 00    	mov    %edx,0xb0(%eax)
}
801053e3:	c9                   	leave  
801053e4:	c3                   	ret    

801053e5 <popcli>:

void
popcli(void)
{
801053e5:	55                   	push   %ebp
801053e6:	89 e5                	mov    %esp,%ebp
801053e8:	83 ec 08             	sub    $0x8,%esp
  if(readeflags()&FL_IF)
801053eb:	e8 00 fe ff ff       	call   801051f0 <readeflags>
801053f0:	25 00 02 00 00       	and    $0x200,%eax
801053f5:	85 c0                	test   %eax,%eax
801053f7:	74 0d                	je     80105406 <popcli+0x21>
    panic("popcli - interruptible");
801053f9:	83 ec 0c             	sub    $0xc,%esp
801053fc:	68 9e 8b 10 80       	push   $0x80108b9e
80105401:	e8 56 b1 ff ff       	call   8010055c <panic>
  if(--cpu->ncli < 0)
80105406:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010540c:	8b 90 ac 00 00 00    	mov    0xac(%eax),%edx
80105412:	83 ea 01             	sub    $0x1,%edx
80105415:	89 90 ac 00 00 00    	mov    %edx,0xac(%eax)
8010541b:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
80105421:	85 c0                	test   %eax,%eax
80105423:	79 0d                	jns    80105432 <popcli+0x4d>
    panic("popcli");
80105425:	83 ec 0c             	sub    $0xc,%esp
80105428:	68 b5 8b 10 80       	push   $0x80108bb5
8010542d:	e8 2a b1 ff ff       	call   8010055c <panic>
  if(cpu->ncli == 0 && cpu->intena)
80105432:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80105438:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
8010543e:	85 c0                	test   %eax,%eax
80105440:	75 15                	jne    80105457 <popcli+0x72>
80105442:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80105448:	8b 80 b0 00 00 00    	mov    0xb0(%eax),%eax
8010544e:	85 c0                	test   %eax,%eax
80105450:	74 05                	je     80105457 <popcli+0x72>
    sti();
80105452:	e8 af fd ff ff       	call   80105206 <sti>
}
80105457:	c9                   	leave  
80105458:	c3                   	ret    

80105459 <stosb>:
80105459:	55                   	push   %ebp
8010545a:	89 e5                	mov    %esp,%ebp
8010545c:	57                   	push   %edi
8010545d:	53                   	push   %ebx
8010545e:	8b 4d 08             	mov    0x8(%ebp),%ecx
80105461:	8b 55 10             	mov    0x10(%ebp),%edx
80105464:	8b 45 0c             	mov    0xc(%ebp),%eax
80105467:	89 cb                	mov    %ecx,%ebx
80105469:	89 df                	mov    %ebx,%edi
8010546b:	89 d1                	mov    %edx,%ecx
8010546d:	fc                   	cld    
8010546e:	f3 aa                	rep stos %al,%es:(%edi)
80105470:	89 ca                	mov    %ecx,%edx
80105472:	89 fb                	mov    %edi,%ebx
80105474:	89 5d 08             	mov    %ebx,0x8(%ebp)
80105477:	89 55 10             	mov    %edx,0x10(%ebp)
8010547a:	5b                   	pop    %ebx
8010547b:	5f                   	pop    %edi
8010547c:	5d                   	pop    %ebp
8010547d:	c3                   	ret    

8010547e <stosl>:
8010547e:	55                   	push   %ebp
8010547f:	89 e5                	mov    %esp,%ebp
80105481:	57                   	push   %edi
80105482:	53                   	push   %ebx
80105483:	8b 4d 08             	mov    0x8(%ebp),%ecx
80105486:	8b 55 10             	mov    0x10(%ebp),%edx
80105489:	8b 45 0c             	mov    0xc(%ebp),%eax
8010548c:	89 cb                	mov    %ecx,%ebx
8010548e:	89 df                	mov    %ebx,%edi
80105490:	89 d1                	mov    %edx,%ecx
80105492:	fc                   	cld    
80105493:	f3 ab                	rep stos %eax,%es:(%edi)
80105495:	89 ca                	mov    %ecx,%edx
80105497:	89 fb                	mov    %edi,%ebx
80105499:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010549c:	89 55 10             	mov    %edx,0x10(%ebp)
8010549f:	5b                   	pop    %ebx
801054a0:	5f                   	pop    %edi
801054a1:	5d                   	pop    %ebp
801054a2:	c3                   	ret    

801054a3 <memset>:
801054a3:	55                   	push   %ebp
801054a4:	89 e5                	mov    %esp,%ebp
801054a6:	8b 45 08             	mov    0x8(%ebp),%eax
801054a9:	83 e0 03             	and    $0x3,%eax
801054ac:	85 c0                	test   %eax,%eax
801054ae:	75 43                	jne    801054f3 <memset+0x50>
801054b0:	8b 45 10             	mov    0x10(%ebp),%eax
801054b3:	83 e0 03             	and    $0x3,%eax
801054b6:	85 c0                	test   %eax,%eax
801054b8:	75 39                	jne    801054f3 <memset+0x50>
801054ba:	81 65 0c ff 00 00 00 	andl   $0xff,0xc(%ebp)
801054c1:	8b 45 10             	mov    0x10(%ebp),%eax
801054c4:	c1 e8 02             	shr    $0x2,%eax
801054c7:	89 c1                	mov    %eax,%ecx
801054c9:	8b 45 0c             	mov    0xc(%ebp),%eax
801054cc:	c1 e0 18             	shl    $0x18,%eax
801054cf:	89 c2                	mov    %eax,%edx
801054d1:	8b 45 0c             	mov    0xc(%ebp),%eax
801054d4:	c1 e0 10             	shl    $0x10,%eax
801054d7:	09 c2                	or     %eax,%edx
801054d9:	8b 45 0c             	mov    0xc(%ebp),%eax
801054dc:	c1 e0 08             	shl    $0x8,%eax
801054df:	09 d0                	or     %edx,%eax
801054e1:	0b 45 0c             	or     0xc(%ebp),%eax
801054e4:	51                   	push   %ecx
801054e5:	50                   	push   %eax
801054e6:	ff 75 08             	pushl  0x8(%ebp)
801054e9:	e8 90 ff ff ff       	call   8010547e <stosl>
801054ee:	83 c4 0c             	add    $0xc,%esp
801054f1:	eb 12                	jmp    80105505 <memset+0x62>
801054f3:	8b 45 10             	mov    0x10(%ebp),%eax
801054f6:	50                   	push   %eax
801054f7:	ff 75 0c             	pushl  0xc(%ebp)
801054fa:	ff 75 08             	pushl  0x8(%ebp)
801054fd:	e8 57 ff ff ff       	call   80105459 <stosb>
80105502:	83 c4 0c             	add    $0xc,%esp
80105505:	8b 45 08             	mov    0x8(%ebp),%eax
80105508:	c9                   	leave  
80105509:	c3                   	ret    

8010550a <memcmp>:
8010550a:	55                   	push   %ebp
8010550b:	89 e5                	mov    %esp,%ebp
8010550d:	83 ec 10             	sub    $0x10,%esp
80105510:	8b 45 08             	mov    0x8(%ebp),%eax
80105513:	89 45 fc             	mov    %eax,-0x4(%ebp)
80105516:	8b 45 0c             	mov    0xc(%ebp),%eax
80105519:	89 45 f8             	mov    %eax,-0x8(%ebp)
8010551c:	eb 30                	jmp    8010554e <memcmp+0x44>
8010551e:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105521:	0f b6 10             	movzbl (%eax),%edx
80105524:	8b 45 f8             	mov    -0x8(%ebp),%eax
80105527:	0f b6 00             	movzbl (%eax),%eax
8010552a:	38 c2                	cmp    %al,%dl
8010552c:	74 18                	je     80105546 <memcmp+0x3c>
8010552e:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105531:	0f b6 00             	movzbl (%eax),%eax
80105534:	0f b6 d0             	movzbl %al,%edx
80105537:	8b 45 f8             	mov    -0x8(%ebp),%eax
8010553a:	0f b6 00             	movzbl (%eax),%eax
8010553d:	0f b6 c0             	movzbl %al,%eax
80105540:	29 c2                	sub    %eax,%edx
80105542:	89 d0                	mov    %edx,%eax
80105544:	eb 1a                	jmp    80105560 <memcmp+0x56>
80105546:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
8010554a:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
8010554e:	8b 45 10             	mov    0x10(%ebp),%eax
80105551:	8d 50 ff             	lea    -0x1(%eax),%edx
80105554:	89 55 10             	mov    %edx,0x10(%ebp)
80105557:	85 c0                	test   %eax,%eax
80105559:	75 c3                	jne    8010551e <memcmp+0x14>
8010555b:	b8 00 00 00 00       	mov    $0x0,%eax
80105560:	c9                   	leave  
80105561:	c3                   	ret    

80105562 <memmove>:
80105562:	55                   	push   %ebp
80105563:	89 e5                	mov    %esp,%ebp
80105565:	83 ec 10             	sub    $0x10,%esp
80105568:	8b 45 0c             	mov    0xc(%ebp),%eax
8010556b:	89 45 fc             	mov    %eax,-0x4(%ebp)
8010556e:	8b 45 08             	mov    0x8(%ebp),%eax
80105571:	89 45 f8             	mov    %eax,-0x8(%ebp)
80105574:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105577:	3b 45 f8             	cmp    -0x8(%ebp),%eax
8010557a:	73 3d                	jae    801055b9 <memmove+0x57>
8010557c:	8b 55 fc             	mov    -0x4(%ebp),%edx
8010557f:	8b 45 10             	mov    0x10(%ebp),%eax
80105582:	01 d0                	add    %edx,%eax
80105584:	3b 45 f8             	cmp    -0x8(%ebp),%eax
80105587:	76 30                	jbe    801055b9 <memmove+0x57>
80105589:	8b 45 10             	mov    0x10(%ebp),%eax
8010558c:	01 45 fc             	add    %eax,-0x4(%ebp)
8010558f:	8b 45 10             	mov    0x10(%ebp),%eax
80105592:	01 45 f8             	add    %eax,-0x8(%ebp)
80105595:	eb 13                	jmp    801055aa <memmove+0x48>
80105597:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
8010559b:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
8010559f:	8b 45 fc             	mov    -0x4(%ebp),%eax
801055a2:	0f b6 10             	movzbl (%eax),%edx
801055a5:	8b 45 f8             	mov    -0x8(%ebp),%eax
801055a8:	88 10                	mov    %dl,(%eax)
801055aa:	8b 45 10             	mov    0x10(%ebp),%eax
801055ad:	8d 50 ff             	lea    -0x1(%eax),%edx
801055b0:	89 55 10             	mov    %edx,0x10(%ebp)
801055b3:	85 c0                	test   %eax,%eax
801055b5:	75 e0                	jne    80105597 <memmove+0x35>
801055b7:	eb 26                	jmp    801055df <memmove+0x7d>
801055b9:	eb 17                	jmp    801055d2 <memmove+0x70>
801055bb:	8b 45 f8             	mov    -0x8(%ebp),%eax
801055be:	8d 50 01             	lea    0x1(%eax),%edx
801055c1:	89 55 f8             	mov    %edx,-0x8(%ebp)
801055c4:	8b 55 fc             	mov    -0x4(%ebp),%edx
801055c7:	8d 4a 01             	lea    0x1(%edx),%ecx
801055ca:	89 4d fc             	mov    %ecx,-0x4(%ebp)
801055cd:	0f b6 12             	movzbl (%edx),%edx
801055d0:	88 10                	mov    %dl,(%eax)
801055d2:	8b 45 10             	mov    0x10(%ebp),%eax
801055d5:	8d 50 ff             	lea    -0x1(%eax),%edx
801055d8:	89 55 10             	mov    %edx,0x10(%ebp)
801055db:	85 c0                	test   %eax,%eax
801055dd:	75 dc                	jne    801055bb <memmove+0x59>
801055df:	8b 45 08             	mov    0x8(%ebp),%eax
801055e2:	c9                   	leave  
801055e3:	c3                   	ret    

801055e4 <memcpy>:
801055e4:	55                   	push   %ebp
801055e5:	89 e5                	mov    %esp,%ebp
801055e7:	ff 75 10             	pushl  0x10(%ebp)
801055ea:	ff 75 0c             	pushl  0xc(%ebp)
801055ed:	ff 75 08             	pushl  0x8(%ebp)
801055f0:	e8 6d ff ff ff       	call   80105562 <memmove>
801055f5:	83 c4 0c             	add    $0xc,%esp
801055f8:	c9                   	leave  
801055f9:	c3                   	ret    

801055fa <strncmp>:
801055fa:	55                   	push   %ebp
801055fb:	89 e5                	mov    %esp,%ebp
801055fd:	eb 0c                	jmp    8010560b <strncmp+0x11>
801055ff:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
80105603:	83 45 08 01          	addl   $0x1,0x8(%ebp)
80105607:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
8010560b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010560f:	74 1a                	je     8010562b <strncmp+0x31>
80105611:	8b 45 08             	mov    0x8(%ebp),%eax
80105614:	0f b6 00             	movzbl (%eax),%eax
80105617:	84 c0                	test   %al,%al
80105619:	74 10                	je     8010562b <strncmp+0x31>
8010561b:	8b 45 08             	mov    0x8(%ebp),%eax
8010561e:	0f b6 10             	movzbl (%eax),%edx
80105621:	8b 45 0c             	mov    0xc(%ebp),%eax
80105624:	0f b6 00             	movzbl (%eax),%eax
80105627:	38 c2                	cmp    %al,%dl
80105629:	74 d4                	je     801055ff <strncmp+0x5>
8010562b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010562f:	75 07                	jne    80105638 <strncmp+0x3e>
80105631:	b8 00 00 00 00       	mov    $0x0,%eax
80105636:	eb 16                	jmp    8010564e <strncmp+0x54>
80105638:	8b 45 08             	mov    0x8(%ebp),%eax
8010563b:	0f b6 00             	movzbl (%eax),%eax
8010563e:	0f b6 d0             	movzbl %al,%edx
80105641:	8b 45 0c             	mov    0xc(%ebp),%eax
80105644:	0f b6 00             	movzbl (%eax),%eax
80105647:	0f b6 c0             	movzbl %al,%eax
8010564a:	29 c2                	sub    %eax,%edx
8010564c:	89 d0                	mov    %edx,%eax
8010564e:	5d                   	pop    %ebp
8010564f:	c3                   	ret    

80105650 <strncpy>:
80105650:	55                   	push   %ebp
80105651:	89 e5                	mov    %esp,%ebp
80105653:	83 ec 10             	sub    $0x10,%esp
80105656:	8b 45 08             	mov    0x8(%ebp),%eax
80105659:	89 45 fc             	mov    %eax,-0x4(%ebp)
8010565c:	90                   	nop
8010565d:	8b 45 10             	mov    0x10(%ebp),%eax
80105660:	8d 50 ff             	lea    -0x1(%eax),%edx
80105663:	89 55 10             	mov    %edx,0x10(%ebp)
80105666:	85 c0                	test   %eax,%eax
80105668:	7e 1e                	jle    80105688 <strncpy+0x38>
8010566a:	8b 45 08             	mov    0x8(%ebp),%eax
8010566d:	8d 50 01             	lea    0x1(%eax),%edx
80105670:	89 55 08             	mov    %edx,0x8(%ebp)
80105673:	8b 55 0c             	mov    0xc(%ebp),%edx
80105676:	8d 4a 01             	lea    0x1(%edx),%ecx
80105679:	89 4d 0c             	mov    %ecx,0xc(%ebp)
8010567c:	0f b6 12             	movzbl (%edx),%edx
8010567f:	88 10                	mov    %dl,(%eax)
80105681:	0f b6 00             	movzbl (%eax),%eax
80105684:	84 c0                	test   %al,%al
80105686:	75 d5                	jne    8010565d <strncpy+0xd>
80105688:	eb 0c                	jmp    80105696 <strncpy+0x46>
8010568a:	8b 45 08             	mov    0x8(%ebp),%eax
8010568d:	8d 50 01             	lea    0x1(%eax),%edx
80105690:	89 55 08             	mov    %edx,0x8(%ebp)
80105693:	c6 00 00             	movb   $0x0,(%eax)
80105696:	8b 45 10             	mov    0x10(%ebp),%eax
80105699:	8d 50 ff             	lea    -0x1(%eax),%edx
8010569c:	89 55 10             	mov    %edx,0x10(%ebp)
8010569f:	85 c0                	test   %eax,%eax
801056a1:	7f e7                	jg     8010568a <strncpy+0x3a>
801056a3:	8b 45 fc             	mov    -0x4(%ebp),%eax
801056a6:	c9                   	leave  
801056a7:	c3                   	ret    

801056a8 <safestrcpy>:
801056a8:	55                   	push   %ebp
801056a9:	89 e5                	mov    %esp,%ebp
801056ab:	83 ec 10             	sub    $0x10,%esp
801056ae:	8b 45 08             	mov    0x8(%ebp),%eax
801056b1:	89 45 fc             	mov    %eax,-0x4(%ebp)
801056b4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801056b8:	7f 05                	jg     801056bf <safestrcpy+0x17>
801056ba:	8b 45 fc             	mov    -0x4(%ebp),%eax
801056bd:	eb 31                	jmp    801056f0 <safestrcpy+0x48>
801056bf:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
801056c3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801056c7:	7e 1e                	jle    801056e7 <safestrcpy+0x3f>
801056c9:	8b 45 08             	mov    0x8(%ebp),%eax
801056cc:	8d 50 01             	lea    0x1(%eax),%edx
801056cf:	89 55 08             	mov    %edx,0x8(%ebp)
801056d2:	8b 55 0c             	mov    0xc(%ebp),%edx
801056d5:	8d 4a 01             	lea    0x1(%edx),%ecx
801056d8:	89 4d 0c             	mov    %ecx,0xc(%ebp)
801056db:	0f b6 12             	movzbl (%edx),%edx
801056de:	88 10                	mov    %dl,(%eax)
801056e0:	0f b6 00             	movzbl (%eax),%eax
801056e3:	84 c0                	test   %al,%al
801056e5:	75 d8                	jne    801056bf <safestrcpy+0x17>
801056e7:	8b 45 08             	mov    0x8(%ebp),%eax
801056ea:	c6 00 00             	movb   $0x0,(%eax)
801056ed:	8b 45 fc             	mov    -0x4(%ebp),%eax
801056f0:	c9                   	leave  
801056f1:	c3                   	ret    

801056f2 <strlen>:
801056f2:	55                   	push   %ebp
801056f3:	89 e5                	mov    %esp,%ebp
801056f5:	83 ec 10             	sub    $0x10,%esp
801056f8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
801056ff:	eb 04                	jmp    80105705 <strlen+0x13>
80105701:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80105705:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105708:	8b 45 08             	mov    0x8(%ebp),%eax
8010570b:	01 d0                	add    %edx,%eax
8010570d:	0f b6 00             	movzbl (%eax),%eax
80105710:	84 c0                	test   %al,%al
80105712:	75 ed                	jne    80105701 <strlen+0xf>
80105714:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105717:	c9                   	leave  
80105718:	c3                   	ret    

80105719 <swtch>:
80105719:	8b 44 24 04          	mov    0x4(%esp),%eax
8010571d:	8b 54 24 08          	mov    0x8(%esp),%edx
80105721:	55                   	push   %ebp
80105722:	53                   	push   %ebx
80105723:	56                   	push   %esi
80105724:	57                   	push   %edi
80105725:	89 20                	mov    %esp,(%eax)
80105727:	89 d4                	mov    %edx,%esp
80105729:	5f                   	pop    %edi
8010572a:	5e                   	pop    %esi
8010572b:	5b                   	pop    %ebx
8010572c:	5d                   	pop    %ebp
8010572d:	c3                   	ret    

8010572e <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
8010572e:	55                   	push   %ebp
8010572f:	89 e5                	mov    %esp,%ebp
  if(addr >= proc->sz || addr+4 > proc->sz)
80105731:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105737:	8b 00                	mov    (%eax),%eax
80105739:	3b 45 08             	cmp    0x8(%ebp),%eax
8010573c:	76 12                	jbe    80105750 <fetchint+0x22>
8010573e:	8b 45 08             	mov    0x8(%ebp),%eax
80105741:	8d 50 04             	lea    0x4(%eax),%edx
80105744:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010574a:	8b 00                	mov    (%eax),%eax
8010574c:	39 c2                	cmp    %eax,%edx
8010574e:	76 07                	jbe    80105757 <fetchint+0x29>
    return -1;
80105750:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105755:	eb 0f                	jmp    80105766 <fetchint+0x38>
  *ip = *(int*)(addr);
80105757:	8b 45 08             	mov    0x8(%ebp),%eax
8010575a:	8b 10                	mov    (%eax),%edx
8010575c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010575f:	89 10                	mov    %edx,(%eax)
  return 0;
80105761:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105766:	5d                   	pop    %ebp
80105767:	c3                   	ret    

80105768 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80105768:	55                   	push   %ebp
80105769:	89 e5                	mov    %esp,%ebp
8010576b:	83 ec 10             	sub    $0x10,%esp
  char *s, *ep;

  if(addr >= proc->sz)
8010576e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105774:	8b 00                	mov    (%eax),%eax
80105776:	3b 45 08             	cmp    0x8(%ebp),%eax
80105779:	77 07                	ja     80105782 <fetchstr+0x1a>
    return -1;
8010577b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105780:	eb 46                	jmp    801057c8 <fetchstr+0x60>
  *pp = (char*)addr;
80105782:	8b 55 08             	mov    0x8(%ebp),%edx
80105785:	8b 45 0c             	mov    0xc(%ebp),%eax
80105788:	89 10                	mov    %edx,(%eax)
  ep = (char*)proc->sz;
8010578a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105790:	8b 00                	mov    (%eax),%eax
80105792:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(s = *pp; s < ep; s++)
80105795:	8b 45 0c             	mov    0xc(%ebp),%eax
80105798:	8b 00                	mov    (%eax),%eax
8010579a:	89 45 fc             	mov    %eax,-0x4(%ebp)
8010579d:	eb 1c                	jmp    801057bb <fetchstr+0x53>
    if(*s == 0)
8010579f:	8b 45 fc             	mov    -0x4(%ebp),%eax
801057a2:	0f b6 00             	movzbl (%eax),%eax
801057a5:	84 c0                	test   %al,%al
801057a7:	75 0e                	jne    801057b7 <fetchstr+0x4f>
      return s - *pp;
801057a9:	8b 55 fc             	mov    -0x4(%ebp),%edx
801057ac:	8b 45 0c             	mov    0xc(%ebp),%eax
801057af:	8b 00                	mov    (%eax),%eax
801057b1:	29 c2                	sub    %eax,%edx
801057b3:	89 d0                	mov    %edx,%eax
801057b5:	eb 11                	jmp    801057c8 <fetchstr+0x60>

  if(addr >= proc->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)proc->sz;
  for(s = *pp; s < ep; s++)
801057b7:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
801057bb:	8b 45 fc             	mov    -0x4(%ebp),%eax
801057be:	3b 45 f8             	cmp    -0x8(%ebp),%eax
801057c1:	72 dc                	jb     8010579f <fetchstr+0x37>
    if(*s == 0)
      return s - *pp;
  return -1;
801057c3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801057c8:	c9                   	leave  
801057c9:	c3                   	ret    

801057ca <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
801057ca:	55                   	push   %ebp
801057cb:	89 e5                	mov    %esp,%ebp
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
801057cd:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801057d3:	8b 40 18             	mov    0x18(%eax),%eax
801057d6:	8b 40 44             	mov    0x44(%eax),%eax
801057d9:	8b 55 08             	mov    0x8(%ebp),%edx
801057dc:	c1 e2 02             	shl    $0x2,%edx
801057df:	01 d0                	add    %edx,%eax
801057e1:	83 c0 04             	add    $0x4,%eax
801057e4:	ff 75 0c             	pushl  0xc(%ebp)
801057e7:	50                   	push   %eax
801057e8:	e8 41 ff ff ff       	call   8010572e <fetchint>
801057ed:	83 c4 08             	add    $0x8,%esp
}
801057f0:	c9                   	leave  
801057f1:	c3                   	ret    

801057f2 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size n bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
801057f2:	55                   	push   %ebp
801057f3:	89 e5                	mov    %esp,%ebp
801057f5:	83 ec 10             	sub    $0x10,%esp
  int i;
  
  if(argint(n, &i) < 0)
801057f8:	8d 45 fc             	lea    -0x4(%ebp),%eax
801057fb:	50                   	push   %eax
801057fc:	ff 75 08             	pushl  0x8(%ebp)
801057ff:	e8 c6 ff ff ff       	call   801057ca <argint>
80105804:	83 c4 08             	add    $0x8,%esp
80105807:	85 c0                	test   %eax,%eax
80105809:	79 07                	jns    80105812 <argptr+0x20>
    return -1;
8010580b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105810:	eb 3d                	jmp    8010584f <argptr+0x5d>
  if((uint)i >= proc->sz || (uint)i+size > proc->sz)
80105812:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105815:	89 c2                	mov    %eax,%edx
80105817:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010581d:	8b 00                	mov    (%eax),%eax
8010581f:	39 c2                	cmp    %eax,%edx
80105821:	73 16                	jae    80105839 <argptr+0x47>
80105823:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105826:	89 c2                	mov    %eax,%edx
80105828:	8b 45 10             	mov    0x10(%ebp),%eax
8010582b:	01 c2                	add    %eax,%edx
8010582d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105833:	8b 00                	mov    (%eax),%eax
80105835:	39 c2                	cmp    %eax,%edx
80105837:	76 07                	jbe    80105840 <argptr+0x4e>
    return -1;
80105839:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010583e:	eb 0f                	jmp    8010584f <argptr+0x5d>
  *pp = (char*)i;
80105840:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105843:	89 c2                	mov    %eax,%edx
80105845:	8b 45 0c             	mov    0xc(%ebp),%eax
80105848:	89 10                	mov    %edx,(%eax)
  return 0;
8010584a:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010584f:	c9                   	leave  
80105850:	c3                   	ret    

80105851 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80105851:	55                   	push   %ebp
80105852:	89 e5                	mov    %esp,%ebp
80105854:	83 ec 10             	sub    $0x10,%esp
  int addr;
  if(argint(n, &addr) < 0)
80105857:	8d 45 fc             	lea    -0x4(%ebp),%eax
8010585a:	50                   	push   %eax
8010585b:	ff 75 08             	pushl  0x8(%ebp)
8010585e:	e8 67 ff ff ff       	call   801057ca <argint>
80105863:	83 c4 08             	add    $0x8,%esp
80105866:	85 c0                	test   %eax,%eax
80105868:	79 07                	jns    80105871 <argstr+0x20>
    return -1;
8010586a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010586f:	eb 0f                	jmp    80105880 <argstr+0x2f>
  return fetchstr(addr, pp);
80105871:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105874:	ff 75 0c             	pushl  0xc(%ebp)
80105877:	50                   	push   %eax
80105878:	e8 eb fe ff ff       	call   80105768 <fetchstr>
8010587d:	83 c4 08             	add    $0x8,%esp
}
80105880:	c9                   	leave  
80105881:	c3                   	ret    

80105882 <syscall>:
[SYS_close]   sys_close,
};

void
syscall(void)
{
80105882:	55                   	push   %ebp
80105883:	89 e5                	mov    %esp,%ebp
80105885:	53                   	push   %ebx
80105886:	83 ec 14             	sub    $0x14,%esp
  int num;

  num = proc->tf->eax;
80105889:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010588f:	8b 40 18             	mov    0x18(%eax),%eax
80105892:	8b 40 1c             	mov    0x1c(%eax),%eax
80105895:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80105898:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010589c:	7e 30                	jle    801058ce <syscall+0x4c>
8010589e:	8b 45 f4             	mov    -0xc(%ebp),%eax
801058a1:	83 f8 15             	cmp    $0x15,%eax
801058a4:	77 28                	ja     801058ce <syscall+0x4c>
801058a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801058a9:	8b 04 85 40 b0 10 80 	mov    -0x7fef4fc0(,%eax,4),%eax
801058b0:	85 c0                	test   %eax,%eax
801058b2:	74 1a                	je     801058ce <syscall+0x4c>
    proc->tf->eax = syscalls[num]();
801058b4:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801058ba:	8b 58 18             	mov    0x18(%eax),%ebx
801058bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801058c0:	8b 04 85 40 b0 10 80 	mov    -0x7fef4fc0(,%eax,4),%eax
801058c7:	ff d0                	call   *%eax
801058c9:	89 43 1c             	mov    %eax,0x1c(%ebx)
801058cc:	eb 34                	jmp    80105902 <syscall+0x80>
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            proc->pid, proc->name, num);
801058ce:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801058d4:	8d 50 6c             	lea    0x6c(%eax),%edx
801058d7:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax

  num = proc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    proc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
801058dd:	8b 40 10             	mov    0x10(%eax),%eax
801058e0:	ff 75 f4             	pushl  -0xc(%ebp)
801058e3:	52                   	push   %edx
801058e4:	50                   	push   %eax
801058e5:	68 bc 8b 10 80       	push   $0x80108bbc
801058ea:	e8 d0 aa ff ff       	call   801003bf <cprintf>
801058ef:	83 c4 10             	add    $0x10,%esp
            proc->pid, proc->name, num);
    proc->tf->eax = -1;
801058f2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801058f8:	8b 40 18             	mov    0x18(%eax),%eax
801058fb:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
  }
}
80105902:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105905:	c9                   	leave  
80105906:	c3                   	ret    

80105907 <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
80105907:	55                   	push   %ebp
80105908:	89 e5                	mov    %esp,%ebp
8010590a:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
8010590d:	83 ec 08             	sub    $0x8,%esp
80105910:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105913:	50                   	push   %eax
80105914:	ff 75 08             	pushl  0x8(%ebp)
80105917:	e8 ae fe ff ff       	call   801057ca <argint>
8010591c:	83 c4 10             	add    $0x10,%esp
8010591f:	85 c0                	test   %eax,%eax
80105921:	79 07                	jns    8010592a <argfd+0x23>
    return -1;
80105923:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105928:	eb 50                	jmp    8010597a <argfd+0x73>
  if(fd < 0 || fd >= NOFILE || (f=proc->ofile[fd]) == 0)
8010592a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010592d:	85 c0                	test   %eax,%eax
8010592f:	78 21                	js     80105952 <argfd+0x4b>
80105931:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105934:	83 f8 0f             	cmp    $0xf,%eax
80105937:	7f 19                	jg     80105952 <argfd+0x4b>
80105939:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010593f:	8b 55 f0             	mov    -0x10(%ebp),%edx
80105942:	83 c2 08             	add    $0x8,%edx
80105945:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80105949:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010594c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105950:	75 07                	jne    80105959 <argfd+0x52>
    return -1;
80105952:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105957:	eb 21                	jmp    8010597a <argfd+0x73>
  if(pfd)
80105959:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
8010595d:	74 08                	je     80105967 <argfd+0x60>
    *pfd = fd;
8010595f:	8b 55 f0             	mov    -0x10(%ebp),%edx
80105962:	8b 45 0c             	mov    0xc(%ebp),%eax
80105965:	89 10                	mov    %edx,(%eax)
  if(pf)
80105967:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010596b:	74 08                	je     80105975 <argfd+0x6e>
    *pf = f;
8010596d:	8b 45 10             	mov    0x10(%ebp),%eax
80105970:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105973:	89 10                	mov    %edx,(%eax)
  return 0;
80105975:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010597a:	c9                   	leave  
8010597b:	c3                   	ret    

8010597c <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
8010597c:	55                   	push   %ebp
8010597d:	89 e5                	mov    %esp,%ebp
8010597f:	83 ec 10             	sub    $0x10,%esp
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
80105982:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
80105989:	eb 30                	jmp    801059bb <fdalloc+0x3f>
    if(proc->ofile[fd] == 0){
8010598b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105991:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105994:	83 c2 08             	add    $0x8,%edx
80105997:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
8010599b:	85 c0                	test   %eax,%eax
8010599d:	75 18                	jne    801059b7 <fdalloc+0x3b>
      proc->ofile[fd] = f;
8010599f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801059a5:	8b 55 fc             	mov    -0x4(%ebp),%edx
801059a8:	8d 4a 08             	lea    0x8(%edx),%ecx
801059ab:	8b 55 08             	mov    0x8(%ebp),%edx
801059ae:	89 54 88 08          	mov    %edx,0x8(%eax,%ecx,4)
      return fd;
801059b2:	8b 45 fc             	mov    -0x4(%ebp),%eax
801059b5:	eb 0f                	jmp    801059c6 <fdalloc+0x4a>
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
801059b7:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
801059bb:	83 7d fc 0f          	cmpl   $0xf,-0x4(%ebp)
801059bf:	7e ca                	jle    8010598b <fdalloc+0xf>
    if(proc->ofile[fd] == 0){
      proc->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
801059c1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801059c6:	c9                   	leave  
801059c7:	c3                   	ret    

801059c8 <sys_dup>:

int
sys_dup(void)
{
801059c8:	55                   	push   %ebp
801059c9:	89 e5                	mov    %esp,%ebp
801059cb:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int fd;
  
  if(argfd(0, 0, &f) < 0)
801059ce:	83 ec 04             	sub    $0x4,%esp
801059d1:	8d 45 f0             	lea    -0x10(%ebp),%eax
801059d4:	50                   	push   %eax
801059d5:	6a 00                	push   $0x0
801059d7:	6a 00                	push   $0x0
801059d9:	e8 29 ff ff ff       	call   80105907 <argfd>
801059de:	83 c4 10             	add    $0x10,%esp
801059e1:	85 c0                	test   %eax,%eax
801059e3:	79 07                	jns    801059ec <sys_dup+0x24>
    return -1;
801059e5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801059ea:	eb 31                	jmp    80105a1d <sys_dup+0x55>
  if((fd=fdalloc(f)) < 0)
801059ec:	8b 45 f0             	mov    -0x10(%ebp),%eax
801059ef:	83 ec 0c             	sub    $0xc,%esp
801059f2:	50                   	push   %eax
801059f3:	e8 84 ff ff ff       	call   8010597c <fdalloc>
801059f8:	83 c4 10             	add    $0x10,%esp
801059fb:	89 45 f4             	mov    %eax,-0xc(%ebp)
801059fe:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105a02:	79 07                	jns    80105a0b <sys_dup+0x43>
    return -1;
80105a04:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105a09:	eb 12                	jmp    80105a1d <sys_dup+0x55>
  filedup(f);
80105a0b:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105a0e:	83 ec 0c             	sub    $0xc,%esp
80105a11:	50                   	push   %eax
80105a12:	e8 b0 b5 ff ff       	call   80100fc7 <filedup>
80105a17:	83 c4 10             	add    $0x10,%esp
  return fd;
80105a1a:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80105a1d:	c9                   	leave  
80105a1e:	c3                   	ret    

80105a1f <sys_read>:

int
sys_read(void)
{
80105a1f:	55                   	push   %ebp
80105a20:	89 e5                	mov    %esp,%ebp
80105a22:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105a25:	83 ec 04             	sub    $0x4,%esp
80105a28:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105a2b:	50                   	push   %eax
80105a2c:	6a 00                	push   $0x0
80105a2e:	6a 00                	push   $0x0
80105a30:	e8 d2 fe ff ff       	call   80105907 <argfd>
80105a35:	83 c4 10             	add    $0x10,%esp
80105a38:	85 c0                	test   %eax,%eax
80105a3a:	78 2e                	js     80105a6a <sys_read+0x4b>
80105a3c:	83 ec 08             	sub    $0x8,%esp
80105a3f:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105a42:	50                   	push   %eax
80105a43:	6a 02                	push   $0x2
80105a45:	e8 80 fd ff ff       	call   801057ca <argint>
80105a4a:	83 c4 10             	add    $0x10,%esp
80105a4d:	85 c0                	test   %eax,%eax
80105a4f:	78 19                	js     80105a6a <sys_read+0x4b>
80105a51:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105a54:	83 ec 04             	sub    $0x4,%esp
80105a57:	50                   	push   %eax
80105a58:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105a5b:	50                   	push   %eax
80105a5c:	6a 01                	push   $0x1
80105a5e:	e8 8f fd ff ff       	call   801057f2 <argptr>
80105a63:	83 c4 10             	add    $0x10,%esp
80105a66:	85 c0                	test   %eax,%eax
80105a68:	79 07                	jns    80105a71 <sys_read+0x52>
    return -1;
80105a6a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105a6f:	eb 17                	jmp    80105a88 <sys_read+0x69>
  return fileread(f, p, n);
80105a71:	8b 4d f0             	mov    -0x10(%ebp),%ecx
80105a74:	8b 55 ec             	mov    -0x14(%ebp),%edx
80105a77:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105a7a:	83 ec 04             	sub    $0x4,%esp
80105a7d:	51                   	push   %ecx
80105a7e:	52                   	push   %edx
80105a7f:	50                   	push   %eax
80105a80:	e8 d2 b6 ff ff       	call   80101157 <fileread>
80105a85:	83 c4 10             	add    $0x10,%esp
}
80105a88:	c9                   	leave  
80105a89:	c3                   	ret    

80105a8a <sys_write>:

int
sys_write(void)
{
80105a8a:	55                   	push   %ebp
80105a8b:	89 e5                	mov    %esp,%ebp
80105a8d:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105a90:	83 ec 04             	sub    $0x4,%esp
80105a93:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105a96:	50                   	push   %eax
80105a97:	6a 00                	push   $0x0
80105a99:	6a 00                	push   $0x0
80105a9b:	e8 67 fe ff ff       	call   80105907 <argfd>
80105aa0:	83 c4 10             	add    $0x10,%esp
80105aa3:	85 c0                	test   %eax,%eax
80105aa5:	78 2e                	js     80105ad5 <sys_write+0x4b>
80105aa7:	83 ec 08             	sub    $0x8,%esp
80105aaa:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105aad:	50                   	push   %eax
80105aae:	6a 02                	push   $0x2
80105ab0:	e8 15 fd ff ff       	call   801057ca <argint>
80105ab5:	83 c4 10             	add    $0x10,%esp
80105ab8:	85 c0                	test   %eax,%eax
80105aba:	78 19                	js     80105ad5 <sys_write+0x4b>
80105abc:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105abf:	83 ec 04             	sub    $0x4,%esp
80105ac2:	50                   	push   %eax
80105ac3:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105ac6:	50                   	push   %eax
80105ac7:	6a 01                	push   $0x1
80105ac9:	e8 24 fd ff ff       	call   801057f2 <argptr>
80105ace:	83 c4 10             	add    $0x10,%esp
80105ad1:	85 c0                	test   %eax,%eax
80105ad3:	79 07                	jns    80105adc <sys_write+0x52>
    return -1;
80105ad5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105ada:	eb 17                	jmp    80105af3 <sys_write+0x69>
  return filewrite(f, p, n);
80105adc:	8b 4d f0             	mov    -0x10(%ebp),%ecx
80105adf:	8b 55 ec             	mov    -0x14(%ebp),%edx
80105ae2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105ae5:	83 ec 04             	sub    $0x4,%esp
80105ae8:	51                   	push   %ecx
80105ae9:	52                   	push   %edx
80105aea:	50                   	push   %eax
80105aeb:	e8 1f b7 ff ff       	call   8010120f <filewrite>
80105af0:	83 c4 10             	add    $0x10,%esp
}
80105af3:	c9                   	leave  
80105af4:	c3                   	ret    

80105af5 <sys_close>:

int
sys_close(void)
{
80105af5:	55                   	push   %ebp
80105af6:	89 e5                	mov    %esp,%ebp
80105af8:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;
  
  if(argfd(0, &fd, &f) < 0)
80105afb:	83 ec 04             	sub    $0x4,%esp
80105afe:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105b01:	50                   	push   %eax
80105b02:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105b05:	50                   	push   %eax
80105b06:	6a 00                	push   $0x0
80105b08:	e8 fa fd ff ff       	call   80105907 <argfd>
80105b0d:	83 c4 10             	add    $0x10,%esp
80105b10:	85 c0                	test   %eax,%eax
80105b12:	79 07                	jns    80105b1b <sys_close+0x26>
    return -1;
80105b14:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b19:	eb 28                	jmp    80105b43 <sys_close+0x4e>
  proc->ofile[fd] = 0;
80105b1b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105b21:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105b24:	83 c2 08             	add    $0x8,%edx
80105b27:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
80105b2e:	00 
  fileclose(f);
80105b2f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105b32:	83 ec 0c             	sub    $0xc,%esp
80105b35:	50                   	push   %eax
80105b36:	e8 dd b4 ff ff       	call   80101018 <fileclose>
80105b3b:	83 c4 10             	add    $0x10,%esp
  return 0;
80105b3e:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105b43:	c9                   	leave  
80105b44:	c3                   	ret    

80105b45 <sys_fstat>:

int
sys_fstat(void)
{
80105b45:	55                   	push   %ebp
80105b46:	89 e5                	mov    %esp,%ebp
80105b48:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  struct stat *st;
  
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105b4b:	83 ec 04             	sub    $0x4,%esp
80105b4e:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105b51:	50                   	push   %eax
80105b52:	6a 00                	push   $0x0
80105b54:	6a 00                	push   $0x0
80105b56:	e8 ac fd ff ff       	call   80105907 <argfd>
80105b5b:	83 c4 10             	add    $0x10,%esp
80105b5e:	85 c0                	test   %eax,%eax
80105b60:	78 17                	js     80105b79 <sys_fstat+0x34>
80105b62:	83 ec 04             	sub    $0x4,%esp
80105b65:	6a 14                	push   $0x14
80105b67:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105b6a:	50                   	push   %eax
80105b6b:	6a 01                	push   $0x1
80105b6d:	e8 80 fc ff ff       	call   801057f2 <argptr>
80105b72:	83 c4 10             	add    $0x10,%esp
80105b75:	85 c0                	test   %eax,%eax
80105b77:	79 07                	jns    80105b80 <sys_fstat+0x3b>
    return -1;
80105b79:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b7e:	eb 13                	jmp    80105b93 <sys_fstat+0x4e>
  return filestat(f, st);
80105b80:	8b 55 f0             	mov    -0x10(%ebp),%edx
80105b83:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105b86:	83 ec 08             	sub    $0x8,%esp
80105b89:	52                   	push   %edx
80105b8a:	50                   	push   %eax
80105b8b:	e8 70 b5 ff ff       	call   80101100 <filestat>
80105b90:	83 c4 10             	add    $0x10,%esp
}
80105b93:	c9                   	leave  
80105b94:	c3                   	ret    

80105b95 <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80105b95:	55                   	push   %ebp
80105b96:	89 e5                	mov    %esp,%ebp
80105b98:	83 ec 28             	sub    $0x28,%esp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105b9b:	83 ec 08             	sub    $0x8,%esp
80105b9e:	8d 45 d8             	lea    -0x28(%ebp),%eax
80105ba1:	50                   	push   %eax
80105ba2:	6a 00                	push   $0x0
80105ba4:	e8 a8 fc ff ff       	call   80105851 <argstr>
80105ba9:	83 c4 10             	add    $0x10,%esp
80105bac:	85 c0                	test   %eax,%eax
80105bae:	78 15                	js     80105bc5 <sys_link+0x30>
80105bb0:	83 ec 08             	sub    $0x8,%esp
80105bb3:	8d 45 dc             	lea    -0x24(%ebp),%eax
80105bb6:	50                   	push   %eax
80105bb7:	6a 01                	push   $0x1
80105bb9:	e8 93 fc ff ff       	call   80105851 <argstr>
80105bbe:	83 c4 10             	add    $0x10,%esp
80105bc1:	85 c0                	test   %eax,%eax
80105bc3:	79 0a                	jns    80105bcf <sys_link+0x3a>
    return -1;
80105bc5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105bca:	e9 69 01 00 00       	jmp    80105d38 <sys_link+0x1a3>

  begin_op();
80105bcf:	e8 19 d9 ff ff       	call   801034ed <begin_op>
  if((ip = namei(old)) == 0){
80105bd4:	8b 45 d8             	mov    -0x28(%ebp),%eax
80105bd7:	83 ec 0c             	sub    $0xc,%esp
80105bda:	50                   	push   %eax
80105bdb:	e8 04 c9 ff ff       	call   801024e4 <namei>
80105be0:	83 c4 10             	add    $0x10,%esp
80105be3:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105be6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105bea:	75 0f                	jne    80105bfb <sys_link+0x66>
    end_op();
80105bec:	e8 8a d9 ff ff       	call   8010357b <end_op>
    return -1;
80105bf1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105bf6:	e9 3d 01 00 00       	jmp    80105d38 <sys_link+0x1a3>
  }

  ilock(ip);
80105bfb:	83 ec 0c             	sub    $0xc,%esp
80105bfe:	ff 75 f4             	pushl  -0xc(%ebp)
80105c01:	e8 23 bd ff ff       	call   80101929 <ilock>
80105c06:	83 c4 10             	add    $0x10,%esp
  if(ip->type == T_DIR){
80105c09:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105c0c:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105c10:	66 83 f8 01          	cmp    $0x1,%ax
80105c14:	75 1d                	jne    80105c33 <sys_link+0x9e>
    iunlockput(ip);
80105c16:	83 ec 0c             	sub    $0xc,%esp
80105c19:	ff 75 f4             	pushl  -0xc(%ebp)
80105c1c:	e8 c5 bf ff ff       	call   80101be6 <iunlockput>
80105c21:	83 c4 10             	add    $0x10,%esp
    end_op();
80105c24:	e8 52 d9 ff ff       	call   8010357b <end_op>
    return -1;
80105c29:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105c2e:	e9 05 01 00 00       	jmp    80105d38 <sys_link+0x1a3>
  }

  ip->nlink++;
80105c33:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105c36:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105c3a:	83 c0 01             	add    $0x1,%eax
80105c3d:	89 c2                	mov    %eax,%edx
80105c3f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105c42:	66 89 50 16          	mov    %dx,0x16(%eax)
  iupdate(ip);
80105c46:	83 ec 0c             	sub    $0xc,%esp
80105c49:	ff 75 f4             	pushl  -0xc(%ebp)
80105c4c:	e8 ff ba ff ff       	call   80101750 <iupdate>
80105c51:	83 c4 10             	add    $0x10,%esp
  iunlock(ip);
80105c54:	83 ec 0c             	sub    $0xc,%esp
80105c57:	ff 75 f4             	pushl  -0xc(%ebp)
80105c5a:	e8 27 be ff ff       	call   80101a86 <iunlock>
80105c5f:	83 c4 10             	add    $0x10,%esp

  if((dp = nameiparent(new, name)) == 0)
80105c62:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105c65:	83 ec 08             	sub    $0x8,%esp
80105c68:	8d 55 e2             	lea    -0x1e(%ebp),%edx
80105c6b:	52                   	push   %edx
80105c6c:	50                   	push   %eax
80105c6d:	e8 8e c8 ff ff       	call   80102500 <nameiparent>
80105c72:	83 c4 10             	add    $0x10,%esp
80105c75:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105c78:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105c7c:	75 02                	jne    80105c80 <sys_link+0xeb>
    goto bad;
80105c7e:	eb 71                	jmp    80105cf1 <sys_link+0x15c>
  ilock(dp);
80105c80:	83 ec 0c             	sub    $0xc,%esp
80105c83:	ff 75 f0             	pushl  -0x10(%ebp)
80105c86:	e8 9e bc ff ff       	call   80101929 <ilock>
80105c8b:	83 c4 10             	add    $0x10,%esp
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105c8e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105c91:	8b 10                	mov    (%eax),%edx
80105c93:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105c96:	8b 00                	mov    (%eax),%eax
80105c98:	39 c2                	cmp    %eax,%edx
80105c9a:	75 1d                	jne    80105cb9 <sys_link+0x124>
80105c9c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105c9f:	8b 40 04             	mov    0x4(%eax),%eax
80105ca2:	83 ec 04             	sub    $0x4,%esp
80105ca5:	50                   	push   %eax
80105ca6:	8d 45 e2             	lea    -0x1e(%ebp),%eax
80105ca9:	50                   	push   %eax
80105caa:	ff 75 f0             	pushl  -0x10(%ebp)
80105cad:	e8 9a c5 ff ff       	call   8010224c <dirlink>
80105cb2:	83 c4 10             	add    $0x10,%esp
80105cb5:	85 c0                	test   %eax,%eax
80105cb7:	79 10                	jns    80105cc9 <sys_link+0x134>
    iunlockput(dp);
80105cb9:	83 ec 0c             	sub    $0xc,%esp
80105cbc:	ff 75 f0             	pushl  -0x10(%ebp)
80105cbf:	e8 22 bf ff ff       	call   80101be6 <iunlockput>
80105cc4:	83 c4 10             	add    $0x10,%esp
    goto bad;
80105cc7:	eb 28                	jmp    80105cf1 <sys_link+0x15c>
  }
  iunlockput(dp);
80105cc9:	83 ec 0c             	sub    $0xc,%esp
80105ccc:	ff 75 f0             	pushl  -0x10(%ebp)
80105ccf:	e8 12 bf ff ff       	call   80101be6 <iunlockput>
80105cd4:	83 c4 10             	add    $0x10,%esp
  iput(ip);
80105cd7:	83 ec 0c             	sub    $0xc,%esp
80105cda:	ff 75 f4             	pushl  -0xc(%ebp)
80105cdd:	e8 15 be ff ff       	call   80101af7 <iput>
80105ce2:	83 c4 10             	add    $0x10,%esp

  end_op();
80105ce5:	e8 91 d8 ff ff       	call   8010357b <end_op>

  return 0;
80105cea:	b8 00 00 00 00       	mov    $0x0,%eax
80105cef:	eb 47                	jmp    80105d38 <sys_link+0x1a3>

bad:
  ilock(ip);
80105cf1:	83 ec 0c             	sub    $0xc,%esp
80105cf4:	ff 75 f4             	pushl  -0xc(%ebp)
80105cf7:	e8 2d bc ff ff       	call   80101929 <ilock>
80105cfc:	83 c4 10             	add    $0x10,%esp
  ip->nlink--;
80105cff:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105d02:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105d06:	83 e8 01             	sub    $0x1,%eax
80105d09:	89 c2                	mov    %eax,%edx
80105d0b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105d0e:	66 89 50 16          	mov    %dx,0x16(%eax)
  iupdate(ip);
80105d12:	83 ec 0c             	sub    $0xc,%esp
80105d15:	ff 75 f4             	pushl  -0xc(%ebp)
80105d18:	e8 33 ba ff ff       	call   80101750 <iupdate>
80105d1d:	83 c4 10             	add    $0x10,%esp
  iunlockput(ip);
80105d20:	83 ec 0c             	sub    $0xc,%esp
80105d23:	ff 75 f4             	pushl  -0xc(%ebp)
80105d26:	e8 bb be ff ff       	call   80101be6 <iunlockput>
80105d2b:	83 c4 10             	add    $0x10,%esp
  end_op();
80105d2e:	e8 48 d8 ff ff       	call   8010357b <end_op>
  return -1;
80105d33:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105d38:	c9                   	leave  
80105d39:	c3                   	ret    

80105d3a <isdirempty>:

// Is the directory dp empty except for "." and ".." ?
static int
isdirempty(struct inode *dp)
{
80105d3a:	55                   	push   %ebp
80105d3b:	89 e5                	mov    %esp,%ebp
80105d3d:	83 ec 28             	sub    $0x28,%esp
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105d40:	c7 45 f4 20 00 00 00 	movl   $0x20,-0xc(%ebp)
80105d47:	eb 40                	jmp    80105d89 <isdirempty+0x4f>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105d49:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105d4c:	6a 10                	push   $0x10
80105d4e:	50                   	push   %eax
80105d4f:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105d52:	50                   	push   %eax
80105d53:	ff 75 08             	pushl  0x8(%ebp)
80105d56:	e8 36 c1 ff ff       	call   80101e91 <readi>
80105d5b:	83 c4 10             	add    $0x10,%esp
80105d5e:	83 f8 10             	cmp    $0x10,%eax
80105d61:	74 0d                	je     80105d70 <isdirempty+0x36>
      panic("isdirempty: readi");
80105d63:	83 ec 0c             	sub    $0xc,%esp
80105d66:	68 d8 8b 10 80       	push   $0x80108bd8
80105d6b:	e8 ec a7 ff ff       	call   8010055c <panic>
    if(de.inum != 0)
80105d70:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80105d74:	66 85 c0             	test   %ax,%ax
80105d77:	74 07                	je     80105d80 <isdirempty+0x46>
      return 0;
80105d79:	b8 00 00 00 00       	mov    $0x0,%eax
80105d7e:	eb 1b                	jmp    80105d9b <isdirempty+0x61>
isdirempty(struct inode *dp)
{
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105d80:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105d83:	83 c0 10             	add    $0x10,%eax
80105d86:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105d89:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105d8c:	8b 45 08             	mov    0x8(%ebp),%eax
80105d8f:	8b 40 18             	mov    0x18(%eax),%eax
80105d92:	39 c2                	cmp    %eax,%edx
80105d94:	72 b3                	jb     80105d49 <isdirempty+0xf>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("isdirempty: readi");
    if(de.inum != 0)
      return 0;
  }
  return 1;
80105d96:	b8 01 00 00 00       	mov    $0x1,%eax
}
80105d9b:	c9                   	leave  
80105d9c:	c3                   	ret    

80105d9d <sys_unlink>:

//PAGEBREAK!
int
sys_unlink(void)
{
80105d9d:	55                   	push   %ebp
80105d9e:	89 e5                	mov    %esp,%ebp
80105da0:	83 ec 38             	sub    $0x38,%esp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
80105da3:	83 ec 08             	sub    $0x8,%esp
80105da6:	8d 45 cc             	lea    -0x34(%ebp),%eax
80105da9:	50                   	push   %eax
80105daa:	6a 00                	push   $0x0
80105dac:	e8 a0 fa ff ff       	call   80105851 <argstr>
80105db1:	83 c4 10             	add    $0x10,%esp
80105db4:	85 c0                	test   %eax,%eax
80105db6:	79 0a                	jns    80105dc2 <sys_unlink+0x25>
    return -1;
80105db8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105dbd:	e9 bc 01 00 00       	jmp    80105f7e <sys_unlink+0x1e1>

  begin_op();
80105dc2:	e8 26 d7 ff ff       	call   801034ed <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105dc7:	8b 45 cc             	mov    -0x34(%ebp),%eax
80105dca:	83 ec 08             	sub    $0x8,%esp
80105dcd:	8d 55 d2             	lea    -0x2e(%ebp),%edx
80105dd0:	52                   	push   %edx
80105dd1:	50                   	push   %eax
80105dd2:	e8 29 c7 ff ff       	call   80102500 <nameiparent>
80105dd7:	83 c4 10             	add    $0x10,%esp
80105dda:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105ddd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105de1:	75 0f                	jne    80105df2 <sys_unlink+0x55>
    end_op();
80105de3:	e8 93 d7 ff ff       	call   8010357b <end_op>
    return -1;
80105de8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105ded:	e9 8c 01 00 00       	jmp    80105f7e <sys_unlink+0x1e1>
  }

  ilock(dp);
80105df2:	83 ec 0c             	sub    $0xc,%esp
80105df5:	ff 75 f4             	pushl  -0xc(%ebp)
80105df8:	e8 2c bb ff ff       	call   80101929 <ilock>
80105dfd:	83 c4 10             	add    $0x10,%esp

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80105e00:	83 ec 08             	sub    $0x8,%esp
80105e03:	68 ea 8b 10 80       	push   $0x80108bea
80105e08:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80105e0b:	50                   	push   %eax
80105e0c:	e8 65 c3 ff ff       	call   80102176 <namecmp>
80105e11:	83 c4 10             	add    $0x10,%esp
80105e14:	85 c0                	test   %eax,%eax
80105e16:	0f 84 4a 01 00 00    	je     80105f66 <sys_unlink+0x1c9>
80105e1c:	83 ec 08             	sub    $0x8,%esp
80105e1f:	68 ec 8b 10 80       	push   $0x80108bec
80105e24:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80105e27:	50                   	push   %eax
80105e28:	e8 49 c3 ff ff       	call   80102176 <namecmp>
80105e2d:	83 c4 10             	add    $0x10,%esp
80105e30:	85 c0                	test   %eax,%eax
80105e32:	0f 84 2e 01 00 00    	je     80105f66 <sys_unlink+0x1c9>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
80105e38:	83 ec 04             	sub    $0x4,%esp
80105e3b:	8d 45 c8             	lea    -0x38(%ebp),%eax
80105e3e:	50                   	push   %eax
80105e3f:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80105e42:	50                   	push   %eax
80105e43:	ff 75 f4             	pushl  -0xc(%ebp)
80105e46:	e8 46 c3 ff ff       	call   80102191 <dirlookup>
80105e4b:	83 c4 10             	add    $0x10,%esp
80105e4e:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105e51:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105e55:	75 05                	jne    80105e5c <sys_unlink+0xbf>
    goto bad;
80105e57:	e9 0a 01 00 00       	jmp    80105f66 <sys_unlink+0x1c9>
  ilock(ip);
80105e5c:	83 ec 0c             	sub    $0xc,%esp
80105e5f:	ff 75 f0             	pushl  -0x10(%ebp)
80105e62:	e8 c2 ba ff ff       	call   80101929 <ilock>
80105e67:	83 c4 10             	add    $0x10,%esp

  if(ip->nlink < 1)
80105e6a:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105e6d:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105e71:	66 85 c0             	test   %ax,%ax
80105e74:	7f 0d                	jg     80105e83 <sys_unlink+0xe6>
    panic("unlink: nlink < 1");
80105e76:	83 ec 0c             	sub    $0xc,%esp
80105e79:	68 ef 8b 10 80       	push   $0x80108bef
80105e7e:	e8 d9 a6 ff ff       	call   8010055c <panic>
  if(ip->type == T_DIR && !isdirempty(ip)){
80105e83:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105e86:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105e8a:	66 83 f8 01          	cmp    $0x1,%ax
80105e8e:	75 25                	jne    80105eb5 <sys_unlink+0x118>
80105e90:	83 ec 0c             	sub    $0xc,%esp
80105e93:	ff 75 f0             	pushl  -0x10(%ebp)
80105e96:	e8 9f fe ff ff       	call   80105d3a <isdirempty>
80105e9b:	83 c4 10             	add    $0x10,%esp
80105e9e:	85 c0                	test   %eax,%eax
80105ea0:	75 13                	jne    80105eb5 <sys_unlink+0x118>
    iunlockput(ip);
80105ea2:	83 ec 0c             	sub    $0xc,%esp
80105ea5:	ff 75 f0             	pushl  -0x10(%ebp)
80105ea8:	e8 39 bd ff ff       	call   80101be6 <iunlockput>
80105ead:	83 c4 10             	add    $0x10,%esp
    goto bad;
80105eb0:	e9 b1 00 00 00       	jmp    80105f66 <sys_unlink+0x1c9>
  }

  memset(&de, 0, sizeof(de));
80105eb5:	83 ec 04             	sub    $0x4,%esp
80105eb8:	6a 10                	push   $0x10
80105eba:	6a 00                	push   $0x0
80105ebc:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105ebf:	50                   	push   %eax
80105ec0:	e8 de f5 ff ff       	call   801054a3 <memset>
80105ec5:	83 c4 10             	add    $0x10,%esp
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105ec8:	8b 45 c8             	mov    -0x38(%ebp),%eax
80105ecb:	6a 10                	push   $0x10
80105ecd:	50                   	push   %eax
80105ece:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105ed1:	50                   	push   %eax
80105ed2:	ff 75 f4             	pushl  -0xc(%ebp)
80105ed5:	e8 11 c1 ff ff       	call   80101feb <writei>
80105eda:	83 c4 10             	add    $0x10,%esp
80105edd:	83 f8 10             	cmp    $0x10,%eax
80105ee0:	74 0d                	je     80105eef <sys_unlink+0x152>
    panic("unlink: writei");
80105ee2:	83 ec 0c             	sub    $0xc,%esp
80105ee5:	68 01 8c 10 80       	push   $0x80108c01
80105eea:	e8 6d a6 ff ff       	call   8010055c <panic>
  if(ip->type == T_DIR){
80105eef:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105ef2:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105ef6:	66 83 f8 01          	cmp    $0x1,%ax
80105efa:	75 21                	jne    80105f1d <sys_unlink+0x180>
    dp->nlink--;
80105efc:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105eff:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105f03:	83 e8 01             	sub    $0x1,%eax
80105f06:	89 c2                	mov    %eax,%edx
80105f08:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105f0b:	66 89 50 16          	mov    %dx,0x16(%eax)
    iupdate(dp);
80105f0f:	83 ec 0c             	sub    $0xc,%esp
80105f12:	ff 75 f4             	pushl  -0xc(%ebp)
80105f15:	e8 36 b8 ff ff       	call   80101750 <iupdate>
80105f1a:	83 c4 10             	add    $0x10,%esp
  }
  iunlockput(dp);
80105f1d:	83 ec 0c             	sub    $0xc,%esp
80105f20:	ff 75 f4             	pushl  -0xc(%ebp)
80105f23:	e8 be bc ff ff       	call   80101be6 <iunlockput>
80105f28:	83 c4 10             	add    $0x10,%esp

  ip->nlink--;
80105f2b:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105f2e:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105f32:	83 e8 01             	sub    $0x1,%eax
80105f35:	89 c2                	mov    %eax,%edx
80105f37:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105f3a:	66 89 50 16          	mov    %dx,0x16(%eax)
  iupdate(ip);
80105f3e:	83 ec 0c             	sub    $0xc,%esp
80105f41:	ff 75 f0             	pushl  -0x10(%ebp)
80105f44:	e8 07 b8 ff ff       	call   80101750 <iupdate>
80105f49:	83 c4 10             	add    $0x10,%esp
  iunlockput(ip);
80105f4c:	83 ec 0c             	sub    $0xc,%esp
80105f4f:	ff 75 f0             	pushl  -0x10(%ebp)
80105f52:	e8 8f bc ff ff       	call   80101be6 <iunlockput>
80105f57:	83 c4 10             	add    $0x10,%esp

  end_op();
80105f5a:	e8 1c d6 ff ff       	call   8010357b <end_op>

  return 0;
80105f5f:	b8 00 00 00 00       	mov    $0x0,%eax
80105f64:	eb 18                	jmp    80105f7e <sys_unlink+0x1e1>

bad:
  iunlockput(dp);
80105f66:	83 ec 0c             	sub    $0xc,%esp
80105f69:	ff 75 f4             	pushl  -0xc(%ebp)
80105f6c:	e8 75 bc ff ff       	call   80101be6 <iunlockput>
80105f71:	83 c4 10             	add    $0x10,%esp
  end_op();
80105f74:	e8 02 d6 ff ff       	call   8010357b <end_op>
  return -1;
80105f79:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105f7e:	c9                   	leave  
80105f7f:	c3                   	ret    

80105f80 <create>:

static struct inode*
create(char *path, short type, short major, short minor)
{
80105f80:	55                   	push   %ebp
80105f81:	89 e5                	mov    %esp,%ebp
80105f83:	83 ec 38             	sub    $0x38,%esp
80105f86:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80105f89:	8b 55 10             	mov    0x10(%ebp),%edx
80105f8c:	8b 45 14             	mov    0x14(%ebp),%eax
80105f8f:	66 89 4d d4          	mov    %cx,-0x2c(%ebp)
80105f93:	66 89 55 d0          	mov    %dx,-0x30(%ebp)
80105f97:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80105f9b:	83 ec 08             	sub    $0x8,%esp
80105f9e:	8d 45 de             	lea    -0x22(%ebp),%eax
80105fa1:	50                   	push   %eax
80105fa2:	ff 75 08             	pushl  0x8(%ebp)
80105fa5:	e8 56 c5 ff ff       	call   80102500 <nameiparent>
80105faa:	83 c4 10             	add    $0x10,%esp
80105fad:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105fb0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105fb4:	75 0a                	jne    80105fc0 <create+0x40>
    return 0;
80105fb6:	b8 00 00 00 00       	mov    $0x0,%eax
80105fbb:	e9 90 01 00 00       	jmp    80106150 <create+0x1d0>
  ilock(dp);
80105fc0:	83 ec 0c             	sub    $0xc,%esp
80105fc3:	ff 75 f4             	pushl  -0xc(%ebp)
80105fc6:	e8 5e b9 ff ff       	call   80101929 <ilock>
80105fcb:	83 c4 10             	add    $0x10,%esp

  if((ip = dirlookup(dp, name, &off)) != 0){
80105fce:	83 ec 04             	sub    $0x4,%esp
80105fd1:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105fd4:	50                   	push   %eax
80105fd5:	8d 45 de             	lea    -0x22(%ebp),%eax
80105fd8:	50                   	push   %eax
80105fd9:	ff 75 f4             	pushl  -0xc(%ebp)
80105fdc:	e8 b0 c1 ff ff       	call   80102191 <dirlookup>
80105fe1:	83 c4 10             	add    $0x10,%esp
80105fe4:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105fe7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105feb:	74 50                	je     8010603d <create+0xbd>
    iunlockput(dp);
80105fed:	83 ec 0c             	sub    $0xc,%esp
80105ff0:	ff 75 f4             	pushl  -0xc(%ebp)
80105ff3:	e8 ee bb ff ff       	call   80101be6 <iunlockput>
80105ff8:	83 c4 10             	add    $0x10,%esp
    ilock(ip);
80105ffb:	83 ec 0c             	sub    $0xc,%esp
80105ffe:	ff 75 f0             	pushl  -0x10(%ebp)
80106001:	e8 23 b9 ff ff       	call   80101929 <ilock>
80106006:	83 c4 10             	add    $0x10,%esp
    if(type == T_FILE && ip->type == T_FILE)
80106009:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
8010600e:	75 15                	jne    80106025 <create+0xa5>
80106010:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106013:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80106017:	66 83 f8 02          	cmp    $0x2,%ax
8010601b:	75 08                	jne    80106025 <create+0xa5>
      return ip;
8010601d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106020:	e9 2b 01 00 00       	jmp    80106150 <create+0x1d0>
    iunlockput(ip);
80106025:	83 ec 0c             	sub    $0xc,%esp
80106028:	ff 75 f0             	pushl  -0x10(%ebp)
8010602b:	e8 b6 bb ff ff       	call   80101be6 <iunlockput>
80106030:	83 c4 10             	add    $0x10,%esp
    return 0;
80106033:	b8 00 00 00 00       	mov    $0x0,%eax
80106038:	e9 13 01 00 00       	jmp    80106150 <create+0x1d0>
  }

  if((ip = ialloc(dp->dev, type)) == 0)
8010603d:	0f bf 55 d4          	movswl -0x2c(%ebp),%edx
80106041:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106044:	8b 00                	mov    (%eax),%eax
80106046:	83 ec 08             	sub    $0x8,%esp
80106049:	52                   	push   %edx
8010604a:	50                   	push   %eax
8010604b:	e8 2a b6 ff ff       	call   8010167a <ialloc>
80106050:	83 c4 10             	add    $0x10,%esp
80106053:	89 45 f0             	mov    %eax,-0x10(%ebp)
80106056:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010605a:	75 0d                	jne    80106069 <create+0xe9>
    panic("create: ialloc");
8010605c:	83 ec 0c             	sub    $0xc,%esp
8010605f:	68 10 8c 10 80       	push   $0x80108c10
80106064:	e8 f3 a4 ff ff       	call   8010055c <panic>

  ilock(ip);
80106069:	83 ec 0c             	sub    $0xc,%esp
8010606c:	ff 75 f0             	pushl  -0x10(%ebp)
8010606f:	e8 b5 b8 ff ff       	call   80101929 <ilock>
80106074:	83 c4 10             	add    $0x10,%esp
  ip->major = major;
80106077:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010607a:	0f b7 55 d0          	movzwl -0x30(%ebp),%edx
8010607e:	66 89 50 12          	mov    %dx,0x12(%eax)
  ip->minor = minor;
80106082:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106085:	0f b7 55 cc          	movzwl -0x34(%ebp),%edx
80106089:	66 89 50 14          	mov    %dx,0x14(%eax)
  ip->nlink = 1;
8010608d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106090:	66 c7 40 16 01 00    	movw   $0x1,0x16(%eax)
  iupdate(ip);
80106096:	83 ec 0c             	sub    $0xc,%esp
80106099:	ff 75 f0             	pushl  -0x10(%ebp)
8010609c:	e8 af b6 ff ff       	call   80101750 <iupdate>
801060a1:	83 c4 10             	add    $0x10,%esp

  if(type == T_DIR){  // Create . and .. entries.
801060a4:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
801060a9:	75 6a                	jne    80106115 <create+0x195>
    dp->nlink++;  // for ".."
801060ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
801060ae:	0f b7 40 16          	movzwl 0x16(%eax),%eax
801060b2:	83 c0 01             	add    $0x1,%eax
801060b5:	89 c2                	mov    %eax,%edx
801060b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801060ba:	66 89 50 16          	mov    %dx,0x16(%eax)
    iupdate(dp);
801060be:	83 ec 0c             	sub    $0xc,%esp
801060c1:	ff 75 f4             	pushl  -0xc(%ebp)
801060c4:	e8 87 b6 ff ff       	call   80101750 <iupdate>
801060c9:	83 c4 10             	add    $0x10,%esp
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
801060cc:	8b 45 f0             	mov    -0x10(%ebp),%eax
801060cf:	8b 40 04             	mov    0x4(%eax),%eax
801060d2:	83 ec 04             	sub    $0x4,%esp
801060d5:	50                   	push   %eax
801060d6:	68 ea 8b 10 80       	push   $0x80108bea
801060db:	ff 75 f0             	pushl  -0x10(%ebp)
801060de:	e8 69 c1 ff ff       	call   8010224c <dirlink>
801060e3:	83 c4 10             	add    $0x10,%esp
801060e6:	85 c0                	test   %eax,%eax
801060e8:	78 1e                	js     80106108 <create+0x188>
801060ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
801060ed:	8b 40 04             	mov    0x4(%eax),%eax
801060f0:	83 ec 04             	sub    $0x4,%esp
801060f3:	50                   	push   %eax
801060f4:	68 ec 8b 10 80       	push   $0x80108bec
801060f9:	ff 75 f0             	pushl  -0x10(%ebp)
801060fc:	e8 4b c1 ff ff       	call   8010224c <dirlink>
80106101:	83 c4 10             	add    $0x10,%esp
80106104:	85 c0                	test   %eax,%eax
80106106:	79 0d                	jns    80106115 <create+0x195>
      panic("create dots");
80106108:	83 ec 0c             	sub    $0xc,%esp
8010610b:	68 1f 8c 10 80       	push   $0x80108c1f
80106110:	e8 47 a4 ff ff       	call   8010055c <panic>
  }

  if(dirlink(dp, name, ip->inum) < 0)
80106115:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106118:	8b 40 04             	mov    0x4(%eax),%eax
8010611b:	83 ec 04             	sub    $0x4,%esp
8010611e:	50                   	push   %eax
8010611f:	8d 45 de             	lea    -0x22(%ebp),%eax
80106122:	50                   	push   %eax
80106123:	ff 75 f4             	pushl  -0xc(%ebp)
80106126:	e8 21 c1 ff ff       	call   8010224c <dirlink>
8010612b:	83 c4 10             	add    $0x10,%esp
8010612e:	85 c0                	test   %eax,%eax
80106130:	79 0d                	jns    8010613f <create+0x1bf>
    panic("create: dirlink");
80106132:	83 ec 0c             	sub    $0xc,%esp
80106135:	68 2b 8c 10 80       	push   $0x80108c2b
8010613a:	e8 1d a4 ff ff       	call   8010055c <panic>

  iunlockput(dp);
8010613f:	83 ec 0c             	sub    $0xc,%esp
80106142:	ff 75 f4             	pushl  -0xc(%ebp)
80106145:	e8 9c ba ff ff       	call   80101be6 <iunlockput>
8010614a:	83 c4 10             	add    $0x10,%esp

  return ip;
8010614d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80106150:	c9                   	leave  
80106151:	c3                   	ret    

80106152 <sys_open>:

int
sys_open(void)
{
80106152:	55                   	push   %ebp
80106153:	89 e5                	mov    %esp,%ebp
80106155:	83 ec 28             	sub    $0x28,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80106158:	83 ec 08             	sub    $0x8,%esp
8010615b:	8d 45 e8             	lea    -0x18(%ebp),%eax
8010615e:	50                   	push   %eax
8010615f:	6a 00                	push   $0x0
80106161:	e8 eb f6 ff ff       	call   80105851 <argstr>
80106166:	83 c4 10             	add    $0x10,%esp
80106169:	85 c0                	test   %eax,%eax
8010616b:	78 15                	js     80106182 <sys_open+0x30>
8010616d:	83 ec 08             	sub    $0x8,%esp
80106170:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106173:	50                   	push   %eax
80106174:	6a 01                	push   $0x1
80106176:	e8 4f f6 ff ff       	call   801057ca <argint>
8010617b:	83 c4 10             	add    $0x10,%esp
8010617e:	85 c0                	test   %eax,%eax
80106180:	79 0a                	jns    8010618c <sys_open+0x3a>
    return -1;
80106182:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106187:	e9 61 01 00 00       	jmp    801062ed <sys_open+0x19b>

  begin_op();
8010618c:	e8 5c d3 ff ff       	call   801034ed <begin_op>

  if(omode & O_CREATE){
80106191:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106194:	25 00 02 00 00       	and    $0x200,%eax
80106199:	85 c0                	test   %eax,%eax
8010619b:	74 2a                	je     801061c7 <sys_open+0x75>
    ip = create(path, T_FILE, 0, 0);
8010619d:	8b 45 e8             	mov    -0x18(%ebp),%eax
801061a0:	6a 00                	push   $0x0
801061a2:	6a 00                	push   $0x0
801061a4:	6a 02                	push   $0x2
801061a6:	50                   	push   %eax
801061a7:	e8 d4 fd ff ff       	call   80105f80 <create>
801061ac:	83 c4 10             	add    $0x10,%esp
801061af:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(ip == 0){
801061b2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801061b6:	75 75                	jne    8010622d <sys_open+0xdb>
      end_op();
801061b8:	e8 be d3 ff ff       	call   8010357b <end_op>
      return -1;
801061bd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801061c2:	e9 26 01 00 00       	jmp    801062ed <sys_open+0x19b>
    }
  } else {
    if((ip = namei(path)) == 0){
801061c7:	8b 45 e8             	mov    -0x18(%ebp),%eax
801061ca:	83 ec 0c             	sub    $0xc,%esp
801061cd:	50                   	push   %eax
801061ce:	e8 11 c3 ff ff       	call   801024e4 <namei>
801061d3:	83 c4 10             	add    $0x10,%esp
801061d6:	89 45 f4             	mov    %eax,-0xc(%ebp)
801061d9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801061dd:	75 0f                	jne    801061ee <sys_open+0x9c>
      end_op();
801061df:	e8 97 d3 ff ff       	call   8010357b <end_op>
      return -1;
801061e4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801061e9:	e9 ff 00 00 00       	jmp    801062ed <sys_open+0x19b>
    }
    ilock(ip);
801061ee:	83 ec 0c             	sub    $0xc,%esp
801061f1:	ff 75 f4             	pushl  -0xc(%ebp)
801061f4:	e8 30 b7 ff ff       	call   80101929 <ilock>
801061f9:	83 c4 10             	add    $0x10,%esp
    if(ip->type == T_DIR && omode != O_RDONLY){
801061fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801061ff:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80106203:	66 83 f8 01          	cmp    $0x1,%ax
80106207:	75 24                	jne    8010622d <sys_open+0xdb>
80106209:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010620c:	85 c0                	test   %eax,%eax
8010620e:	74 1d                	je     8010622d <sys_open+0xdb>
      iunlockput(ip);
80106210:	83 ec 0c             	sub    $0xc,%esp
80106213:	ff 75 f4             	pushl  -0xc(%ebp)
80106216:	e8 cb b9 ff ff       	call   80101be6 <iunlockput>
8010621b:	83 c4 10             	add    $0x10,%esp
      end_op();
8010621e:	e8 58 d3 ff ff       	call   8010357b <end_op>
      return -1;
80106223:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106228:	e9 c0 00 00 00       	jmp    801062ed <sys_open+0x19b>
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
8010622d:	e8 29 ad ff ff       	call   80100f5b <filealloc>
80106232:	89 45 f0             	mov    %eax,-0x10(%ebp)
80106235:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80106239:	74 17                	je     80106252 <sys_open+0x100>
8010623b:	83 ec 0c             	sub    $0xc,%esp
8010623e:	ff 75 f0             	pushl  -0x10(%ebp)
80106241:	e8 36 f7 ff ff       	call   8010597c <fdalloc>
80106246:	83 c4 10             	add    $0x10,%esp
80106249:	89 45 ec             	mov    %eax,-0x14(%ebp)
8010624c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80106250:	79 2e                	jns    80106280 <sys_open+0x12e>
    if(f)
80106252:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80106256:	74 0e                	je     80106266 <sys_open+0x114>
      fileclose(f);
80106258:	83 ec 0c             	sub    $0xc,%esp
8010625b:	ff 75 f0             	pushl  -0x10(%ebp)
8010625e:	e8 b5 ad ff ff       	call   80101018 <fileclose>
80106263:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
80106266:	83 ec 0c             	sub    $0xc,%esp
80106269:	ff 75 f4             	pushl  -0xc(%ebp)
8010626c:	e8 75 b9 ff ff       	call   80101be6 <iunlockput>
80106271:	83 c4 10             	add    $0x10,%esp
    end_op();
80106274:	e8 02 d3 ff ff       	call   8010357b <end_op>
    return -1;
80106279:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010627e:	eb 6d                	jmp    801062ed <sys_open+0x19b>
  }
  iunlock(ip);
80106280:	83 ec 0c             	sub    $0xc,%esp
80106283:	ff 75 f4             	pushl  -0xc(%ebp)
80106286:	e8 fb b7 ff ff       	call   80101a86 <iunlock>
8010628b:	83 c4 10             	add    $0x10,%esp
  end_op();
8010628e:	e8 e8 d2 ff ff       	call   8010357b <end_op>

  f->type = FD_INODE;
80106293:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106296:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
  f->ip = ip;
8010629c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010629f:	8b 55 f4             	mov    -0xc(%ebp),%edx
801062a2:	89 50 10             	mov    %edx,0x10(%eax)
  f->off = 0;
801062a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
801062a8:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  f->readable = !(omode & O_WRONLY);
801062af:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801062b2:	83 e0 01             	and    $0x1,%eax
801062b5:	85 c0                	test   %eax,%eax
801062b7:	0f 94 c0             	sete   %al
801062ba:	89 c2                	mov    %eax,%edx
801062bc:	8b 45 f0             	mov    -0x10(%ebp),%eax
801062bf:	88 50 08             	mov    %dl,0x8(%eax)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801062c2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801062c5:	83 e0 01             	and    $0x1,%eax
801062c8:	85 c0                	test   %eax,%eax
801062ca:	75 0a                	jne    801062d6 <sys_open+0x184>
801062cc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801062cf:	83 e0 02             	and    $0x2,%eax
801062d2:	85 c0                	test   %eax,%eax
801062d4:	74 07                	je     801062dd <sys_open+0x18b>
801062d6:	b8 01 00 00 00       	mov    $0x1,%eax
801062db:	eb 05                	jmp    801062e2 <sys_open+0x190>
801062dd:	b8 00 00 00 00       	mov    $0x0,%eax
801062e2:	89 c2                	mov    %eax,%edx
801062e4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801062e7:	88 50 09             	mov    %dl,0x9(%eax)
  return fd;
801062ea:	8b 45 ec             	mov    -0x14(%ebp),%eax
}
801062ed:	c9                   	leave  
801062ee:	c3                   	ret    

801062ef <sys_mkdir>:

int
sys_mkdir(void)
{
801062ef:	55                   	push   %ebp
801062f0:	89 e5                	mov    %esp,%ebp
801062f2:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
801062f5:	e8 f3 d1 ff ff       	call   801034ed <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
801062fa:	83 ec 08             	sub    $0x8,%esp
801062fd:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106300:	50                   	push   %eax
80106301:	6a 00                	push   $0x0
80106303:	e8 49 f5 ff ff       	call   80105851 <argstr>
80106308:	83 c4 10             	add    $0x10,%esp
8010630b:	85 c0                	test   %eax,%eax
8010630d:	78 1b                	js     8010632a <sys_mkdir+0x3b>
8010630f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106312:	6a 00                	push   $0x0
80106314:	6a 00                	push   $0x0
80106316:	6a 01                	push   $0x1
80106318:	50                   	push   %eax
80106319:	e8 62 fc ff ff       	call   80105f80 <create>
8010631e:	83 c4 10             	add    $0x10,%esp
80106321:	89 45 f4             	mov    %eax,-0xc(%ebp)
80106324:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106328:	75 0c                	jne    80106336 <sys_mkdir+0x47>
    end_op();
8010632a:	e8 4c d2 ff ff       	call   8010357b <end_op>
    return -1;
8010632f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106334:	eb 18                	jmp    8010634e <sys_mkdir+0x5f>
  }
  iunlockput(ip);
80106336:	83 ec 0c             	sub    $0xc,%esp
80106339:	ff 75 f4             	pushl  -0xc(%ebp)
8010633c:	e8 a5 b8 ff ff       	call   80101be6 <iunlockput>
80106341:	83 c4 10             	add    $0x10,%esp
  end_op();
80106344:	e8 32 d2 ff ff       	call   8010357b <end_op>
  return 0;
80106349:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010634e:	c9                   	leave  
8010634f:	c3                   	ret    

80106350 <sys_mknod>:

int
sys_mknod(void)
{
80106350:	55                   	push   %ebp
80106351:	89 e5                	mov    %esp,%ebp
80106353:	83 ec 28             	sub    $0x28,%esp
  struct inode *ip;
  char *path;
  int len;
  int major, minor;
  
  begin_op();
80106356:	e8 92 d1 ff ff       	call   801034ed <begin_op>
  if((len=argstr(0, &path)) < 0 ||
8010635b:	83 ec 08             	sub    $0x8,%esp
8010635e:	8d 45 ec             	lea    -0x14(%ebp),%eax
80106361:	50                   	push   %eax
80106362:	6a 00                	push   $0x0
80106364:	e8 e8 f4 ff ff       	call   80105851 <argstr>
80106369:	83 c4 10             	add    $0x10,%esp
8010636c:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010636f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106373:	78 4f                	js     801063c4 <sys_mknod+0x74>
     argint(1, &major) < 0 ||
80106375:	83 ec 08             	sub    $0x8,%esp
80106378:	8d 45 e8             	lea    -0x18(%ebp),%eax
8010637b:	50                   	push   %eax
8010637c:	6a 01                	push   $0x1
8010637e:	e8 47 f4 ff ff       	call   801057ca <argint>
80106383:	83 c4 10             	add    $0x10,%esp
  char *path;
  int len;
  int major, minor;
  
  begin_op();
  if((len=argstr(0, &path)) < 0 ||
80106386:	85 c0                	test   %eax,%eax
80106388:	78 3a                	js     801063c4 <sys_mknod+0x74>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
8010638a:	83 ec 08             	sub    $0x8,%esp
8010638d:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106390:	50                   	push   %eax
80106391:	6a 02                	push   $0x2
80106393:	e8 32 f4 ff ff       	call   801057ca <argint>
80106398:	83 c4 10             	add    $0x10,%esp
  int len;
  int major, minor;
  
  begin_op();
  if((len=argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
8010639b:	85 c0                	test   %eax,%eax
8010639d:	78 25                	js     801063c4 <sys_mknod+0x74>
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0){
8010639f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801063a2:	0f bf c8             	movswl %ax,%ecx
801063a5:	8b 45 e8             	mov    -0x18(%ebp),%eax
801063a8:	0f bf d0             	movswl %ax,%edx
801063ab:	8b 45 ec             	mov    -0x14(%ebp),%eax
  int major, minor;
  
  begin_op();
  if((len=argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
801063ae:	51                   	push   %ecx
801063af:	52                   	push   %edx
801063b0:	6a 03                	push   $0x3
801063b2:	50                   	push   %eax
801063b3:	e8 c8 fb ff ff       	call   80105f80 <create>
801063b8:	83 c4 10             	add    $0x10,%esp
801063bb:	89 45 f0             	mov    %eax,-0x10(%ebp)
801063be:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801063c2:	75 0c                	jne    801063d0 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
801063c4:	e8 b2 d1 ff ff       	call   8010357b <end_op>
    return -1;
801063c9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801063ce:	eb 18                	jmp    801063e8 <sys_mknod+0x98>
  }
  iunlockput(ip);
801063d0:	83 ec 0c             	sub    $0xc,%esp
801063d3:	ff 75 f0             	pushl  -0x10(%ebp)
801063d6:	e8 0b b8 ff ff       	call   80101be6 <iunlockput>
801063db:	83 c4 10             	add    $0x10,%esp
  end_op();
801063de:	e8 98 d1 ff ff       	call   8010357b <end_op>
  return 0;
801063e3:	b8 00 00 00 00       	mov    $0x0,%eax
}
801063e8:	c9                   	leave  
801063e9:	c3                   	ret    

801063ea <sys_chdir>:

int
sys_chdir(void)
{
801063ea:	55                   	push   %ebp
801063eb:	89 e5                	mov    %esp,%ebp
801063ed:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
801063f0:	e8 f8 d0 ff ff       	call   801034ed <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
801063f5:	83 ec 08             	sub    $0x8,%esp
801063f8:	8d 45 f0             	lea    -0x10(%ebp),%eax
801063fb:	50                   	push   %eax
801063fc:	6a 00                	push   $0x0
801063fe:	e8 4e f4 ff ff       	call   80105851 <argstr>
80106403:	83 c4 10             	add    $0x10,%esp
80106406:	85 c0                	test   %eax,%eax
80106408:	78 18                	js     80106422 <sys_chdir+0x38>
8010640a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010640d:	83 ec 0c             	sub    $0xc,%esp
80106410:	50                   	push   %eax
80106411:	e8 ce c0 ff ff       	call   801024e4 <namei>
80106416:	83 c4 10             	add    $0x10,%esp
80106419:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010641c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106420:	75 0c                	jne    8010642e <sys_chdir+0x44>
    end_op();
80106422:	e8 54 d1 ff ff       	call   8010357b <end_op>
    return -1;
80106427:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010642c:	eb 6e                	jmp    8010649c <sys_chdir+0xb2>
  }
  ilock(ip);
8010642e:	83 ec 0c             	sub    $0xc,%esp
80106431:	ff 75 f4             	pushl  -0xc(%ebp)
80106434:	e8 f0 b4 ff ff       	call   80101929 <ilock>
80106439:	83 c4 10             	add    $0x10,%esp
  if(ip->type != T_DIR){
8010643c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010643f:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80106443:	66 83 f8 01          	cmp    $0x1,%ax
80106447:	74 1a                	je     80106463 <sys_chdir+0x79>
    iunlockput(ip);
80106449:	83 ec 0c             	sub    $0xc,%esp
8010644c:	ff 75 f4             	pushl  -0xc(%ebp)
8010644f:	e8 92 b7 ff ff       	call   80101be6 <iunlockput>
80106454:	83 c4 10             	add    $0x10,%esp
    end_op();
80106457:	e8 1f d1 ff ff       	call   8010357b <end_op>
    return -1;
8010645c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106461:	eb 39                	jmp    8010649c <sys_chdir+0xb2>
  }
  iunlock(ip);
80106463:	83 ec 0c             	sub    $0xc,%esp
80106466:	ff 75 f4             	pushl  -0xc(%ebp)
80106469:	e8 18 b6 ff ff       	call   80101a86 <iunlock>
8010646e:	83 c4 10             	add    $0x10,%esp
  iput(proc->cwd);
80106471:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106477:	8b 40 68             	mov    0x68(%eax),%eax
8010647a:	83 ec 0c             	sub    $0xc,%esp
8010647d:	50                   	push   %eax
8010647e:	e8 74 b6 ff ff       	call   80101af7 <iput>
80106483:	83 c4 10             	add    $0x10,%esp
  end_op();
80106486:	e8 f0 d0 ff ff       	call   8010357b <end_op>
  proc->cwd = ip;
8010648b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106491:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106494:	89 50 68             	mov    %edx,0x68(%eax)
  return 0;
80106497:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010649c:	c9                   	leave  
8010649d:	c3                   	ret    

8010649e <sys_exec>:

int
sys_exec(void)
{
8010649e:	55                   	push   %ebp
8010649f:	89 e5                	mov    %esp,%ebp
801064a1:	81 ec 98 00 00 00    	sub    $0x98,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801064a7:	83 ec 08             	sub    $0x8,%esp
801064aa:	8d 45 f0             	lea    -0x10(%ebp),%eax
801064ad:	50                   	push   %eax
801064ae:	6a 00                	push   $0x0
801064b0:	e8 9c f3 ff ff       	call   80105851 <argstr>
801064b5:	83 c4 10             	add    $0x10,%esp
801064b8:	85 c0                	test   %eax,%eax
801064ba:	78 18                	js     801064d4 <sys_exec+0x36>
801064bc:	83 ec 08             	sub    $0x8,%esp
801064bf:	8d 85 6c ff ff ff    	lea    -0x94(%ebp),%eax
801064c5:	50                   	push   %eax
801064c6:	6a 01                	push   $0x1
801064c8:	e8 fd f2 ff ff       	call   801057ca <argint>
801064cd:	83 c4 10             	add    $0x10,%esp
801064d0:	85 c0                	test   %eax,%eax
801064d2:	79 0a                	jns    801064de <sys_exec+0x40>
    return -1;
801064d4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801064d9:	e9 c6 00 00 00       	jmp    801065a4 <sys_exec+0x106>
  }
  memset(argv, 0, sizeof(argv));
801064de:	83 ec 04             	sub    $0x4,%esp
801064e1:	68 80 00 00 00       	push   $0x80
801064e6:	6a 00                	push   $0x0
801064e8:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
801064ee:	50                   	push   %eax
801064ef:	e8 af ef ff ff       	call   801054a3 <memset>
801064f4:	83 c4 10             	add    $0x10,%esp
  for(i=0;; i++){
801064f7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(i >= NELEM(argv))
801064fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106501:	83 f8 1f             	cmp    $0x1f,%eax
80106504:	76 0a                	jbe    80106510 <sys_exec+0x72>
      return -1;
80106506:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010650b:	e9 94 00 00 00       	jmp    801065a4 <sys_exec+0x106>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80106510:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106513:	c1 e0 02             	shl    $0x2,%eax
80106516:	89 c2                	mov    %eax,%edx
80106518:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
8010651e:	01 c2                	add    %eax,%edx
80106520:	83 ec 08             	sub    $0x8,%esp
80106523:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80106529:	50                   	push   %eax
8010652a:	52                   	push   %edx
8010652b:	e8 fe f1 ff ff       	call   8010572e <fetchint>
80106530:	83 c4 10             	add    $0x10,%esp
80106533:	85 c0                	test   %eax,%eax
80106535:	79 07                	jns    8010653e <sys_exec+0xa0>
      return -1;
80106537:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010653c:	eb 66                	jmp    801065a4 <sys_exec+0x106>
    if(uarg == 0){
8010653e:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
80106544:	85 c0                	test   %eax,%eax
80106546:	75 27                	jne    8010656f <sys_exec+0xd1>
      argv[i] = 0;
80106548:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010654b:	c7 84 85 70 ff ff ff 	movl   $0x0,-0x90(%ebp,%eax,4)
80106552:	00 00 00 00 
      break;
80106556:	90                   	nop
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
80106557:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010655a:	83 ec 08             	sub    $0x8,%esp
8010655d:	8d 95 70 ff ff ff    	lea    -0x90(%ebp),%edx
80106563:	52                   	push   %edx
80106564:	50                   	push   %eax
80106565:	e8 e5 a5 ff ff       	call   80100b4f <exec>
8010656a:	83 c4 10             	add    $0x10,%esp
8010656d:	eb 35                	jmp    801065a4 <sys_exec+0x106>
      return -1;
    if(uarg == 0){
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
8010656f:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
80106575:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106578:	c1 e2 02             	shl    $0x2,%edx
8010657b:	01 c2                	add    %eax,%edx
8010657d:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
80106583:	83 ec 08             	sub    $0x8,%esp
80106586:	52                   	push   %edx
80106587:	50                   	push   %eax
80106588:	e8 db f1 ff ff       	call   80105768 <fetchstr>
8010658d:	83 c4 10             	add    $0x10,%esp
80106590:	85 c0                	test   %eax,%eax
80106592:	79 07                	jns    8010659b <sys_exec+0xfd>
      return -1;
80106594:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106599:	eb 09                	jmp    801065a4 <sys_exec+0x106>

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
8010659b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
8010659f:	e9 5a ff ff ff       	jmp    801064fe <sys_exec+0x60>
  return exec(path, argv);
}
801065a4:	c9                   	leave  
801065a5:	c3                   	ret    

801065a6 <sys_pipe>:

int
sys_pipe(void)
{
801065a6:	55                   	push   %ebp
801065a7:	89 e5                	mov    %esp,%ebp
801065a9:	83 ec 28             	sub    $0x28,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801065ac:	83 ec 04             	sub    $0x4,%esp
801065af:	6a 08                	push   $0x8
801065b1:	8d 45 ec             	lea    -0x14(%ebp),%eax
801065b4:	50                   	push   %eax
801065b5:	6a 00                	push   $0x0
801065b7:	e8 36 f2 ff ff       	call   801057f2 <argptr>
801065bc:	83 c4 10             	add    $0x10,%esp
801065bf:	85 c0                	test   %eax,%eax
801065c1:	79 0a                	jns    801065cd <sys_pipe+0x27>
    return -1;
801065c3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801065c8:	e9 af 00 00 00       	jmp    8010667c <sys_pipe+0xd6>
  if(pipealloc(&rf, &wf) < 0)
801065cd:	83 ec 08             	sub    $0x8,%esp
801065d0:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801065d3:	50                   	push   %eax
801065d4:	8d 45 e8             	lea    -0x18(%ebp),%eax
801065d7:	50                   	push   %eax
801065d8:	e8 f8 d9 ff ff       	call   80103fd5 <pipealloc>
801065dd:	83 c4 10             	add    $0x10,%esp
801065e0:	85 c0                	test   %eax,%eax
801065e2:	79 0a                	jns    801065ee <sys_pipe+0x48>
    return -1;
801065e4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801065e9:	e9 8e 00 00 00       	jmp    8010667c <sys_pipe+0xd6>
  fd0 = -1;
801065ee:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801065f5:	8b 45 e8             	mov    -0x18(%ebp),%eax
801065f8:	83 ec 0c             	sub    $0xc,%esp
801065fb:	50                   	push   %eax
801065fc:	e8 7b f3 ff ff       	call   8010597c <fdalloc>
80106601:	83 c4 10             	add    $0x10,%esp
80106604:	89 45 f4             	mov    %eax,-0xc(%ebp)
80106607:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010660b:	78 18                	js     80106625 <sys_pipe+0x7f>
8010660d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106610:	83 ec 0c             	sub    $0xc,%esp
80106613:	50                   	push   %eax
80106614:	e8 63 f3 ff ff       	call   8010597c <fdalloc>
80106619:	83 c4 10             	add    $0x10,%esp
8010661c:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010661f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80106623:	79 3f                	jns    80106664 <sys_pipe+0xbe>
    if(fd0 >= 0)
80106625:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106629:	78 14                	js     8010663f <sys_pipe+0x99>
      proc->ofile[fd0] = 0;
8010662b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106631:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106634:	83 c2 08             	add    $0x8,%edx
80106637:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
8010663e:	00 
    fileclose(rf);
8010663f:	8b 45 e8             	mov    -0x18(%ebp),%eax
80106642:	83 ec 0c             	sub    $0xc,%esp
80106645:	50                   	push   %eax
80106646:	e8 cd a9 ff ff       	call   80101018 <fileclose>
8010664b:	83 c4 10             	add    $0x10,%esp
    fileclose(wf);
8010664e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106651:	83 ec 0c             	sub    $0xc,%esp
80106654:	50                   	push   %eax
80106655:	e8 be a9 ff ff       	call   80101018 <fileclose>
8010665a:	83 c4 10             	add    $0x10,%esp
    return -1;
8010665d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106662:	eb 18                	jmp    8010667c <sys_pipe+0xd6>
  }
  fd[0] = fd0;
80106664:	8b 45 ec             	mov    -0x14(%ebp),%eax
80106667:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010666a:	89 10                	mov    %edx,(%eax)
  fd[1] = fd1;
8010666c:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010666f:	8d 50 04             	lea    0x4(%eax),%edx
80106672:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106675:	89 02                	mov    %eax,(%edx)
  return 0;
80106677:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010667c:	c9                   	leave  
8010667d:	c3                   	ret    

8010667e <sys_fork>:
#include "proc.h"


int
sys_fork(void)
{
8010667e:	55                   	push   %ebp
8010667f:	89 e5                	mov    %esp,%ebp
80106681:	83 ec 08             	sub    $0x8,%esp
  return fork();
80106684:	e8 0e e2 ff ff       	call   80104897 <fork>
}
80106689:	c9                   	leave  
8010668a:	c3                   	ret    

8010668b <sys_exit>:

int
sys_exit(void)
{
8010668b:	55                   	push   %ebp
8010668c:	89 e5                	mov    %esp,%ebp
8010668e:	83 ec 08             	sub    $0x8,%esp
  exit();
80106691:	e8 dc e3 ff ff       	call   80104a72 <exit>
  return 0;  // not reached
80106696:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010669b:	c9                   	leave  
8010669c:	c3                   	ret    

8010669d <sys_wait>:

int
sys_wait(void)
{
8010669d:	55                   	push   %ebp
8010669e:	89 e5                	mov    %esp,%ebp
801066a0:	83 ec 08             	sub    $0x8,%esp
  return wait();
801066a3:	e8 02 e5 ff ff       	call   80104baa <wait>
}
801066a8:	c9                   	leave  
801066a9:	c3                   	ret    

801066aa <sys_kill>:

int
sys_kill(void)
{
801066aa:	55                   	push   %ebp
801066ab:	89 e5                	mov    %esp,%ebp
801066ad:	83 ec 18             	sub    $0x18,%esp
  int pid;

  if(argint(0, &pid) < 0)
801066b0:	83 ec 08             	sub    $0x8,%esp
801066b3:	8d 45 f4             	lea    -0xc(%ebp),%eax
801066b6:	50                   	push   %eax
801066b7:	6a 00                	push   $0x0
801066b9:	e8 0c f1 ff ff       	call   801057ca <argint>
801066be:	83 c4 10             	add    $0x10,%esp
801066c1:	85 c0                	test   %eax,%eax
801066c3:	79 07                	jns    801066cc <sys_kill+0x22>
    return -1;
801066c5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801066ca:	eb 0f                	jmp    801066db <sys_kill+0x31>
  return kill(pid);
801066cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801066cf:	83 ec 0c             	sub    $0xc,%esp
801066d2:	50                   	push   %eax
801066d3:	e8 8b e9 ff ff       	call   80105063 <kill>
801066d8:	83 c4 10             	add    $0x10,%esp
}
801066db:	c9                   	leave  
801066dc:	c3                   	ret    

801066dd <sys_getpid>:

int
sys_getpid(void)
{
801066dd:	55                   	push   %ebp
801066de:	89 e5                	mov    %esp,%ebp
  return proc->pid;
801066e0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801066e6:	8b 40 10             	mov    0x10(%eax),%eax
}
801066e9:	5d                   	pop    %ebp
801066ea:	c3                   	ret    

801066eb <sys_sbrk>:

int
sys_sbrk(void)
{
801066eb:	55                   	push   %ebp
801066ec:	89 e5                	mov    %esp,%ebp
801066ee:	83 ec 18             	sub    $0x18,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
801066f1:	83 ec 08             	sub    $0x8,%esp
801066f4:	8d 45 f0             	lea    -0x10(%ebp),%eax
801066f7:	50                   	push   %eax
801066f8:	6a 00                	push   $0x0
801066fa:	e8 cb f0 ff ff       	call   801057ca <argint>
801066ff:	83 c4 10             	add    $0x10,%esp
80106702:	85 c0                	test   %eax,%eax
80106704:	79 07                	jns    8010670d <sys_sbrk+0x22>
    return -1;
80106706:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010670b:	eb 28                	jmp    80106735 <sys_sbrk+0x4a>
  addr = proc->sz;
8010670d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106713:	8b 00                	mov    (%eax),%eax
80106715:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(growproc(n) < 0)
80106718:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010671b:	83 ec 0c             	sub    $0xc,%esp
8010671e:	50                   	push   %eax
8010671f:	e8 d0 e0 ff ff       	call   801047f4 <growproc>
80106724:	83 c4 10             	add    $0x10,%esp
80106727:	85 c0                	test   %eax,%eax
80106729:	79 07                	jns    80106732 <sys_sbrk+0x47>
    return -1;
8010672b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106730:	eb 03                	jmp    80106735 <sys_sbrk+0x4a>
  return addr;
80106732:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80106735:	c9                   	leave  
80106736:	c3                   	ret    

80106737 <sys_sleep>:

int
sys_sleep(void)
{
80106737:	55                   	push   %ebp
80106738:	89 e5                	mov    %esp,%ebp
8010673a:	83 ec 18             	sub    $0x18,%esp
  int n;
  uint ticks0;
  
  if(argint(0, &n) < 0)
8010673d:	83 ec 08             	sub    $0x8,%esp
80106740:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106743:	50                   	push   %eax
80106744:	6a 00                	push   $0x0
80106746:	e8 7f f0 ff ff       	call   801057ca <argint>
8010674b:	83 c4 10             	add    $0x10,%esp
8010674e:	85 c0                	test   %eax,%eax
80106750:	79 07                	jns    80106759 <sys_sleep+0x22>
    return -1;
80106752:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106757:	eb 77                	jmp    801067d0 <sys_sleep+0x99>
  acquire(&tickslock);
80106759:	83 ec 0c             	sub    $0xc,%esp
8010675c:	68 80 4c 11 80       	push   $0x80114c80
80106761:	e8 e1 ea ff ff       	call   80105247 <acquire>
80106766:	83 c4 10             	add    $0x10,%esp
  ticks0 = ticks;
80106769:	a1 c0 54 11 80       	mov    0x801154c0,%eax
8010676e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(ticks - ticks0 < n){
80106771:	eb 39                	jmp    801067ac <sys_sleep+0x75>
    if(proc->killed){
80106773:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106779:	8b 40 24             	mov    0x24(%eax),%eax
8010677c:	85 c0                	test   %eax,%eax
8010677e:	74 17                	je     80106797 <sys_sleep+0x60>
      release(&tickslock);
80106780:	83 ec 0c             	sub    $0xc,%esp
80106783:	68 80 4c 11 80       	push   $0x80114c80
80106788:	e8 20 eb ff ff       	call   801052ad <release>
8010678d:	83 c4 10             	add    $0x10,%esp
      return -1;
80106790:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106795:	eb 39                	jmp    801067d0 <sys_sleep+0x99>
    }
    sleep(&ticks, &tickslock);
80106797:	83 ec 08             	sub    $0x8,%esp
8010679a:	68 80 4c 11 80       	push   $0x80114c80
8010679f:	68 c0 54 11 80       	push   $0x801154c0
801067a4:	e8 78 e7 ff ff       	call   80104f21 <sleep>
801067a9:	83 c4 10             	add    $0x10,%esp
  
  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
801067ac:	a1 c0 54 11 80       	mov    0x801154c0,%eax
801067b1:	2b 45 f4             	sub    -0xc(%ebp),%eax
801067b4:	8b 55 f0             	mov    -0x10(%ebp),%edx
801067b7:	39 d0                	cmp    %edx,%eax
801067b9:	72 b8                	jb     80106773 <sys_sleep+0x3c>
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
801067bb:	83 ec 0c             	sub    $0xc,%esp
801067be:	68 80 4c 11 80       	push   $0x80114c80
801067c3:	e8 e5 ea ff ff       	call   801052ad <release>
801067c8:	83 c4 10             	add    $0x10,%esp
  return 0;
801067cb:	b8 00 00 00 00       	mov    $0x0,%eax
}
801067d0:	c9                   	leave  
801067d1:	c3                   	ret    

801067d2 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
801067d2:	55                   	push   %ebp
801067d3:	89 e5                	mov    %esp,%ebp
801067d5:	83 ec 18             	sub    $0x18,%esp
  uint xticks;
  
  acquire(&tickslock);
801067d8:	83 ec 0c             	sub    $0xc,%esp
801067db:	68 80 4c 11 80       	push   $0x80114c80
801067e0:	e8 62 ea ff ff       	call   80105247 <acquire>
801067e5:	83 c4 10             	add    $0x10,%esp
  xticks = ticks;
801067e8:	a1 c0 54 11 80       	mov    0x801154c0,%eax
801067ed:	89 45 f4             	mov    %eax,-0xc(%ebp)
  release(&tickslock);
801067f0:	83 ec 0c             	sub    $0xc,%esp
801067f3:	68 80 4c 11 80       	push   $0x80114c80
801067f8:	e8 b0 ea ff ff       	call   801052ad <release>
801067fd:	83 c4 10             	add    $0x10,%esp
  return xticks;
80106800:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80106803:	c9                   	leave  
80106804:	c3                   	ret    

80106805 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80106805:	55                   	push   %ebp
80106806:	89 e5                	mov    %esp,%ebp
80106808:	83 ec 08             	sub    $0x8,%esp
8010680b:	8b 55 08             	mov    0x8(%ebp),%edx
8010680e:	8b 45 0c             	mov    0xc(%ebp),%eax
80106811:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80106815:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106818:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
8010681c:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80106820:	ee                   	out    %al,(%dx)
}
80106821:	c9                   	leave  
80106822:	c3                   	ret    

80106823 <timerinit>:
#define TIMER_RATEGEN   0x04    // mode 2, rate generator
#define TIMER_16BIT     0x30    // r/w counter 16 bits, LSB first

void
timerinit(void)
{
80106823:	55                   	push   %ebp
80106824:	89 e5                	mov    %esp,%ebp
80106826:	83 ec 08             	sub    $0x8,%esp
  // Interrupt 100 times/sec.
  outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
80106829:	6a 34                	push   $0x34
8010682b:	6a 43                	push   $0x43
8010682d:	e8 d3 ff ff ff       	call   80106805 <outb>
80106832:	83 c4 08             	add    $0x8,%esp
  outb(IO_TIMER1, TIMER_DIV(100) % 256);
80106835:	68 9c 00 00 00       	push   $0x9c
8010683a:	6a 40                	push   $0x40
8010683c:	e8 c4 ff ff ff       	call   80106805 <outb>
80106841:	83 c4 08             	add    $0x8,%esp
  outb(IO_TIMER1, TIMER_DIV(100) / 256);
80106844:	6a 2e                	push   $0x2e
80106846:	6a 40                	push   $0x40
80106848:	e8 b8 ff ff ff       	call   80106805 <outb>
8010684d:	83 c4 08             	add    $0x8,%esp
  picenable(IRQ_TIMER);
80106850:	83 ec 0c             	sub    $0xc,%esp
80106853:	6a 00                	push   $0x0
80106855:	e8 67 d6 ff ff       	call   80103ec1 <picenable>
8010685a:	83 c4 10             	add    $0x10,%esp
}
8010685d:	c9                   	leave  
8010685e:	c3                   	ret    

8010685f <alltraps>:
8010685f:	1e                   	push   %ds
80106860:	06                   	push   %es
80106861:	0f a0                	push   %fs
80106863:	0f a8                	push   %gs
80106865:	60                   	pusha  
80106866:	66 b8 10 00          	mov    $0x10,%ax
8010686a:	8e d8                	mov    %eax,%ds
8010686c:	8e c0                	mov    %eax,%es
8010686e:	66 b8 18 00          	mov    $0x18,%ax
80106872:	8e e0                	mov    %eax,%fs
80106874:	8e e8                	mov    %eax,%gs
80106876:	54                   	push   %esp
80106877:	e8 d4 01 00 00       	call   80106a50 <trap>
8010687c:	83 c4 04             	add    $0x4,%esp

8010687f <trapret>:
8010687f:	61                   	popa   
80106880:	0f a9                	pop    %gs
80106882:	0f a1                	pop    %fs
80106884:	07                   	pop    %es
80106885:	1f                   	pop    %ds
80106886:	83 c4 08             	add    $0x8,%esp
80106889:	cf                   	iret   

8010688a <lidt>:

struct gatedesc;

static inline void
lidt(struct gatedesc *p, int size)
{
8010688a:	55                   	push   %ebp
8010688b:	89 e5                	mov    %esp,%ebp
8010688d:	83 ec 10             	sub    $0x10,%esp
  volatile ushort pd[3];

  pd[0] = size-1;
80106890:	8b 45 0c             	mov    0xc(%ebp),%eax
80106893:	83 e8 01             	sub    $0x1,%eax
80106896:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
8010689a:	8b 45 08             	mov    0x8(%ebp),%eax
8010689d:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
801068a1:	8b 45 08             	mov    0x8(%ebp),%eax
801068a4:	c1 e8 10             	shr    $0x10,%eax
801068a7:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lidt (%0)" : : "r" (pd));
801068ab:	8d 45 fa             	lea    -0x6(%ebp),%eax
801068ae:	0f 01 18             	lidtl  (%eax)
}
801068b1:	c9                   	leave  
801068b2:	c3                   	ret    

801068b3 <rcr2>:
  return result;
}

static inline uint
rcr2(void)
{
801068b3:	55                   	push   %ebp
801068b4:	89 e5                	mov    %esp,%ebp
801068b6:	83 ec 10             	sub    $0x10,%esp
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
801068b9:	0f 20 d0             	mov    %cr2,%eax
801068bc:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return val;
801068bf:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
801068c2:	c9                   	leave  
801068c3:	c3                   	ret    

801068c4 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
801068c4:	55                   	push   %ebp
801068c5:	89 e5                	mov    %esp,%ebp
801068c7:	83 ec 18             	sub    $0x18,%esp
  int i;

  for(i = 0; i < 256; i++)
801068ca:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801068d1:	e9 c3 00 00 00       	jmp    80106999 <tvinit+0xd5>
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
801068d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801068d9:	8b 04 85 98 b0 10 80 	mov    -0x7fef4f68(,%eax,4),%eax
801068e0:	89 c2                	mov    %eax,%edx
801068e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801068e5:	66 89 14 c5 c0 4c 11 	mov    %dx,-0x7feeb340(,%eax,8)
801068ec:	80 
801068ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
801068f0:	66 c7 04 c5 c2 4c 11 	movw   $0x8,-0x7feeb33e(,%eax,8)
801068f7:	80 08 00 
801068fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
801068fd:	0f b6 14 c5 c4 4c 11 	movzbl -0x7feeb33c(,%eax,8),%edx
80106904:	80 
80106905:	83 e2 e0             	and    $0xffffffe0,%edx
80106908:	88 14 c5 c4 4c 11 80 	mov    %dl,-0x7feeb33c(,%eax,8)
8010690f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106912:	0f b6 14 c5 c4 4c 11 	movzbl -0x7feeb33c(,%eax,8),%edx
80106919:	80 
8010691a:	83 e2 1f             	and    $0x1f,%edx
8010691d:	88 14 c5 c4 4c 11 80 	mov    %dl,-0x7feeb33c(,%eax,8)
80106924:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106927:	0f b6 14 c5 c5 4c 11 	movzbl -0x7feeb33b(,%eax,8),%edx
8010692e:	80 
8010692f:	83 e2 f0             	and    $0xfffffff0,%edx
80106932:	83 ca 0e             	or     $0xe,%edx
80106935:	88 14 c5 c5 4c 11 80 	mov    %dl,-0x7feeb33b(,%eax,8)
8010693c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010693f:	0f b6 14 c5 c5 4c 11 	movzbl -0x7feeb33b(,%eax,8),%edx
80106946:	80 
80106947:	83 e2 ef             	and    $0xffffffef,%edx
8010694a:	88 14 c5 c5 4c 11 80 	mov    %dl,-0x7feeb33b(,%eax,8)
80106951:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106954:	0f b6 14 c5 c5 4c 11 	movzbl -0x7feeb33b(,%eax,8),%edx
8010695b:	80 
8010695c:	83 e2 9f             	and    $0xffffff9f,%edx
8010695f:	88 14 c5 c5 4c 11 80 	mov    %dl,-0x7feeb33b(,%eax,8)
80106966:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106969:	0f b6 14 c5 c5 4c 11 	movzbl -0x7feeb33b(,%eax,8),%edx
80106970:	80 
80106971:	83 ca 80             	or     $0xffffff80,%edx
80106974:	88 14 c5 c5 4c 11 80 	mov    %dl,-0x7feeb33b(,%eax,8)
8010697b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010697e:	8b 04 85 98 b0 10 80 	mov    -0x7fef4f68(,%eax,4),%eax
80106985:	c1 e8 10             	shr    $0x10,%eax
80106988:	89 c2                	mov    %eax,%edx
8010698a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010698d:	66 89 14 c5 c6 4c 11 	mov    %dx,-0x7feeb33a(,%eax,8)
80106994:	80 
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
80106995:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80106999:	81 7d f4 ff 00 00 00 	cmpl   $0xff,-0xc(%ebp)
801069a0:	0f 8e 30 ff ff ff    	jle    801068d6 <tvinit+0x12>
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801069a6:	a1 98 b1 10 80       	mov    0x8010b198,%eax
801069ab:	66 a3 c0 4e 11 80    	mov    %ax,0x80114ec0
801069b1:	66 c7 05 c2 4e 11 80 	movw   $0x8,0x80114ec2
801069b8:	08 00 
801069ba:	0f b6 05 c4 4e 11 80 	movzbl 0x80114ec4,%eax
801069c1:	83 e0 e0             	and    $0xffffffe0,%eax
801069c4:	a2 c4 4e 11 80       	mov    %al,0x80114ec4
801069c9:	0f b6 05 c4 4e 11 80 	movzbl 0x80114ec4,%eax
801069d0:	83 e0 1f             	and    $0x1f,%eax
801069d3:	a2 c4 4e 11 80       	mov    %al,0x80114ec4
801069d8:	0f b6 05 c5 4e 11 80 	movzbl 0x80114ec5,%eax
801069df:	83 c8 0f             	or     $0xf,%eax
801069e2:	a2 c5 4e 11 80       	mov    %al,0x80114ec5
801069e7:	0f b6 05 c5 4e 11 80 	movzbl 0x80114ec5,%eax
801069ee:	83 e0 ef             	and    $0xffffffef,%eax
801069f1:	a2 c5 4e 11 80       	mov    %al,0x80114ec5
801069f6:	0f b6 05 c5 4e 11 80 	movzbl 0x80114ec5,%eax
801069fd:	83 c8 60             	or     $0x60,%eax
80106a00:	a2 c5 4e 11 80       	mov    %al,0x80114ec5
80106a05:	0f b6 05 c5 4e 11 80 	movzbl 0x80114ec5,%eax
80106a0c:	83 c8 80             	or     $0xffffff80,%eax
80106a0f:	a2 c5 4e 11 80       	mov    %al,0x80114ec5
80106a14:	a1 98 b1 10 80       	mov    0x8010b198,%eax
80106a19:	c1 e8 10             	shr    $0x10,%eax
80106a1c:	66 a3 c6 4e 11 80    	mov    %ax,0x80114ec6
  
  initlock(&tickslock, "time");
80106a22:	83 ec 08             	sub    $0x8,%esp
80106a25:	68 3c 8c 10 80       	push   $0x80108c3c
80106a2a:	68 80 4c 11 80       	push   $0x80114c80
80106a2f:	e8 f2 e7 ff ff       	call   80105226 <initlock>
80106a34:	83 c4 10             	add    $0x10,%esp
}
80106a37:	c9                   	leave  
80106a38:	c3                   	ret    

80106a39 <idtinit>:

void
idtinit(void)
{
80106a39:	55                   	push   %ebp
80106a3a:	89 e5                	mov    %esp,%ebp
  lidt(idt, sizeof(idt));
80106a3c:	68 00 08 00 00       	push   $0x800
80106a41:	68 c0 4c 11 80       	push   $0x80114cc0
80106a46:	e8 3f fe ff ff       	call   8010688a <lidt>
80106a4b:	83 c4 08             	add    $0x8,%esp
}
80106a4e:	c9                   	leave  
80106a4f:	c3                   	ret    

80106a50 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80106a50:	55                   	push   %ebp
80106a51:	89 e5                	mov    %esp,%ebp
80106a53:	57                   	push   %edi
80106a54:	56                   	push   %esi
80106a55:	53                   	push   %ebx
80106a56:	83 ec 1c             	sub    $0x1c,%esp
  if(tf->trapno == T_SYSCALL){
80106a59:	8b 45 08             	mov    0x8(%ebp),%eax
80106a5c:	8b 40 30             	mov    0x30(%eax),%eax
80106a5f:	83 f8 40             	cmp    $0x40,%eax
80106a62:	75 3f                	jne    80106aa3 <trap+0x53>
    if(proc->killed)
80106a64:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106a6a:	8b 40 24             	mov    0x24(%eax),%eax
80106a6d:	85 c0                	test   %eax,%eax
80106a6f:	74 05                	je     80106a76 <trap+0x26>
      exit();
80106a71:	e8 fc df ff ff       	call   80104a72 <exit>
    proc->tf = tf;
80106a76:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106a7c:	8b 55 08             	mov    0x8(%ebp),%edx
80106a7f:	89 50 18             	mov    %edx,0x18(%eax)
    syscall();
80106a82:	e8 fb ed ff ff       	call   80105882 <syscall>
    if(proc->killed)
80106a87:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106a8d:	8b 40 24             	mov    0x24(%eax),%eax
80106a90:	85 c0                	test   %eax,%eax
80106a92:	74 0a                	je     80106a9e <trap+0x4e>
      exit();
80106a94:	e8 d9 df ff ff       	call   80104a72 <exit>
    return;
80106a99:	e9 ec 01 00 00       	jmp    80106c8a <trap+0x23a>
80106a9e:	e9 e7 01 00 00       	jmp    80106c8a <trap+0x23a>
  }

  switch(tf->trapno){
80106aa3:	8b 45 08             	mov    0x8(%ebp),%eax
80106aa6:	8b 40 30             	mov    0x30(%eax),%eax
80106aa9:	83 e8 20             	sub    $0x20,%eax
80106aac:	83 f8 1f             	cmp    $0x1f,%eax
80106aaf:	0f 87 c0 00 00 00    	ja     80106b75 <trap+0x125>
80106ab5:	8b 04 85 e4 8c 10 80 	mov    -0x7fef731c(,%eax,4),%eax
80106abc:	ff e0                	jmp    *%eax
  case T_IRQ0 + IRQ_TIMER:
    if(cpu->id == 0){
80106abe:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80106ac4:	0f b6 00             	movzbl (%eax),%eax
80106ac7:	84 c0                	test   %al,%al
80106ac9:	75 3d                	jne    80106b08 <trap+0xb8>
      acquire(&tickslock);
80106acb:	83 ec 0c             	sub    $0xc,%esp
80106ace:	68 80 4c 11 80       	push   $0x80114c80
80106ad3:	e8 6f e7 ff ff       	call   80105247 <acquire>
80106ad8:	83 c4 10             	add    $0x10,%esp
      ticks++;
80106adb:	a1 c0 54 11 80       	mov    0x801154c0,%eax
80106ae0:	83 c0 01             	add    $0x1,%eax
80106ae3:	a3 c0 54 11 80       	mov    %eax,0x801154c0
      wakeup(&ticks);
80106ae8:	83 ec 0c             	sub    $0xc,%esp
80106aeb:	68 c0 54 11 80       	push   $0x801154c0
80106af0:	e8 38 e5 ff ff       	call   8010502d <wakeup>
80106af5:	83 c4 10             	add    $0x10,%esp
      release(&tickslock);
80106af8:	83 ec 0c             	sub    $0xc,%esp
80106afb:	68 80 4c 11 80       	push   $0x80114c80
80106b00:	e8 a8 e7 ff ff       	call   801052ad <release>
80106b05:	83 c4 10             	add    $0x10,%esp
    }
    lapiceoi();
80106b08:	e8 c1 c4 ff ff       	call   80102fce <lapiceoi>
    break;
80106b0d:	e9 1c 01 00 00       	jmp    80106c2e <trap+0x1de>
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80106b12:	e8 d8 bc ff ff       	call   801027ef <ideintr>
    lapiceoi();
80106b17:	e8 b2 c4 ff ff       	call   80102fce <lapiceoi>
    break;
80106b1c:	e9 0d 01 00 00       	jmp    80106c2e <trap+0x1de>
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
80106b21:	e8 af c2 ff ff       	call   80102dd5 <kbdintr>
    lapiceoi();
80106b26:	e8 a3 c4 ff ff       	call   80102fce <lapiceoi>
    break;
80106b2b:	e9 fe 00 00 00       	jmp    80106c2e <trap+0x1de>
  case T_IRQ0 + IRQ_COM1:
    uartintr();
80106b30:	e8 32 03 00 00       	call   80106e67 <uartintr>
    lapiceoi();
80106b35:	e8 94 c4 ff ff       	call   80102fce <lapiceoi>
    break;
80106b3a:	e9 ef 00 00 00       	jmp    80106c2e <trap+0x1de>
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106b3f:	8b 45 08             	mov    0x8(%ebp),%eax
80106b42:	8b 48 38             	mov    0x38(%eax),%ecx
            cpu->id, tf->cs, tf->eip);
80106b45:	8b 45 08             	mov    0x8(%ebp),%eax
80106b48:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
    uartintr();
    lapiceoi();
    break;
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106b4c:	0f b7 d0             	movzwl %ax,%edx
            cpu->id, tf->cs, tf->eip);
80106b4f:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80106b55:	0f b6 00             	movzbl (%eax),%eax
    uartintr();
    lapiceoi();
    break;
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106b58:	0f b6 c0             	movzbl %al,%eax
80106b5b:	51                   	push   %ecx
80106b5c:	52                   	push   %edx
80106b5d:	50                   	push   %eax
80106b5e:	68 44 8c 10 80       	push   $0x80108c44
80106b63:	e8 57 98 ff ff       	call   801003bf <cprintf>
80106b68:	83 c4 10             	add    $0x10,%esp
            cpu->id, tf->cs, tf->eip);
    lapiceoi();
80106b6b:	e8 5e c4 ff ff       	call   80102fce <lapiceoi>
    break;
80106b70:	e9 b9 00 00 00       	jmp    80106c2e <trap+0x1de>
   
  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
80106b75:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106b7b:	85 c0                	test   %eax,%eax
80106b7d:	74 11                	je     80106b90 <trap+0x140>
80106b7f:	8b 45 08             	mov    0x8(%ebp),%eax
80106b82:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
80106b86:	0f b7 c0             	movzwl %ax,%eax
80106b89:	83 e0 03             	and    $0x3,%eax
80106b8c:	85 c0                	test   %eax,%eax
80106b8e:	75 40                	jne    80106bd0 <trap+0x180>
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80106b90:	e8 1e fd ff ff       	call   801068b3 <rcr2>
80106b95:	89 c3                	mov    %eax,%ebx
80106b97:	8b 45 08             	mov    0x8(%ebp),%eax
80106b9a:	8b 48 38             	mov    0x38(%eax),%ecx
              tf->trapno, cpu->id, tf->eip, rcr2());
80106b9d:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80106ba3:	0f b6 00             	movzbl (%eax),%eax
   
  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80106ba6:	0f b6 d0             	movzbl %al,%edx
80106ba9:	8b 45 08             	mov    0x8(%ebp),%eax
80106bac:	8b 40 30             	mov    0x30(%eax),%eax
80106baf:	83 ec 0c             	sub    $0xc,%esp
80106bb2:	53                   	push   %ebx
80106bb3:	51                   	push   %ecx
80106bb4:	52                   	push   %edx
80106bb5:	50                   	push   %eax
80106bb6:	68 68 8c 10 80       	push   $0x80108c68
80106bbb:	e8 ff 97 ff ff       	call   801003bf <cprintf>
80106bc0:	83 c4 20             	add    $0x20,%esp
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
80106bc3:	83 ec 0c             	sub    $0xc,%esp
80106bc6:	68 9a 8c 10 80       	push   $0x80108c9a
80106bcb:	e8 8c 99 ff ff       	call   8010055c <panic>
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106bd0:	e8 de fc ff ff       	call   801068b3 <rcr2>
80106bd5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106bd8:	8b 45 08             	mov    0x8(%ebp),%eax
80106bdb:	8b 70 38             	mov    0x38(%eax),%esi
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
80106bde:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80106be4:	0f b6 00             	movzbl (%eax),%eax
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106be7:	0f b6 d8             	movzbl %al,%ebx
80106bea:	8b 45 08             	mov    0x8(%ebp),%eax
80106bed:	8b 48 34             	mov    0x34(%eax),%ecx
80106bf0:	8b 45 08             	mov    0x8(%ebp),%eax
80106bf3:	8b 50 30             	mov    0x30(%eax),%edx
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
80106bf6:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106bfc:	8d 78 6c             	lea    0x6c(%eax),%edi
80106bff:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106c05:	8b 40 10             	mov    0x10(%eax),%eax
80106c08:	ff 75 e4             	pushl  -0x1c(%ebp)
80106c0b:	56                   	push   %esi
80106c0c:	53                   	push   %ebx
80106c0d:	51                   	push   %ecx
80106c0e:	52                   	push   %edx
80106c0f:	57                   	push   %edi
80106c10:	50                   	push   %eax
80106c11:	68 a0 8c 10 80       	push   $0x80108ca0
80106c16:	e8 a4 97 ff ff       	call   801003bf <cprintf>
80106c1b:	83 c4 20             	add    $0x20,%esp
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
            rcr2());
    proc->killed = 1;
80106c1e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106c24:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
80106c2b:	eb 01                	jmp    80106c2e <trap+0x1de>
    ideintr();
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
80106c2d:	90                   	nop
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running 
  // until it gets to the regular system call return.)
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80106c2e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106c34:	85 c0                	test   %eax,%eax
80106c36:	74 24                	je     80106c5c <trap+0x20c>
80106c38:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106c3e:	8b 40 24             	mov    0x24(%eax),%eax
80106c41:	85 c0                	test   %eax,%eax
80106c43:	74 17                	je     80106c5c <trap+0x20c>
80106c45:	8b 45 08             	mov    0x8(%ebp),%eax
80106c48:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
80106c4c:	0f b7 c0             	movzwl %ax,%eax
80106c4f:	83 e0 03             	and    $0x3,%eax
80106c52:	83 f8 03             	cmp    $0x3,%eax
80106c55:	75 05                	jne    80106c5c <trap+0x20c>
    exit();
80106c57:	e8 16 de ff ff       	call   80104a72 <exit>
  //Não Preemptivo
    //if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
      //yield();

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80106c5c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106c62:	85 c0                	test   %eax,%eax
80106c64:	74 24                	je     80106c8a <trap+0x23a>
80106c66:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106c6c:	8b 40 24             	mov    0x24(%eax),%eax
80106c6f:	85 c0                	test   %eax,%eax
80106c71:	74 17                	je     80106c8a <trap+0x23a>
80106c73:	8b 45 08             	mov    0x8(%ebp),%eax
80106c76:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
80106c7a:	0f b7 c0             	movzwl %ax,%eax
80106c7d:	83 e0 03             	and    $0x3,%eax
80106c80:	83 f8 03             	cmp    $0x3,%eax
80106c83:	75 05                	jne    80106c8a <trap+0x23a>
    exit();
80106c85:	e8 e8 dd ff ff       	call   80104a72 <exit>
}
80106c8a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106c8d:	5b                   	pop    %ebx
80106c8e:	5e                   	pop    %esi
80106c8f:	5f                   	pop    %edi
80106c90:	5d                   	pop    %ebp
80106c91:	c3                   	ret    

80106c92 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
80106c92:	55                   	push   %ebp
80106c93:	89 e5                	mov    %esp,%ebp
80106c95:	83 ec 14             	sub    $0x14,%esp
80106c98:	8b 45 08             	mov    0x8(%ebp),%eax
80106c9b:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80106c9f:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80106ca3:	89 c2                	mov    %eax,%edx
80106ca5:	ec                   	in     (%dx),%al
80106ca6:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80106ca9:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80106cad:	c9                   	leave  
80106cae:	c3                   	ret    

80106caf <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80106caf:	55                   	push   %ebp
80106cb0:	89 e5                	mov    %esp,%ebp
80106cb2:	83 ec 08             	sub    $0x8,%esp
80106cb5:	8b 55 08             	mov    0x8(%ebp),%edx
80106cb8:	8b 45 0c             	mov    0xc(%ebp),%eax
80106cbb:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80106cbf:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106cc2:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80106cc6:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80106cca:	ee                   	out    %al,(%dx)
}
80106ccb:	c9                   	leave  
80106ccc:	c3                   	ret    

80106ccd <uartinit>:

static int uart;    // is there a uart?

void
uartinit(void)
{
80106ccd:	55                   	push   %ebp
80106cce:	89 e5                	mov    %esp,%ebp
80106cd0:	83 ec 18             	sub    $0x18,%esp
  char *p;

  // Turn off the FIFO
  outb(COM1+2, 0);
80106cd3:	6a 00                	push   $0x0
80106cd5:	68 fa 03 00 00       	push   $0x3fa
80106cda:	e8 d0 ff ff ff       	call   80106caf <outb>
80106cdf:	83 c4 08             	add    $0x8,%esp
  
  // 9600 baud, 8 data bits, 1 stop bit, parity off.
  outb(COM1+3, 0x80);    // Unlock divisor
80106ce2:	68 80 00 00 00       	push   $0x80
80106ce7:	68 fb 03 00 00       	push   $0x3fb
80106cec:	e8 be ff ff ff       	call   80106caf <outb>
80106cf1:	83 c4 08             	add    $0x8,%esp
  outb(COM1+0, 115200/9600);
80106cf4:	6a 0c                	push   $0xc
80106cf6:	68 f8 03 00 00       	push   $0x3f8
80106cfb:	e8 af ff ff ff       	call   80106caf <outb>
80106d00:	83 c4 08             	add    $0x8,%esp
  outb(COM1+1, 0);
80106d03:	6a 00                	push   $0x0
80106d05:	68 f9 03 00 00       	push   $0x3f9
80106d0a:	e8 a0 ff ff ff       	call   80106caf <outb>
80106d0f:	83 c4 08             	add    $0x8,%esp
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
80106d12:	6a 03                	push   $0x3
80106d14:	68 fb 03 00 00       	push   $0x3fb
80106d19:	e8 91 ff ff ff       	call   80106caf <outb>
80106d1e:	83 c4 08             	add    $0x8,%esp
  outb(COM1+4, 0);
80106d21:	6a 00                	push   $0x0
80106d23:	68 fc 03 00 00       	push   $0x3fc
80106d28:	e8 82 ff ff ff       	call   80106caf <outb>
80106d2d:	83 c4 08             	add    $0x8,%esp
  outb(COM1+1, 0x01);    // Enable receive interrupts.
80106d30:	6a 01                	push   $0x1
80106d32:	68 f9 03 00 00       	push   $0x3f9
80106d37:	e8 73 ff ff ff       	call   80106caf <outb>
80106d3c:	83 c4 08             	add    $0x8,%esp

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
80106d3f:	68 fd 03 00 00       	push   $0x3fd
80106d44:	e8 49 ff ff ff       	call   80106c92 <inb>
80106d49:	83 c4 04             	add    $0x4,%esp
80106d4c:	3c ff                	cmp    $0xff,%al
80106d4e:	75 02                	jne    80106d52 <uartinit+0x85>
    return;
80106d50:	eb 6c                	jmp    80106dbe <uartinit+0xf1>
  uart = 1;
80106d52:	c7 05 00 b8 10 80 01 	movl   $0x1,0x8010b800
80106d59:	00 00 00 

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
80106d5c:	68 fa 03 00 00       	push   $0x3fa
80106d61:	e8 2c ff ff ff       	call   80106c92 <inb>
80106d66:	83 c4 04             	add    $0x4,%esp
  inb(COM1+0);
80106d69:	68 f8 03 00 00       	push   $0x3f8
80106d6e:	e8 1f ff ff ff       	call   80106c92 <inb>
80106d73:	83 c4 04             	add    $0x4,%esp
  picenable(IRQ_COM1);
80106d76:	83 ec 0c             	sub    $0xc,%esp
80106d79:	6a 04                	push   $0x4
80106d7b:	e8 41 d1 ff ff       	call   80103ec1 <picenable>
80106d80:	83 c4 10             	add    $0x10,%esp
  ioapicenable(IRQ_COM1, 0);
80106d83:	83 ec 08             	sub    $0x8,%esp
80106d86:	6a 00                	push   $0x0
80106d88:	6a 04                	push   $0x4
80106d8a:	e8 fe bc ff ff       	call   80102a8d <ioapicenable>
80106d8f:	83 c4 10             	add    $0x10,%esp
  
  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80106d92:	c7 45 f4 64 8d 10 80 	movl   $0x80108d64,-0xc(%ebp)
80106d99:	eb 19                	jmp    80106db4 <uartinit+0xe7>
    uartputc(*p);
80106d9b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106d9e:	0f b6 00             	movzbl (%eax),%eax
80106da1:	0f be c0             	movsbl %al,%eax
80106da4:	83 ec 0c             	sub    $0xc,%esp
80106da7:	50                   	push   %eax
80106da8:	e8 13 00 00 00       	call   80106dc0 <uartputc>
80106dad:	83 c4 10             	add    $0x10,%esp
  inb(COM1+0);
  picenable(IRQ_COM1);
  ioapicenable(IRQ_COM1, 0);
  
  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80106db0:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80106db4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106db7:	0f b6 00             	movzbl (%eax),%eax
80106dba:	84 c0                	test   %al,%al
80106dbc:	75 dd                	jne    80106d9b <uartinit+0xce>
    uartputc(*p);
}
80106dbe:	c9                   	leave  
80106dbf:	c3                   	ret    

80106dc0 <uartputc>:

void
uartputc(int c)
{
80106dc0:	55                   	push   %ebp
80106dc1:	89 e5                	mov    %esp,%ebp
80106dc3:	83 ec 18             	sub    $0x18,%esp
  int i;

  if(!uart)
80106dc6:	a1 00 b8 10 80       	mov    0x8010b800,%eax
80106dcb:	85 c0                	test   %eax,%eax
80106dcd:	75 02                	jne    80106dd1 <uartputc+0x11>
    return;
80106dcf:	eb 51                	jmp    80106e22 <uartputc+0x62>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80106dd1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80106dd8:	eb 11                	jmp    80106deb <uartputc+0x2b>
    microdelay(10);
80106dda:	83 ec 0c             	sub    $0xc,%esp
80106ddd:	6a 0a                	push   $0xa
80106ddf:	e8 04 c2 ff ff       	call   80102fe8 <microdelay>
80106de4:	83 c4 10             	add    $0x10,%esp
{
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80106de7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80106deb:	83 7d f4 7f          	cmpl   $0x7f,-0xc(%ebp)
80106def:	7f 1a                	jg     80106e0b <uartputc+0x4b>
80106df1:	83 ec 0c             	sub    $0xc,%esp
80106df4:	68 fd 03 00 00       	push   $0x3fd
80106df9:	e8 94 fe ff ff       	call   80106c92 <inb>
80106dfe:	83 c4 10             	add    $0x10,%esp
80106e01:	0f b6 c0             	movzbl %al,%eax
80106e04:	83 e0 20             	and    $0x20,%eax
80106e07:	85 c0                	test   %eax,%eax
80106e09:	74 cf                	je     80106dda <uartputc+0x1a>
    microdelay(10);
  outb(COM1+0, c);
80106e0b:	8b 45 08             	mov    0x8(%ebp),%eax
80106e0e:	0f b6 c0             	movzbl %al,%eax
80106e11:	83 ec 08             	sub    $0x8,%esp
80106e14:	50                   	push   %eax
80106e15:	68 f8 03 00 00       	push   $0x3f8
80106e1a:	e8 90 fe ff ff       	call   80106caf <outb>
80106e1f:	83 c4 10             	add    $0x10,%esp
}
80106e22:	c9                   	leave  
80106e23:	c3                   	ret    

80106e24 <uartgetc>:

static int
uartgetc(void)
{
80106e24:	55                   	push   %ebp
80106e25:	89 e5                	mov    %esp,%ebp
  if(!uart)
80106e27:	a1 00 b8 10 80       	mov    0x8010b800,%eax
80106e2c:	85 c0                	test   %eax,%eax
80106e2e:	75 07                	jne    80106e37 <uartgetc+0x13>
    return -1;
80106e30:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106e35:	eb 2e                	jmp    80106e65 <uartgetc+0x41>
  if(!(inb(COM1+5) & 0x01))
80106e37:	68 fd 03 00 00       	push   $0x3fd
80106e3c:	e8 51 fe ff ff       	call   80106c92 <inb>
80106e41:	83 c4 04             	add    $0x4,%esp
80106e44:	0f b6 c0             	movzbl %al,%eax
80106e47:	83 e0 01             	and    $0x1,%eax
80106e4a:	85 c0                	test   %eax,%eax
80106e4c:	75 07                	jne    80106e55 <uartgetc+0x31>
    return -1;
80106e4e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106e53:	eb 10                	jmp    80106e65 <uartgetc+0x41>
  return inb(COM1+0);
80106e55:	68 f8 03 00 00       	push   $0x3f8
80106e5a:	e8 33 fe ff ff       	call   80106c92 <inb>
80106e5f:	83 c4 04             	add    $0x4,%esp
80106e62:	0f b6 c0             	movzbl %al,%eax
}
80106e65:	c9                   	leave  
80106e66:	c3                   	ret    

80106e67 <uartintr>:

void
uartintr(void)
{
80106e67:	55                   	push   %ebp
80106e68:	89 e5                	mov    %esp,%ebp
80106e6a:	83 ec 08             	sub    $0x8,%esp
  consoleintr(uartgetc);
80106e6d:	83 ec 0c             	sub    $0xc,%esp
80106e70:	68 24 6e 10 80       	push   $0x80106e24
80106e75:	e8 57 99 ff ff       	call   801007d1 <consoleintr>
80106e7a:	83 c4 10             	add    $0x10,%esp
}
80106e7d:	c9                   	leave  
80106e7e:	c3                   	ret    

80106e7f <vector0>:
80106e7f:	6a 00                	push   $0x0
80106e81:	6a 00                	push   $0x0
80106e83:	e9 d7 f9 ff ff       	jmp    8010685f <alltraps>

80106e88 <vector1>:
80106e88:	6a 00                	push   $0x0
80106e8a:	6a 01                	push   $0x1
80106e8c:	e9 ce f9 ff ff       	jmp    8010685f <alltraps>

80106e91 <vector2>:
80106e91:	6a 00                	push   $0x0
80106e93:	6a 02                	push   $0x2
80106e95:	e9 c5 f9 ff ff       	jmp    8010685f <alltraps>

80106e9a <vector3>:
80106e9a:	6a 00                	push   $0x0
80106e9c:	6a 03                	push   $0x3
80106e9e:	e9 bc f9 ff ff       	jmp    8010685f <alltraps>

80106ea3 <vector4>:
80106ea3:	6a 00                	push   $0x0
80106ea5:	6a 04                	push   $0x4
80106ea7:	e9 b3 f9 ff ff       	jmp    8010685f <alltraps>

80106eac <vector5>:
80106eac:	6a 00                	push   $0x0
80106eae:	6a 05                	push   $0x5
80106eb0:	e9 aa f9 ff ff       	jmp    8010685f <alltraps>

80106eb5 <vector6>:
80106eb5:	6a 00                	push   $0x0
80106eb7:	6a 06                	push   $0x6
80106eb9:	e9 a1 f9 ff ff       	jmp    8010685f <alltraps>

80106ebe <vector7>:
80106ebe:	6a 00                	push   $0x0
80106ec0:	6a 07                	push   $0x7
80106ec2:	e9 98 f9 ff ff       	jmp    8010685f <alltraps>

80106ec7 <vector8>:
80106ec7:	6a 08                	push   $0x8
80106ec9:	e9 91 f9 ff ff       	jmp    8010685f <alltraps>

80106ece <vector9>:
80106ece:	6a 00                	push   $0x0
80106ed0:	6a 09                	push   $0x9
80106ed2:	e9 88 f9 ff ff       	jmp    8010685f <alltraps>

80106ed7 <vector10>:
80106ed7:	6a 0a                	push   $0xa
80106ed9:	e9 81 f9 ff ff       	jmp    8010685f <alltraps>

80106ede <vector11>:
80106ede:	6a 0b                	push   $0xb
80106ee0:	e9 7a f9 ff ff       	jmp    8010685f <alltraps>

80106ee5 <vector12>:
80106ee5:	6a 0c                	push   $0xc
80106ee7:	e9 73 f9 ff ff       	jmp    8010685f <alltraps>

80106eec <vector13>:
80106eec:	6a 0d                	push   $0xd
80106eee:	e9 6c f9 ff ff       	jmp    8010685f <alltraps>

80106ef3 <vector14>:
80106ef3:	6a 0e                	push   $0xe
80106ef5:	e9 65 f9 ff ff       	jmp    8010685f <alltraps>

80106efa <vector15>:
80106efa:	6a 00                	push   $0x0
80106efc:	6a 0f                	push   $0xf
80106efe:	e9 5c f9 ff ff       	jmp    8010685f <alltraps>

80106f03 <vector16>:
80106f03:	6a 00                	push   $0x0
80106f05:	6a 10                	push   $0x10
80106f07:	e9 53 f9 ff ff       	jmp    8010685f <alltraps>

80106f0c <vector17>:
80106f0c:	6a 11                	push   $0x11
80106f0e:	e9 4c f9 ff ff       	jmp    8010685f <alltraps>

80106f13 <vector18>:
80106f13:	6a 00                	push   $0x0
80106f15:	6a 12                	push   $0x12
80106f17:	e9 43 f9 ff ff       	jmp    8010685f <alltraps>

80106f1c <vector19>:
80106f1c:	6a 00                	push   $0x0
80106f1e:	6a 13                	push   $0x13
80106f20:	e9 3a f9 ff ff       	jmp    8010685f <alltraps>

80106f25 <vector20>:
80106f25:	6a 00                	push   $0x0
80106f27:	6a 14                	push   $0x14
80106f29:	e9 31 f9 ff ff       	jmp    8010685f <alltraps>

80106f2e <vector21>:
80106f2e:	6a 00                	push   $0x0
80106f30:	6a 15                	push   $0x15
80106f32:	e9 28 f9 ff ff       	jmp    8010685f <alltraps>

80106f37 <vector22>:
80106f37:	6a 00                	push   $0x0
80106f39:	6a 16                	push   $0x16
80106f3b:	e9 1f f9 ff ff       	jmp    8010685f <alltraps>

80106f40 <vector23>:
80106f40:	6a 00                	push   $0x0
80106f42:	6a 17                	push   $0x17
80106f44:	e9 16 f9 ff ff       	jmp    8010685f <alltraps>

80106f49 <vector24>:
80106f49:	6a 00                	push   $0x0
80106f4b:	6a 18                	push   $0x18
80106f4d:	e9 0d f9 ff ff       	jmp    8010685f <alltraps>

80106f52 <vector25>:
80106f52:	6a 00                	push   $0x0
80106f54:	6a 19                	push   $0x19
80106f56:	e9 04 f9 ff ff       	jmp    8010685f <alltraps>

80106f5b <vector26>:
80106f5b:	6a 00                	push   $0x0
80106f5d:	6a 1a                	push   $0x1a
80106f5f:	e9 fb f8 ff ff       	jmp    8010685f <alltraps>

80106f64 <vector27>:
80106f64:	6a 00                	push   $0x0
80106f66:	6a 1b                	push   $0x1b
80106f68:	e9 f2 f8 ff ff       	jmp    8010685f <alltraps>

80106f6d <vector28>:
80106f6d:	6a 00                	push   $0x0
80106f6f:	6a 1c                	push   $0x1c
80106f71:	e9 e9 f8 ff ff       	jmp    8010685f <alltraps>

80106f76 <vector29>:
80106f76:	6a 00                	push   $0x0
80106f78:	6a 1d                	push   $0x1d
80106f7a:	e9 e0 f8 ff ff       	jmp    8010685f <alltraps>

80106f7f <vector30>:
80106f7f:	6a 00                	push   $0x0
80106f81:	6a 1e                	push   $0x1e
80106f83:	e9 d7 f8 ff ff       	jmp    8010685f <alltraps>

80106f88 <vector31>:
80106f88:	6a 00                	push   $0x0
80106f8a:	6a 1f                	push   $0x1f
80106f8c:	e9 ce f8 ff ff       	jmp    8010685f <alltraps>

80106f91 <vector32>:
80106f91:	6a 00                	push   $0x0
80106f93:	6a 20                	push   $0x20
80106f95:	e9 c5 f8 ff ff       	jmp    8010685f <alltraps>

80106f9a <vector33>:
80106f9a:	6a 00                	push   $0x0
80106f9c:	6a 21                	push   $0x21
80106f9e:	e9 bc f8 ff ff       	jmp    8010685f <alltraps>

80106fa3 <vector34>:
80106fa3:	6a 00                	push   $0x0
80106fa5:	6a 22                	push   $0x22
80106fa7:	e9 b3 f8 ff ff       	jmp    8010685f <alltraps>

80106fac <vector35>:
80106fac:	6a 00                	push   $0x0
80106fae:	6a 23                	push   $0x23
80106fb0:	e9 aa f8 ff ff       	jmp    8010685f <alltraps>

80106fb5 <vector36>:
80106fb5:	6a 00                	push   $0x0
80106fb7:	6a 24                	push   $0x24
80106fb9:	e9 a1 f8 ff ff       	jmp    8010685f <alltraps>

80106fbe <vector37>:
80106fbe:	6a 00                	push   $0x0
80106fc0:	6a 25                	push   $0x25
80106fc2:	e9 98 f8 ff ff       	jmp    8010685f <alltraps>

80106fc7 <vector38>:
80106fc7:	6a 00                	push   $0x0
80106fc9:	6a 26                	push   $0x26
80106fcb:	e9 8f f8 ff ff       	jmp    8010685f <alltraps>

80106fd0 <vector39>:
80106fd0:	6a 00                	push   $0x0
80106fd2:	6a 27                	push   $0x27
80106fd4:	e9 86 f8 ff ff       	jmp    8010685f <alltraps>

80106fd9 <vector40>:
80106fd9:	6a 00                	push   $0x0
80106fdb:	6a 28                	push   $0x28
80106fdd:	e9 7d f8 ff ff       	jmp    8010685f <alltraps>

80106fe2 <vector41>:
80106fe2:	6a 00                	push   $0x0
80106fe4:	6a 29                	push   $0x29
80106fe6:	e9 74 f8 ff ff       	jmp    8010685f <alltraps>

80106feb <vector42>:
80106feb:	6a 00                	push   $0x0
80106fed:	6a 2a                	push   $0x2a
80106fef:	e9 6b f8 ff ff       	jmp    8010685f <alltraps>

80106ff4 <vector43>:
80106ff4:	6a 00                	push   $0x0
80106ff6:	6a 2b                	push   $0x2b
80106ff8:	e9 62 f8 ff ff       	jmp    8010685f <alltraps>

80106ffd <vector44>:
80106ffd:	6a 00                	push   $0x0
80106fff:	6a 2c                	push   $0x2c
80107001:	e9 59 f8 ff ff       	jmp    8010685f <alltraps>

80107006 <vector45>:
80107006:	6a 00                	push   $0x0
80107008:	6a 2d                	push   $0x2d
8010700a:	e9 50 f8 ff ff       	jmp    8010685f <alltraps>

8010700f <vector46>:
8010700f:	6a 00                	push   $0x0
80107011:	6a 2e                	push   $0x2e
80107013:	e9 47 f8 ff ff       	jmp    8010685f <alltraps>

80107018 <vector47>:
80107018:	6a 00                	push   $0x0
8010701a:	6a 2f                	push   $0x2f
8010701c:	e9 3e f8 ff ff       	jmp    8010685f <alltraps>

80107021 <vector48>:
80107021:	6a 00                	push   $0x0
80107023:	6a 30                	push   $0x30
80107025:	e9 35 f8 ff ff       	jmp    8010685f <alltraps>

8010702a <vector49>:
8010702a:	6a 00                	push   $0x0
8010702c:	6a 31                	push   $0x31
8010702e:	e9 2c f8 ff ff       	jmp    8010685f <alltraps>

80107033 <vector50>:
80107033:	6a 00                	push   $0x0
80107035:	6a 32                	push   $0x32
80107037:	e9 23 f8 ff ff       	jmp    8010685f <alltraps>

8010703c <vector51>:
8010703c:	6a 00                	push   $0x0
8010703e:	6a 33                	push   $0x33
80107040:	e9 1a f8 ff ff       	jmp    8010685f <alltraps>

80107045 <vector52>:
80107045:	6a 00                	push   $0x0
80107047:	6a 34                	push   $0x34
80107049:	e9 11 f8 ff ff       	jmp    8010685f <alltraps>

8010704e <vector53>:
8010704e:	6a 00                	push   $0x0
80107050:	6a 35                	push   $0x35
80107052:	e9 08 f8 ff ff       	jmp    8010685f <alltraps>

80107057 <vector54>:
80107057:	6a 00                	push   $0x0
80107059:	6a 36                	push   $0x36
8010705b:	e9 ff f7 ff ff       	jmp    8010685f <alltraps>

80107060 <vector55>:
80107060:	6a 00                	push   $0x0
80107062:	6a 37                	push   $0x37
80107064:	e9 f6 f7 ff ff       	jmp    8010685f <alltraps>

80107069 <vector56>:
80107069:	6a 00                	push   $0x0
8010706b:	6a 38                	push   $0x38
8010706d:	e9 ed f7 ff ff       	jmp    8010685f <alltraps>

80107072 <vector57>:
80107072:	6a 00                	push   $0x0
80107074:	6a 39                	push   $0x39
80107076:	e9 e4 f7 ff ff       	jmp    8010685f <alltraps>

8010707b <vector58>:
8010707b:	6a 00                	push   $0x0
8010707d:	6a 3a                	push   $0x3a
8010707f:	e9 db f7 ff ff       	jmp    8010685f <alltraps>

80107084 <vector59>:
80107084:	6a 00                	push   $0x0
80107086:	6a 3b                	push   $0x3b
80107088:	e9 d2 f7 ff ff       	jmp    8010685f <alltraps>

8010708d <vector60>:
8010708d:	6a 00                	push   $0x0
8010708f:	6a 3c                	push   $0x3c
80107091:	e9 c9 f7 ff ff       	jmp    8010685f <alltraps>

80107096 <vector61>:
80107096:	6a 00                	push   $0x0
80107098:	6a 3d                	push   $0x3d
8010709a:	e9 c0 f7 ff ff       	jmp    8010685f <alltraps>

8010709f <vector62>:
8010709f:	6a 00                	push   $0x0
801070a1:	6a 3e                	push   $0x3e
801070a3:	e9 b7 f7 ff ff       	jmp    8010685f <alltraps>

801070a8 <vector63>:
801070a8:	6a 00                	push   $0x0
801070aa:	6a 3f                	push   $0x3f
801070ac:	e9 ae f7 ff ff       	jmp    8010685f <alltraps>

801070b1 <vector64>:
801070b1:	6a 00                	push   $0x0
801070b3:	6a 40                	push   $0x40
801070b5:	e9 a5 f7 ff ff       	jmp    8010685f <alltraps>

801070ba <vector65>:
801070ba:	6a 00                	push   $0x0
801070bc:	6a 41                	push   $0x41
801070be:	e9 9c f7 ff ff       	jmp    8010685f <alltraps>

801070c3 <vector66>:
801070c3:	6a 00                	push   $0x0
801070c5:	6a 42                	push   $0x42
801070c7:	e9 93 f7 ff ff       	jmp    8010685f <alltraps>

801070cc <vector67>:
801070cc:	6a 00                	push   $0x0
801070ce:	6a 43                	push   $0x43
801070d0:	e9 8a f7 ff ff       	jmp    8010685f <alltraps>

801070d5 <vector68>:
801070d5:	6a 00                	push   $0x0
801070d7:	6a 44                	push   $0x44
801070d9:	e9 81 f7 ff ff       	jmp    8010685f <alltraps>

801070de <vector69>:
801070de:	6a 00                	push   $0x0
801070e0:	6a 45                	push   $0x45
801070e2:	e9 78 f7 ff ff       	jmp    8010685f <alltraps>

801070e7 <vector70>:
801070e7:	6a 00                	push   $0x0
801070e9:	6a 46                	push   $0x46
801070eb:	e9 6f f7 ff ff       	jmp    8010685f <alltraps>

801070f0 <vector71>:
801070f0:	6a 00                	push   $0x0
801070f2:	6a 47                	push   $0x47
801070f4:	e9 66 f7 ff ff       	jmp    8010685f <alltraps>

801070f9 <vector72>:
801070f9:	6a 00                	push   $0x0
801070fb:	6a 48                	push   $0x48
801070fd:	e9 5d f7 ff ff       	jmp    8010685f <alltraps>

80107102 <vector73>:
80107102:	6a 00                	push   $0x0
80107104:	6a 49                	push   $0x49
80107106:	e9 54 f7 ff ff       	jmp    8010685f <alltraps>

8010710b <vector74>:
8010710b:	6a 00                	push   $0x0
8010710d:	6a 4a                	push   $0x4a
8010710f:	e9 4b f7 ff ff       	jmp    8010685f <alltraps>

80107114 <vector75>:
80107114:	6a 00                	push   $0x0
80107116:	6a 4b                	push   $0x4b
80107118:	e9 42 f7 ff ff       	jmp    8010685f <alltraps>

8010711d <vector76>:
8010711d:	6a 00                	push   $0x0
8010711f:	6a 4c                	push   $0x4c
80107121:	e9 39 f7 ff ff       	jmp    8010685f <alltraps>

80107126 <vector77>:
80107126:	6a 00                	push   $0x0
80107128:	6a 4d                	push   $0x4d
8010712a:	e9 30 f7 ff ff       	jmp    8010685f <alltraps>

8010712f <vector78>:
8010712f:	6a 00                	push   $0x0
80107131:	6a 4e                	push   $0x4e
80107133:	e9 27 f7 ff ff       	jmp    8010685f <alltraps>

80107138 <vector79>:
80107138:	6a 00                	push   $0x0
8010713a:	6a 4f                	push   $0x4f
8010713c:	e9 1e f7 ff ff       	jmp    8010685f <alltraps>

80107141 <vector80>:
80107141:	6a 00                	push   $0x0
80107143:	6a 50                	push   $0x50
80107145:	e9 15 f7 ff ff       	jmp    8010685f <alltraps>

8010714a <vector81>:
8010714a:	6a 00                	push   $0x0
8010714c:	6a 51                	push   $0x51
8010714e:	e9 0c f7 ff ff       	jmp    8010685f <alltraps>

80107153 <vector82>:
80107153:	6a 00                	push   $0x0
80107155:	6a 52                	push   $0x52
80107157:	e9 03 f7 ff ff       	jmp    8010685f <alltraps>

8010715c <vector83>:
8010715c:	6a 00                	push   $0x0
8010715e:	6a 53                	push   $0x53
80107160:	e9 fa f6 ff ff       	jmp    8010685f <alltraps>

80107165 <vector84>:
80107165:	6a 00                	push   $0x0
80107167:	6a 54                	push   $0x54
80107169:	e9 f1 f6 ff ff       	jmp    8010685f <alltraps>

8010716e <vector85>:
8010716e:	6a 00                	push   $0x0
80107170:	6a 55                	push   $0x55
80107172:	e9 e8 f6 ff ff       	jmp    8010685f <alltraps>

80107177 <vector86>:
80107177:	6a 00                	push   $0x0
80107179:	6a 56                	push   $0x56
8010717b:	e9 df f6 ff ff       	jmp    8010685f <alltraps>

80107180 <vector87>:
80107180:	6a 00                	push   $0x0
80107182:	6a 57                	push   $0x57
80107184:	e9 d6 f6 ff ff       	jmp    8010685f <alltraps>

80107189 <vector88>:
80107189:	6a 00                	push   $0x0
8010718b:	6a 58                	push   $0x58
8010718d:	e9 cd f6 ff ff       	jmp    8010685f <alltraps>

80107192 <vector89>:
80107192:	6a 00                	push   $0x0
80107194:	6a 59                	push   $0x59
80107196:	e9 c4 f6 ff ff       	jmp    8010685f <alltraps>

8010719b <vector90>:
8010719b:	6a 00                	push   $0x0
8010719d:	6a 5a                	push   $0x5a
8010719f:	e9 bb f6 ff ff       	jmp    8010685f <alltraps>

801071a4 <vector91>:
801071a4:	6a 00                	push   $0x0
801071a6:	6a 5b                	push   $0x5b
801071a8:	e9 b2 f6 ff ff       	jmp    8010685f <alltraps>

801071ad <vector92>:
801071ad:	6a 00                	push   $0x0
801071af:	6a 5c                	push   $0x5c
801071b1:	e9 a9 f6 ff ff       	jmp    8010685f <alltraps>

801071b6 <vector93>:
801071b6:	6a 00                	push   $0x0
801071b8:	6a 5d                	push   $0x5d
801071ba:	e9 a0 f6 ff ff       	jmp    8010685f <alltraps>

801071bf <vector94>:
801071bf:	6a 00                	push   $0x0
801071c1:	6a 5e                	push   $0x5e
801071c3:	e9 97 f6 ff ff       	jmp    8010685f <alltraps>

801071c8 <vector95>:
801071c8:	6a 00                	push   $0x0
801071ca:	6a 5f                	push   $0x5f
801071cc:	e9 8e f6 ff ff       	jmp    8010685f <alltraps>

801071d1 <vector96>:
801071d1:	6a 00                	push   $0x0
801071d3:	6a 60                	push   $0x60
801071d5:	e9 85 f6 ff ff       	jmp    8010685f <alltraps>

801071da <vector97>:
801071da:	6a 00                	push   $0x0
801071dc:	6a 61                	push   $0x61
801071de:	e9 7c f6 ff ff       	jmp    8010685f <alltraps>

801071e3 <vector98>:
801071e3:	6a 00                	push   $0x0
801071e5:	6a 62                	push   $0x62
801071e7:	e9 73 f6 ff ff       	jmp    8010685f <alltraps>

801071ec <vector99>:
801071ec:	6a 00                	push   $0x0
801071ee:	6a 63                	push   $0x63
801071f0:	e9 6a f6 ff ff       	jmp    8010685f <alltraps>

801071f5 <vector100>:
801071f5:	6a 00                	push   $0x0
801071f7:	6a 64                	push   $0x64
801071f9:	e9 61 f6 ff ff       	jmp    8010685f <alltraps>

801071fe <vector101>:
801071fe:	6a 00                	push   $0x0
80107200:	6a 65                	push   $0x65
80107202:	e9 58 f6 ff ff       	jmp    8010685f <alltraps>

80107207 <vector102>:
80107207:	6a 00                	push   $0x0
80107209:	6a 66                	push   $0x66
8010720b:	e9 4f f6 ff ff       	jmp    8010685f <alltraps>

80107210 <vector103>:
80107210:	6a 00                	push   $0x0
80107212:	6a 67                	push   $0x67
80107214:	e9 46 f6 ff ff       	jmp    8010685f <alltraps>

80107219 <vector104>:
80107219:	6a 00                	push   $0x0
8010721b:	6a 68                	push   $0x68
8010721d:	e9 3d f6 ff ff       	jmp    8010685f <alltraps>

80107222 <vector105>:
80107222:	6a 00                	push   $0x0
80107224:	6a 69                	push   $0x69
80107226:	e9 34 f6 ff ff       	jmp    8010685f <alltraps>

8010722b <vector106>:
8010722b:	6a 00                	push   $0x0
8010722d:	6a 6a                	push   $0x6a
8010722f:	e9 2b f6 ff ff       	jmp    8010685f <alltraps>

80107234 <vector107>:
80107234:	6a 00                	push   $0x0
80107236:	6a 6b                	push   $0x6b
80107238:	e9 22 f6 ff ff       	jmp    8010685f <alltraps>

8010723d <vector108>:
8010723d:	6a 00                	push   $0x0
8010723f:	6a 6c                	push   $0x6c
80107241:	e9 19 f6 ff ff       	jmp    8010685f <alltraps>

80107246 <vector109>:
80107246:	6a 00                	push   $0x0
80107248:	6a 6d                	push   $0x6d
8010724a:	e9 10 f6 ff ff       	jmp    8010685f <alltraps>

8010724f <vector110>:
8010724f:	6a 00                	push   $0x0
80107251:	6a 6e                	push   $0x6e
80107253:	e9 07 f6 ff ff       	jmp    8010685f <alltraps>

80107258 <vector111>:
80107258:	6a 00                	push   $0x0
8010725a:	6a 6f                	push   $0x6f
8010725c:	e9 fe f5 ff ff       	jmp    8010685f <alltraps>

80107261 <vector112>:
80107261:	6a 00                	push   $0x0
80107263:	6a 70                	push   $0x70
80107265:	e9 f5 f5 ff ff       	jmp    8010685f <alltraps>

8010726a <vector113>:
8010726a:	6a 00                	push   $0x0
8010726c:	6a 71                	push   $0x71
8010726e:	e9 ec f5 ff ff       	jmp    8010685f <alltraps>

80107273 <vector114>:
80107273:	6a 00                	push   $0x0
80107275:	6a 72                	push   $0x72
80107277:	e9 e3 f5 ff ff       	jmp    8010685f <alltraps>

8010727c <vector115>:
8010727c:	6a 00                	push   $0x0
8010727e:	6a 73                	push   $0x73
80107280:	e9 da f5 ff ff       	jmp    8010685f <alltraps>

80107285 <vector116>:
80107285:	6a 00                	push   $0x0
80107287:	6a 74                	push   $0x74
80107289:	e9 d1 f5 ff ff       	jmp    8010685f <alltraps>

8010728e <vector117>:
8010728e:	6a 00                	push   $0x0
80107290:	6a 75                	push   $0x75
80107292:	e9 c8 f5 ff ff       	jmp    8010685f <alltraps>

80107297 <vector118>:
80107297:	6a 00                	push   $0x0
80107299:	6a 76                	push   $0x76
8010729b:	e9 bf f5 ff ff       	jmp    8010685f <alltraps>

801072a0 <vector119>:
801072a0:	6a 00                	push   $0x0
801072a2:	6a 77                	push   $0x77
801072a4:	e9 b6 f5 ff ff       	jmp    8010685f <alltraps>

801072a9 <vector120>:
801072a9:	6a 00                	push   $0x0
801072ab:	6a 78                	push   $0x78
801072ad:	e9 ad f5 ff ff       	jmp    8010685f <alltraps>

801072b2 <vector121>:
801072b2:	6a 00                	push   $0x0
801072b4:	6a 79                	push   $0x79
801072b6:	e9 a4 f5 ff ff       	jmp    8010685f <alltraps>

801072bb <vector122>:
801072bb:	6a 00                	push   $0x0
801072bd:	6a 7a                	push   $0x7a
801072bf:	e9 9b f5 ff ff       	jmp    8010685f <alltraps>

801072c4 <vector123>:
801072c4:	6a 00                	push   $0x0
801072c6:	6a 7b                	push   $0x7b
801072c8:	e9 92 f5 ff ff       	jmp    8010685f <alltraps>

801072cd <vector124>:
801072cd:	6a 00                	push   $0x0
801072cf:	6a 7c                	push   $0x7c
801072d1:	e9 89 f5 ff ff       	jmp    8010685f <alltraps>

801072d6 <vector125>:
801072d6:	6a 00                	push   $0x0
801072d8:	6a 7d                	push   $0x7d
801072da:	e9 80 f5 ff ff       	jmp    8010685f <alltraps>

801072df <vector126>:
801072df:	6a 00                	push   $0x0
801072e1:	6a 7e                	push   $0x7e
801072e3:	e9 77 f5 ff ff       	jmp    8010685f <alltraps>

801072e8 <vector127>:
801072e8:	6a 00                	push   $0x0
801072ea:	6a 7f                	push   $0x7f
801072ec:	e9 6e f5 ff ff       	jmp    8010685f <alltraps>

801072f1 <vector128>:
801072f1:	6a 00                	push   $0x0
801072f3:	68 80 00 00 00       	push   $0x80
801072f8:	e9 62 f5 ff ff       	jmp    8010685f <alltraps>

801072fd <vector129>:
801072fd:	6a 00                	push   $0x0
801072ff:	68 81 00 00 00       	push   $0x81
80107304:	e9 56 f5 ff ff       	jmp    8010685f <alltraps>

80107309 <vector130>:
80107309:	6a 00                	push   $0x0
8010730b:	68 82 00 00 00       	push   $0x82
80107310:	e9 4a f5 ff ff       	jmp    8010685f <alltraps>

80107315 <vector131>:
80107315:	6a 00                	push   $0x0
80107317:	68 83 00 00 00       	push   $0x83
8010731c:	e9 3e f5 ff ff       	jmp    8010685f <alltraps>

80107321 <vector132>:
80107321:	6a 00                	push   $0x0
80107323:	68 84 00 00 00       	push   $0x84
80107328:	e9 32 f5 ff ff       	jmp    8010685f <alltraps>

8010732d <vector133>:
8010732d:	6a 00                	push   $0x0
8010732f:	68 85 00 00 00       	push   $0x85
80107334:	e9 26 f5 ff ff       	jmp    8010685f <alltraps>

80107339 <vector134>:
80107339:	6a 00                	push   $0x0
8010733b:	68 86 00 00 00       	push   $0x86
80107340:	e9 1a f5 ff ff       	jmp    8010685f <alltraps>

80107345 <vector135>:
80107345:	6a 00                	push   $0x0
80107347:	68 87 00 00 00       	push   $0x87
8010734c:	e9 0e f5 ff ff       	jmp    8010685f <alltraps>

80107351 <vector136>:
80107351:	6a 00                	push   $0x0
80107353:	68 88 00 00 00       	push   $0x88
80107358:	e9 02 f5 ff ff       	jmp    8010685f <alltraps>

8010735d <vector137>:
8010735d:	6a 00                	push   $0x0
8010735f:	68 89 00 00 00       	push   $0x89
80107364:	e9 f6 f4 ff ff       	jmp    8010685f <alltraps>

80107369 <vector138>:
80107369:	6a 00                	push   $0x0
8010736b:	68 8a 00 00 00       	push   $0x8a
80107370:	e9 ea f4 ff ff       	jmp    8010685f <alltraps>

80107375 <vector139>:
80107375:	6a 00                	push   $0x0
80107377:	68 8b 00 00 00       	push   $0x8b
8010737c:	e9 de f4 ff ff       	jmp    8010685f <alltraps>

80107381 <vector140>:
80107381:	6a 00                	push   $0x0
80107383:	68 8c 00 00 00       	push   $0x8c
80107388:	e9 d2 f4 ff ff       	jmp    8010685f <alltraps>

8010738d <vector141>:
8010738d:	6a 00                	push   $0x0
8010738f:	68 8d 00 00 00       	push   $0x8d
80107394:	e9 c6 f4 ff ff       	jmp    8010685f <alltraps>

80107399 <vector142>:
80107399:	6a 00                	push   $0x0
8010739b:	68 8e 00 00 00       	push   $0x8e
801073a0:	e9 ba f4 ff ff       	jmp    8010685f <alltraps>

801073a5 <vector143>:
801073a5:	6a 00                	push   $0x0
801073a7:	68 8f 00 00 00       	push   $0x8f
801073ac:	e9 ae f4 ff ff       	jmp    8010685f <alltraps>

801073b1 <vector144>:
801073b1:	6a 00                	push   $0x0
801073b3:	68 90 00 00 00       	push   $0x90
801073b8:	e9 a2 f4 ff ff       	jmp    8010685f <alltraps>

801073bd <vector145>:
801073bd:	6a 00                	push   $0x0
801073bf:	68 91 00 00 00       	push   $0x91
801073c4:	e9 96 f4 ff ff       	jmp    8010685f <alltraps>

801073c9 <vector146>:
801073c9:	6a 00                	push   $0x0
801073cb:	68 92 00 00 00       	push   $0x92
801073d0:	e9 8a f4 ff ff       	jmp    8010685f <alltraps>

801073d5 <vector147>:
801073d5:	6a 00                	push   $0x0
801073d7:	68 93 00 00 00       	push   $0x93
801073dc:	e9 7e f4 ff ff       	jmp    8010685f <alltraps>

801073e1 <vector148>:
801073e1:	6a 00                	push   $0x0
801073e3:	68 94 00 00 00       	push   $0x94
801073e8:	e9 72 f4 ff ff       	jmp    8010685f <alltraps>

801073ed <vector149>:
801073ed:	6a 00                	push   $0x0
801073ef:	68 95 00 00 00       	push   $0x95
801073f4:	e9 66 f4 ff ff       	jmp    8010685f <alltraps>

801073f9 <vector150>:
801073f9:	6a 00                	push   $0x0
801073fb:	68 96 00 00 00       	push   $0x96
80107400:	e9 5a f4 ff ff       	jmp    8010685f <alltraps>

80107405 <vector151>:
80107405:	6a 00                	push   $0x0
80107407:	68 97 00 00 00       	push   $0x97
8010740c:	e9 4e f4 ff ff       	jmp    8010685f <alltraps>

80107411 <vector152>:
80107411:	6a 00                	push   $0x0
80107413:	68 98 00 00 00       	push   $0x98
80107418:	e9 42 f4 ff ff       	jmp    8010685f <alltraps>

8010741d <vector153>:
8010741d:	6a 00                	push   $0x0
8010741f:	68 99 00 00 00       	push   $0x99
80107424:	e9 36 f4 ff ff       	jmp    8010685f <alltraps>

80107429 <vector154>:
80107429:	6a 00                	push   $0x0
8010742b:	68 9a 00 00 00       	push   $0x9a
80107430:	e9 2a f4 ff ff       	jmp    8010685f <alltraps>

80107435 <vector155>:
80107435:	6a 00                	push   $0x0
80107437:	68 9b 00 00 00       	push   $0x9b
8010743c:	e9 1e f4 ff ff       	jmp    8010685f <alltraps>

80107441 <vector156>:
80107441:	6a 00                	push   $0x0
80107443:	68 9c 00 00 00       	push   $0x9c
80107448:	e9 12 f4 ff ff       	jmp    8010685f <alltraps>

8010744d <vector157>:
8010744d:	6a 00                	push   $0x0
8010744f:	68 9d 00 00 00       	push   $0x9d
80107454:	e9 06 f4 ff ff       	jmp    8010685f <alltraps>

80107459 <vector158>:
80107459:	6a 00                	push   $0x0
8010745b:	68 9e 00 00 00       	push   $0x9e
80107460:	e9 fa f3 ff ff       	jmp    8010685f <alltraps>

80107465 <vector159>:
80107465:	6a 00                	push   $0x0
80107467:	68 9f 00 00 00       	push   $0x9f
8010746c:	e9 ee f3 ff ff       	jmp    8010685f <alltraps>

80107471 <vector160>:
80107471:	6a 00                	push   $0x0
80107473:	68 a0 00 00 00       	push   $0xa0
80107478:	e9 e2 f3 ff ff       	jmp    8010685f <alltraps>

8010747d <vector161>:
8010747d:	6a 00                	push   $0x0
8010747f:	68 a1 00 00 00       	push   $0xa1
80107484:	e9 d6 f3 ff ff       	jmp    8010685f <alltraps>

80107489 <vector162>:
80107489:	6a 00                	push   $0x0
8010748b:	68 a2 00 00 00       	push   $0xa2
80107490:	e9 ca f3 ff ff       	jmp    8010685f <alltraps>

80107495 <vector163>:
80107495:	6a 00                	push   $0x0
80107497:	68 a3 00 00 00       	push   $0xa3
8010749c:	e9 be f3 ff ff       	jmp    8010685f <alltraps>

801074a1 <vector164>:
801074a1:	6a 00                	push   $0x0
801074a3:	68 a4 00 00 00       	push   $0xa4
801074a8:	e9 b2 f3 ff ff       	jmp    8010685f <alltraps>

801074ad <vector165>:
801074ad:	6a 00                	push   $0x0
801074af:	68 a5 00 00 00       	push   $0xa5
801074b4:	e9 a6 f3 ff ff       	jmp    8010685f <alltraps>

801074b9 <vector166>:
801074b9:	6a 00                	push   $0x0
801074bb:	68 a6 00 00 00       	push   $0xa6
801074c0:	e9 9a f3 ff ff       	jmp    8010685f <alltraps>

801074c5 <vector167>:
801074c5:	6a 00                	push   $0x0
801074c7:	68 a7 00 00 00       	push   $0xa7
801074cc:	e9 8e f3 ff ff       	jmp    8010685f <alltraps>

801074d1 <vector168>:
801074d1:	6a 00                	push   $0x0
801074d3:	68 a8 00 00 00       	push   $0xa8
801074d8:	e9 82 f3 ff ff       	jmp    8010685f <alltraps>

801074dd <vector169>:
801074dd:	6a 00                	push   $0x0
801074df:	68 a9 00 00 00       	push   $0xa9
801074e4:	e9 76 f3 ff ff       	jmp    8010685f <alltraps>

801074e9 <vector170>:
801074e9:	6a 00                	push   $0x0
801074eb:	68 aa 00 00 00       	push   $0xaa
801074f0:	e9 6a f3 ff ff       	jmp    8010685f <alltraps>

801074f5 <vector171>:
801074f5:	6a 00                	push   $0x0
801074f7:	68 ab 00 00 00       	push   $0xab
801074fc:	e9 5e f3 ff ff       	jmp    8010685f <alltraps>

80107501 <vector172>:
80107501:	6a 00                	push   $0x0
80107503:	68 ac 00 00 00       	push   $0xac
80107508:	e9 52 f3 ff ff       	jmp    8010685f <alltraps>

8010750d <vector173>:
8010750d:	6a 00                	push   $0x0
8010750f:	68 ad 00 00 00       	push   $0xad
80107514:	e9 46 f3 ff ff       	jmp    8010685f <alltraps>

80107519 <vector174>:
80107519:	6a 00                	push   $0x0
8010751b:	68 ae 00 00 00       	push   $0xae
80107520:	e9 3a f3 ff ff       	jmp    8010685f <alltraps>

80107525 <vector175>:
80107525:	6a 00                	push   $0x0
80107527:	68 af 00 00 00       	push   $0xaf
8010752c:	e9 2e f3 ff ff       	jmp    8010685f <alltraps>

80107531 <vector176>:
80107531:	6a 00                	push   $0x0
80107533:	68 b0 00 00 00       	push   $0xb0
80107538:	e9 22 f3 ff ff       	jmp    8010685f <alltraps>

8010753d <vector177>:
8010753d:	6a 00                	push   $0x0
8010753f:	68 b1 00 00 00       	push   $0xb1
80107544:	e9 16 f3 ff ff       	jmp    8010685f <alltraps>

80107549 <vector178>:
80107549:	6a 00                	push   $0x0
8010754b:	68 b2 00 00 00       	push   $0xb2
80107550:	e9 0a f3 ff ff       	jmp    8010685f <alltraps>

80107555 <vector179>:
80107555:	6a 00                	push   $0x0
80107557:	68 b3 00 00 00       	push   $0xb3
8010755c:	e9 fe f2 ff ff       	jmp    8010685f <alltraps>

80107561 <vector180>:
80107561:	6a 00                	push   $0x0
80107563:	68 b4 00 00 00       	push   $0xb4
80107568:	e9 f2 f2 ff ff       	jmp    8010685f <alltraps>

8010756d <vector181>:
8010756d:	6a 00                	push   $0x0
8010756f:	68 b5 00 00 00       	push   $0xb5
80107574:	e9 e6 f2 ff ff       	jmp    8010685f <alltraps>

80107579 <vector182>:
80107579:	6a 00                	push   $0x0
8010757b:	68 b6 00 00 00       	push   $0xb6
80107580:	e9 da f2 ff ff       	jmp    8010685f <alltraps>

80107585 <vector183>:
80107585:	6a 00                	push   $0x0
80107587:	68 b7 00 00 00       	push   $0xb7
8010758c:	e9 ce f2 ff ff       	jmp    8010685f <alltraps>

80107591 <vector184>:
80107591:	6a 00                	push   $0x0
80107593:	68 b8 00 00 00       	push   $0xb8
80107598:	e9 c2 f2 ff ff       	jmp    8010685f <alltraps>

8010759d <vector185>:
8010759d:	6a 00                	push   $0x0
8010759f:	68 b9 00 00 00       	push   $0xb9
801075a4:	e9 b6 f2 ff ff       	jmp    8010685f <alltraps>

801075a9 <vector186>:
801075a9:	6a 00                	push   $0x0
801075ab:	68 ba 00 00 00       	push   $0xba
801075b0:	e9 aa f2 ff ff       	jmp    8010685f <alltraps>

801075b5 <vector187>:
801075b5:	6a 00                	push   $0x0
801075b7:	68 bb 00 00 00       	push   $0xbb
801075bc:	e9 9e f2 ff ff       	jmp    8010685f <alltraps>

801075c1 <vector188>:
801075c1:	6a 00                	push   $0x0
801075c3:	68 bc 00 00 00       	push   $0xbc
801075c8:	e9 92 f2 ff ff       	jmp    8010685f <alltraps>

801075cd <vector189>:
801075cd:	6a 00                	push   $0x0
801075cf:	68 bd 00 00 00       	push   $0xbd
801075d4:	e9 86 f2 ff ff       	jmp    8010685f <alltraps>

801075d9 <vector190>:
801075d9:	6a 00                	push   $0x0
801075db:	68 be 00 00 00       	push   $0xbe
801075e0:	e9 7a f2 ff ff       	jmp    8010685f <alltraps>

801075e5 <vector191>:
801075e5:	6a 00                	push   $0x0
801075e7:	68 bf 00 00 00       	push   $0xbf
801075ec:	e9 6e f2 ff ff       	jmp    8010685f <alltraps>

801075f1 <vector192>:
801075f1:	6a 00                	push   $0x0
801075f3:	68 c0 00 00 00       	push   $0xc0
801075f8:	e9 62 f2 ff ff       	jmp    8010685f <alltraps>

801075fd <vector193>:
801075fd:	6a 00                	push   $0x0
801075ff:	68 c1 00 00 00       	push   $0xc1
80107604:	e9 56 f2 ff ff       	jmp    8010685f <alltraps>

80107609 <vector194>:
80107609:	6a 00                	push   $0x0
8010760b:	68 c2 00 00 00       	push   $0xc2
80107610:	e9 4a f2 ff ff       	jmp    8010685f <alltraps>

80107615 <vector195>:
80107615:	6a 00                	push   $0x0
80107617:	68 c3 00 00 00       	push   $0xc3
8010761c:	e9 3e f2 ff ff       	jmp    8010685f <alltraps>

80107621 <vector196>:
80107621:	6a 00                	push   $0x0
80107623:	68 c4 00 00 00       	push   $0xc4
80107628:	e9 32 f2 ff ff       	jmp    8010685f <alltraps>

8010762d <vector197>:
8010762d:	6a 00                	push   $0x0
8010762f:	68 c5 00 00 00       	push   $0xc5
80107634:	e9 26 f2 ff ff       	jmp    8010685f <alltraps>

80107639 <vector198>:
80107639:	6a 00                	push   $0x0
8010763b:	68 c6 00 00 00       	push   $0xc6
80107640:	e9 1a f2 ff ff       	jmp    8010685f <alltraps>

80107645 <vector199>:
80107645:	6a 00                	push   $0x0
80107647:	68 c7 00 00 00       	push   $0xc7
8010764c:	e9 0e f2 ff ff       	jmp    8010685f <alltraps>

80107651 <vector200>:
80107651:	6a 00                	push   $0x0
80107653:	68 c8 00 00 00       	push   $0xc8
80107658:	e9 02 f2 ff ff       	jmp    8010685f <alltraps>

8010765d <vector201>:
8010765d:	6a 00                	push   $0x0
8010765f:	68 c9 00 00 00       	push   $0xc9
80107664:	e9 f6 f1 ff ff       	jmp    8010685f <alltraps>

80107669 <vector202>:
80107669:	6a 00                	push   $0x0
8010766b:	68 ca 00 00 00       	push   $0xca
80107670:	e9 ea f1 ff ff       	jmp    8010685f <alltraps>

80107675 <vector203>:
80107675:	6a 00                	push   $0x0
80107677:	68 cb 00 00 00       	push   $0xcb
8010767c:	e9 de f1 ff ff       	jmp    8010685f <alltraps>

80107681 <vector204>:
80107681:	6a 00                	push   $0x0
80107683:	68 cc 00 00 00       	push   $0xcc
80107688:	e9 d2 f1 ff ff       	jmp    8010685f <alltraps>

8010768d <vector205>:
8010768d:	6a 00                	push   $0x0
8010768f:	68 cd 00 00 00       	push   $0xcd
80107694:	e9 c6 f1 ff ff       	jmp    8010685f <alltraps>

80107699 <vector206>:
80107699:	6a 00                	push   $0x0
8010769b:	68 ce 00 00 00       	push   $0xce
801076a0:	e9 ba f1 ff ff       	jmp    8010685f <alltraps>

801076a5 <vector207>:
801076a5:	6a 00                	push   $0x0
801076a7:	68 cf 00 00 00       	push   $0xcf
801076ac:	e9 ae f1 ff ff       	jmp    8010685f <alltraps>

801076b1 <vector208>:
801076b1:	6a 00                	push   $0x0
801076b3:	68 d0 00 00 00       	push   $0xd0
801076b8:	e9 a2 f1 ff ff       	jmp    8010685f <alltraps>

801076bd <vector209>:
801076bd:	6a 00                	push   $0x0
801076bf:	68 d1 00 00 00       	push   $0xd1
801076c4:	e9 96 f1 ff ff       	jmp    8010685f <alltraps>

801076c9 <vector210>:
801076c9:	6a 00                	push   $0x0
801076cb:	68 d2 00 00 00       	push   $0xd2
801076d0:	e9 8a f1 ff ff       	jmp    8010685f <alltraps>

801076d5 <vector211>:
801076d5:	6a 00                	push   $0x0
801076d7:	68 d3 00 00 00       	push   $0xd3
801076dc:	e9 7e f1 ff ff       	jmp    8010685f <alltraps>

801076e1 <vector212>:
801076e1:	6a 00                	push   $0x0
801076e3:	68 d4 00 00 00       	push   $0xd4
801076e8:	e9 72 f1 ff ff       	jmp    8010685f <alltraps>

801076ed <vector213>:
801076ed:	6a 00                	push   $0x0
801076ef:	68 d5 00 00 00       	push   $0xd5
801076f4:	e9 66 f1 ff ff       	jmp    8010685f <alltraps>

801076f9 <vector214>:
801076f9:	6a 00                	push   $0x0
801076fb:	68 d6 00 00 00       	push   $0xd6
80107700:	e9 5a f1 ff ff       	jmp    8010685f <alltraps>

80107705 <vector215>:
80107705:	6a 00                	push   $0x0
80107707:	68 d7 00 00 00       	push   $0xd7
8010770c:	e9 4e f1 ff ff       	jmp    8010685f <alltraps>

80107711 <vector216>:
80107711:	6a 00                	push   $0x0
80107713:	68 d8 00 00 00       	push   $0xd8
80107718:	e9 42 f1 ff ff       	jmp    8010685f <alltraps>

8010771d <vector217>:
8010771d:	6a 00                	push   $0x0
8010771f:	68 d9 00 00 00       	push   $0xd9
80107724:	e9 36 f1 ff ff       	jmp    8010685f <alltraps>

80107729 <vector218>:
80107729:	6a 00                	push   $0x0
8010772b:	68 da 00 00 00       	push   $0xda
80107730:	e9 2a f1 ff ff       	jmp    8010685f <alltraps>

80107735 <vector219>:
80107735:	6a 00                	push   $0x0
80107737:	68 db 00 00 00       	push   $0xdb
8010773c:	e9 1e f1 ff ff       	jmp    8010685f <alltraps>

80107741 <vector220>:
80107741:	6a 00                	push   $0x0
80107743:	68 dc 00 00 00       	push   $0xdc
80107748:	e9 12 f1 ff ff       	jmp    8010685f <alltraps>

8010774d <vector221>:
8010774d:	6a 00                	push   $0x0
8010774f:	68 dd 00 00 00       	push   $0xdd
80107754:	e9 06 f1 ff ff       	jmp    8010685f <alltraps>

80107759 <vector222>:
80107759:	6a 00                	push   $0x0
8010775b:	68 de 00 00 00       	push   $0xde
80107760:	e9 fa f0 ff ff       	jmp    8010685f <alltraps>

80107765 <vector223>:
80107765:	6a 00                	push   $0x0
80107767:	68 df 00 00 00       	push   $0xdf
8010776c:	e9 ee f0 ff ff       	jmp    8010685f <alltraps>

80107771 <vector224>:
80107771:	6a 00                	push   $0x0
80107773:	68 e0 00 00 00       	push   $0xe0
80107778:	e9 e2 f0 ff ff       	jmp    8010685f <alltraps>

8010777d <vector225>:
8010777d:	6a 00                	push   $0x0
8010777f:	68 e1 00 00 00       	push   $0xe1
80107784:	e9 d6 f0 ff ff       	jmp    8010685f <alltraps>

80107789 <vector226>:
80107789:	6a 00                	push   $0x0
8010778b:	68 e2 00 00 00       	push   $0xe2
80107790:	e9 ca f0 ff ff       	jmp    8010685f <alltraps>

80107795 <vector227>:
80107795:	6a 00                	push   $0x0
80107797:	68 e3 00 00 00       	push   $0xe3
8010779c:	e9 be f0 ff ff       	jmp    8010685f <alltraps>

801077a1 <vector228>:
801077a1:	6a 00                	push   $0x0
801077a3:	68 e4 00 00 00       	push   $0xe4
801077a8:	e9 b2 f0 ff ff       	jmp    8010685f <alltraps>

801077ad <vector229>:
801077ad:	6a 00                	push   $0x0
801077af:	68 e5 00 00 00       	push   $0xe5
801077b4:	e9 a6 f0 ff ff       	jmp    8010685f <alltraps>

801077b9 <vector230>:
801077b9:	6a 00                	push   $0x0
801077bb:	68 e6 00 00 00       	push   $0xe6
801077c0:	e9 9a f0 ff ff       	jmp    8010685f <alltraps>

801077c5 <vector231>:
801077c5:	6a 00                	push   $0x0
801077c7:	68 e7 00 00 00       	push   $0xe7
801077cc:	e9 8e f0 ff ff       	jmp    8010685f <alltraps>

801077d1 <vector232>:
801077d1:	6a 00                	push   $0x0
801077d3:	68 e8 00 00 00       	push   $0xe8
801077d8:	e9 82 f0 ff ff       	jmp    8010685f <alltraps>

801077dd <vector233>:
801077dd:	6a 00                	push   $0x0
801077df:	68 e9 00 00 00       	push   $0xe9
801077e4:	e9 76 f0 ff ff       	jmp    8010685f <alltraps>

801077e9 <vector234>:
801077e9:	6a 00                	push   $0x0
801077eb:	68 ea 00 00 00       	push   $0xea
801077f0:	e9 6a f0 ff ff       	jmp    8010685f <alltraps>

801077f5 <vector235>:
801077f5:	6a 00                	push   $0x0
801077f7:	68 eb 00 00 00       	push   $0xeb
801077fc:	e9 5e f0 ff ff       	jmp    8010685f <alltraps>

80107801 <vector236>:
80107801:	6a 00                	push   $0x0
80107803:	68 ec 00 00 00       	push   $0xec
80107808:	e9 52 f0 ff ff       	jmp    8010685f <alltraps>

8010780d <vector237>:
8010780d:	6a 00                	push   $0x0
8010780f:	68 ed 00 00 00       	push   $0xed
80107814:	e9 46 f0 ff ff       	jmp    8010685f <alltraps>

80107819 <vector238>:
80107819:	6a 00                	push   $0x0
8010781b:	68 ee 00 00 00       	push   $0xee
80107820:	e9 3a f0 ff ff       	jmp    8010685f <alltraps>

80107825 <vector239>:
80107825:	6a 00                	push   $0x0
80107827:	68 ef 00 00 00       	push   $0xef
8010782c:	e9 2e f0 ff ff       	jmp    8010685f <alltraps>

80107831 <vector240>:
80107831:	6a 00                	push   $0x0
80107833:	68 f0 00 00 00       	push   $0xf0
80107838:	e9 22 f0 ff ff       	jmp    8010685f <alltraps>

8010783d <vector241>:
8010783d:	6a 00                	push   $0x0
8010783f:	68 f1 00 00 00       	push   $0xf1
80107844:	e9 16 f0 ff ff       	jmp    8010685f <alltraps>

80107849 <vector242>:
80107849:	6a 00                	push   $0x0
8010784b:	68 f2 00 00 00       	push   $0xf2
80107850:	e9 0a f0 ff ff       	jmp    8010685f <alltraps>

80107855 <vector243>:
80107855:	6a 00                	push   $0x0
80107857:	68 f3 00 00 00       	push   $0xf3
8010785c:	e9 fe ef ff ff       	jmp    8010685f <alltraps>

80107861 <vector244>:
80107861:	6a 00                	push   $0x0
80107863:	68 f4 00 00 00       	push   $0xf4
80107868:	e9 f2 ef ff ff       	jmp    8010685f <alltraps>

8010786d <vector245>:
8010786d:	6a 00                	push   $0x0
8010786f:	68 f5 00 00 00       	push   $0xf5
80107874:	e9 e6 ef ff ff       	jmp    8010685f <alltraps>

80107879 <vector246>:
80107879:	6a 00                	push   $0x0
8010787b:	68 f6 00 00 00       	push   $0xf6
80107880:	e9 da ef ff ff       	jmp    8010685f <alltraps>

80107885 <vector247>:
80107885:	6a 00                	push   $0x0
80107887:	68 f7 00 00 00       	push   $0xf7
8010788c:	e9 ce ef ff ff       	jmp    8010685f <alltraps>

80107891 <vector248>:
80107891:	6a 00                	push   $0x0
80107893:	68 f8 00 00 00       	push   $0xf8
80107898:	e9 c2 ef ff ff       	jmp    8010685f <alltraps>

8010789d <vector249>:
8010789d:	6a 00                	push   $0x0
8010789f:	68 f9 00 00 00       	push   $0xf9
801078a4:	e9 b6 ef ff ff       	jmp    8010685f <alltraps>

801078a9 <vector250>:
801078a9:	6a 00                	push   $0x0
801078ab:	68 fa 00 00 00       	push   $0xfa
801078b0:	e9 aa ef ff ff       	jmp    8010685f <alltraps>

801078b5 <vector251>:
801078b5:	6a 00                	push   $0x0
801078b7:	68 fb 00 00 00       	push   $0xfb
801078bc:	e9 9e ef ff ff       	jmp    8010685f <alltraps>

801078c1 <vector252>:
801078c1:	6a 00                	push   $0x0
801078c3:	68 fc 00 00 00       	push   $0xfc
801078c8:	e9 92 ef ff ff       	jmp    8010685f <alltraps>

801078cd <vector253>:
801078cd:	6a 00                	push   $0x0
801078cf:	68 fd 00 00 00       	push   $0xfd
801078d4:	e9 86 ef ff ff       	jmp    8010685f <alltraps>

801078d9 <vector254>:
801078d9:	6a 00                	push   $0x0
801078db:	68 fe 00 00 00       	push   $0xfe
801078e0:	e9 7a ef ff ff       	jmp    8010685f <alltraps>

801078e5 <vector255>:
801078e5:	6a 00                	push   $0x0
801078e7:	68 ff 00 00 00       	push   $0xff
801078ec:	e9 6e ef ff ff       	jmp    8010685f <alltraps>

801078f1 <lgdt>:

struct segdesc;

static inline void
lgdt(struct segdesc *p, int size)
{
801078f1:	55                   	push   %ebp
801078f2:	89 e5                	mov    %esp,%ebp
801078f4:	83 ec 10             	sub    $0x10,%esp
  volatile ushort pd[3];

  pd[0] = size-1;
801078f7:	8b 45 0c             	mov    0xc(%ebp),%eax
801078fa:	83 e8 01             	sub    $0x1,%eax
801078fd:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80107901:	8b 45 08             	mov    0x8(%ebp),%eax
80107904:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80107908:	8b 45 08             	mov    0x8(%ebp),%eax
8010790b:	c1 e8 10             	shr    $0x10,%eax
8010790e:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lgdt (%0)" : : "r" (pd));
80107912:	8d 45 fa             	lea    -0x6(%ebp),%eax
80107915:	0f 01 10             	lgdtl  (%eax)
}
80107918:	c9                   	leave  
80107919:	c3                   	ret    

8010791a <ltr>:
  asm volatile("lidt (%0)" : : "r" (pd));
}

static inline void
ltr(ushort sel)
{
8010791a:	55                   	push   %ebp
8010791b:	89 e5                	mov    %esp,%ebp
8010791d:	83 ec 04             	sub    $0x4,%esp
80107920:	8b 45 08             	mov    0x8(%ebp),%eax
80107923:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  asm volatile("ltr %0" : : "r" (sel));
80107927:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
8010792b:	0f 00 d8             	ltr    %ax
}
8010792e:	c9                   	leave  
8010792f:	c3                   	ret    

80107930 <loadgs>:
  return eflags;
}

static inline void
loadgs(ushort v)
{
80107930:	55                   	push   %ebp
80107931:	89 e5                	mov    %esp,%ebp
80107933:	83 ec 04             	sub    $0x4,%esp
80107936:	8b 45 08             	mov    0x8(%ebp),%eax
80107939:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  asm volatile("movw %0, %%gs" : : "r" (v));
8010793d:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80107941:	8e e8                	mov    %eax,%gs
}
80107943:	c9                   	leave  
80107944:	c3                   	ret    

80107945 <lcr3>:
  return val;
}

static inline void
lcr3(uint val) 
{
80107945:	55                   	push   %ebp
80107946:	89 e5                	mov    %esp,%ebp
  asm volatile("movl %0,%%cr3" : : "r" (val));
80107948:	8b 45 08             	mov    0x8(%ebp),%eax
8010794b:	0f 22 d8             	mov    %eax,%cr3
}
8010794e:	5d                   	pop    %ebp
8010794f:	c3                   	ret    

80107950 <v2p>:
#define KERNBASE 0x80000000         // First kernel virtual address
#define KERNLINK (KERNBASE+EXTMEM)  // Address where kernel is linked

#ifndef __ASSEMBLER__

static inline uint v2p(void *a) { return ((uint) (a))  - KERNBASE; }
80107950:	55                   	push   %ebp
80107951:	89 e5                	mov    %esp,%ebp
80107953:	8b 45 08             	mov    0x8(%ebp),%eax
80107956:	05 00 00 00 80       	add    $0x80000000,%eax
8010795b:	5d                   	pop    %ebp
8010795c:	c3                   	ret    

8010795d <p2v>:
static inline void *p2v(uint a) { return (void *) ((a) + KERNBASE); }
8010795d:	55                   	push   %ebp
8010795e:	89 e5                	mov    %esp,%ebp
80107960:	8b 45 08             	mov    0x8(%ebp),%eax
80107963:	05 00 00 00 80       	add    $0x80000000,%eax
80107968:	5d                   	pop    %ebp
80107969:	c3                   	ret    

8010796a <seginit>:

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
8010796a:	55                   	push   %ebp
8010796b:	89 e5                	mov    %esp,%ebp
8010796d:	53                   	push   %ebx
8010796e:	83 ec 14             	sub    $0x14,%esp

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
80107971:	e8 ff b5 ff ff       	call   80102f75 <cpunum>
80107976:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
8010797c:	05 40 26 11 80       	add    $0x80112640,%eax
80107981:	89 45 f4             	mov    %eax,-0xc(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80107984:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107987:	66 c7 40 78 ff ff    	movw   $0xffff,0x78(%eax)
8010798d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107990:	66 c7 40 7a 00 00    	movw   $0x0,0x7a(%eax)
80107996:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107999:	c6 40 7c 00          	movb   $0x0,0x7c(%eax)
8010799d:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079a0:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
801079a4:	83 e2 f0             	and    $0xfffffff0,%edx
801079a7:	83 ca 0a             	or     $0xa,%edx
801079aa:	88 50 7d             	mov    %dl,0x7d(%eax)
801079ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079b0:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
801079b4:	83 ca 10             	or     $0x10,%edx
801079b7:	88 50 7d             	mov    %dl,0x7d(%eax)
801079ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079bd:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
801079c1:	83 e2 9f             	and    $0xffffff9f,%edx
801079c4:	88 50 7d             	mov    %dl,0x7d(%eax)
801079c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079ca:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
801079ce:	83 ca 80             	or     $0xffffff80,%edx
801079d1:	88 50 7d             	mov    %dl,0x7d(%eax)
801079d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079d7:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
801079db:	83 ca 0f             	or     $0xf,%edx
801079de:	88 50 7e             	mov    %dl,0x7e(%eax)
801079e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079e4:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
801079e8:	83 e2 ef             	and    $0xffffffef,%edx
801079eb:	88 50 7e             	mov    %dl,0x7e(%eax)
801079ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079f1:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
801079f5:	83 e2 df             	and    $0xffffffdf,%edx
801079f8:	88 50 7e             	mov    %dl,0x7e(%eax)
801079fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079fe:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80107a02:	83 ca 40             	or     $0x40,%edx
80107a05:	88 50 7e             	mov    %dl,0x7e(%eax)
80107a08:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a0b:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80107a0f:	83 ca 80             	or     $0xffffff80,%edx
80107a12:	88 50 7e             	mov    %dl,0x7e(%eax)
80107a15:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a18:	c6 40 7f 00          	movb   $0x0,0x7f(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80107a1c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a1f:	66 c7 80 80 00 00 00 	movw   $0xffff,0x80(%eax)
80107a26:	ff ff 
80107a28:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a2b:	66 c7 80 82 00 00 00 	movw   $0x0,0x82(%eax)
80107a32:	00 00 
80107a34:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a37:	c6 80 84 00 00 00 00 	movb   $0x0,0x84(%eax)
80107a3e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a41:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
80107a48:	83 e2 f0             	and    $0xfffffff0,%edx
80107a4b:	83 ca 02             	or     $0x2,%edx
80107a4e:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
80107a54:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a57:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
80107a5e:	83 ca 10             	or     $0x10,%edx
80107a61:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
80107a67:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a6a:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
80107a71:	83 e2 9f             	and    $0xffffff9f,%edx
80107a74:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
80107a7a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a7d:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
80107a84:	83 ca 80             	or     $0xffffff80,%edx
80107a87:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
80107a8d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a90:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80107a97:	83 ca 0f             	or     $0xf,%edx
80107a9a:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107aa0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107aa3:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80107aaa:	83 e2 ef             	and    $0xffffffef,%edx
80107aad:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107ab3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ab6:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80107abd:	83 e2 df             	and    $0xffffffdf,%edx
80107ac0:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107ac6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ac9:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80107ad0:	83 ca 40             	or     $0x40,%edx
80107ad3:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107ad9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107adc:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80107ae3:	83 ca 80             	or     $0xffffff80,%edx
80107ae6:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107aec:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107aef:	c6 80 87 00 00 00 00 	movb   $0x0,0x87(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80107af6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107af9:	66 c7 80 90 00 00 00 	movw   $0xffff,0x90(%eax)
80107b00:	ff ff 
80107b02:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b05:	66 c7 80 92 00 00 00 	movw   $0x0,0x92(%eax)
80107b0c:	00 00 
80107b0e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b11:	c6 80 94 00 00 00 00 	movb   $0x0,0x94(%eax)
80107b18:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b1b:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80107b22:	83 e2 f0             	and    $0xfffffff0,%edx
80107b25:	83 ca 0a             	or     $0xa,%edx
80107b28:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80107b2e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b31:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80107b38:	83 ca 10             	or     $0x10,%edx
80107b3b:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80107b41:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b44:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80107b4b:	83 ca 60             	or     $0x60,%edx
80107b4e:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80107b54:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b57:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80107b5e:	83 ca 80             	or     $0xffffff80,%edx
80107b61:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80107b67:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b6a:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107b71:	83 ca 0f             	or     $0xf,%edx
80107b74:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107b7a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b7d:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107b84:	83 e2 ef             	and    $0xffffffef,%edx
80107b87:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107b8d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b90:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107b97:	83 e2 df             	and    $0xffffffdf,%edx
80107b9a:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107ba0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ba3:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107baa:	83 ca 40             	or     $0x40,%edx
80107bad:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107bb3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bb6:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107bbd:	83 ca 80             	or     $0xffffff80,%edx
80107bc0:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107bc6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bc9:	c6 80 97 00 00 00 00 	movb   $0x0,0x97(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80107bd0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bd3:	66 c7 80 98 00 00 00 	movw   $0xffff,0x98(%eax)
80107bda:	ff ff 
80107bdc:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bdf:	66 c7 80 9a 00 00 00 	movw   $0x0,0x9a(%eax)
80107be6:	00 00 
80107be8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107beb:	c6 80 9c 00 00 00 00 	movb   $0x0,0x9c(%eax)
80107bf2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bf5:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107bfc:	83 e2 f0             	and    $0xfffffff0,%edx
80107bff:	83 ca 02             	or     $0x2,%edx
80107c02:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107c08:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c0b:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107c12:	83 ca 10             	or     $0x10,%edx
80107c15:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107c1b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c1e:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107c25:	83 ca 60             	or     $0x60,%edx
80107c28:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107c2e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c31:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107c38:	83 ca 80             	or     $0xffffff80,%edx
80107c3b:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107c41:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c44:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107c4b:	83 ca 0f             	or     $0xf,%edx
80107c4e:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107c54:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c57:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107c5e:	83 e2 ef             	and    $0xffffffef,%edx
80107c61:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107c67:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c6a:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107c71:	83 e2 df             	and    $0xffffffdf,%edx
80107c74:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107c7a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c7d:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107c84:	83 ca 40             	or     $0x40,%edx
80107c87:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107c8d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c90:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107c97:	83 ca 80             	or     $0xffffff80,%edx
80107c9a:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107ca0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ca3:	c6 80 9f 00 00 00 00 	movb   $0x0,0x9f(%eax)

  // Map cpu, and curproc
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
80107caa:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107cad:	05 b4 00 00 00       	add    $0xb4,%eax
80107cb2:	89 c3                	mov    %eax,%ebx
80107cb4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107cb7:	05 b4 00 00 00       	add    $0xb4,%eax
80107cbc:	c1 e8 10             	shr    $0x10,%eax
80107cbf:	89 c2                	mov    %eax,%edx
80107cc1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107cc4:	05 b4 00 00 00       	add    $0xb4,%eax
80107cc9:	c1 e8 18             	shr    $0x18,%eax
80107ccc:	89 c1                	mov    %eax,%ecx
80107cce:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107cd1:	66 c7 80 88 00 00 00 	movw   $0x0,0x88(%eax)
80107cd8:	00 00 
80107cda:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107cdd:	66 89 98 8a 00 00 00 	mov    %bx,0x8a(%eax)
80107ce4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ce7:	88 90 8c 00 00 00    	mov    %dl,0x8c(%eax)
80107ced:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107cf0:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80107cf7:	83 e2 f0             	and    $0xfffffff0,%edx
80107cfa:	83 ca 02             	or     $0x2,%edx
80107cfd:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80107d03:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d06:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80107d0d:	83 ca 10             	or     $0x10,%edx
80107d10:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80107d16:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d19:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80107d20:	83 e2 9f             	and    $0xffffff9f,%edx
80107d23:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80107d29:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d2c:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80107d33:	83 ca 80             	or     $0xffffff80,%edx
80107d36:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80107d3c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d3f:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80107d46:	83 e2 f0             	and    $0xfffffff0,%edx
80107d49:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80107d4f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d52:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80107d59:	83 e2 ef             	and    $0xffffffef,%edx
80107d5c:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80107d62:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d65:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80107d6c:	83 e2 df             	and    $0xffffffdf,%edx
80107d6f:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80107d75:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d78:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80107d7f:	83 ca 40             	or     $0x40,%edx
80107d82:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80107d88:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d8b:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80107d92:	83 ca 80             	or     $0xffffff80,%edx
80107d95:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80107d9b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d9e:	88 88 8f 00 00 00    	mov    %cl,0x8f(%eax)

  lgdt(c->gdt, sizeof(c->gdt));
80107da4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107da7:	83 c0 70             	add    $0x70,%eax
80107daa:	83 ec 08             	sub    $0x8,%esp
80107dad:	6a 38                	push   $0x38
80107daf:	50                   	push   %eax
80107db0:	e8 3c fb ff ff       	call   801078f1 <lgdt>
80107db5:	83 c4 10             	add    $0x10,%esp
  loadgs(SEG_KCPU << 3);
80107db8:	83 ec 0c             	sub    $0xc,%esp
80107dbb:	6a 18                	push   $0x18
80107dbd:	e8 6e fb ff ff       	call   80107930 <loadgs>
80107dc2:	83 c4 10             	add    $0x10,%esp
  
  // Initialize cpu-local storage.
  cpu = c;
80107dc5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107dc8:	65 a3 00 00 00 00    	mov    %eax,%gs:0x0
  proc = 0;
80107dce:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
80107dd5:	00 00 00 00 
}
80107dd9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80107ddc:	c9                   	leave  
80107ddd:	c3                   	ret    

80107dde <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80107dde:	55                   	push   %ebp
80107ddf:	89 e5                	mov    %esp,%ebp
80107de1:	83 ec 18             	sub    $0x18,%esp
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80107de4:	8b 45 0c             	mov    0xc(%ebp),%eax
80107de7:	c1 e8 16             	shr    $0x16,%eax
80107dea:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80107df1:	8b 45 08             	mov    0x8(%ebp),%eax
80107df4:	01 d0                	add    %edx,%eax
80107df6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(*pde & PTE_P){
80107df9:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107dfc:	8b 00                	mov    (%eax),%eax
80107dfe:	83 e0 01             	and    $0x1,%eax
80107e01:	85 c0                	test   %eax,%eax
80107e03:	74 18                	je     80107e1d <walkpgdir+0x3f>
    pgtab = (pte_t*)p2v(PTE_ADDR(*pde));
80107e05:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107e08:	8b 00                	mov    (%eax),%eax
80107e0a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107e0f:	50                   	push   %eax
80107e10:	e8 48 fb ff ff       	call   8010795d <p2v>
80107e15:	83 c4 04             	add    $0x4,%esp
80107e18:	89 45 f4             	mov    %eax,-0xc(%ebp)
80107e1b:	eb 48                	jmp    80107e65 <walkpgdir+0x87>
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80107e1d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80107e21:	74 0e                	je     80107e31 <walkpgdir+0x53>
80107e23:	e8 ec ad ff ff       	call   80102c14 <kalloc>
80107e28:	89 45 f4             	mov    %eax,-0xc(%ebp)
80107e2b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80107e2f:	75 07                	jne    80107e38 <walkpgdir+0x5a>
      return 0;
80107e31:	b8 00 00 00 00       	mov    $0x0,%eax
80107e36:	eb 44                	jmp    80107e7c <walkpgdir+0x9e>
    // Make sure all those PTE_P bits are zero.
    memset(pgtab, 0, PGSIZE);
80107e38:	83 ec 04             	sub    $0x4,%esp
80107e3b:	68 00 10 00 00       	push   $0x1000
80107e40:	6a 00                	push   $0x0
80107e42:	ff 75 f4             	pushl  -0xc(%ebp)
80107e45:	e8 59 d6 ff ff       	call   801054a3 <memset>
80107e4a:	83 c4 10             	add    $0x10,%esp
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table 
    // entries, if necessary.
    *pde = v2p(pgtab) | PTE_P | PTE_W | PTE_U;
80107e4d:	83 ec 0c             	sub    $0xc,%esp
80107e50:	ff 75 f4             	pushl  -0xc(%ebp)
80107e53:	e8 f8 fa ff ff       	call   80107950 <v2p>
80107e58:	83 c4 10             	add    $0x10,%esp
80107e5b:	83 c8 07             	or     $0x7,%eax
80107e5e:	89 c2                	mov    %eax,%edx
80107e60:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107e63:	89 10                	mov    %edx,(%eax)
  }
  return &pgtab[PTX(va)];
80107e65:	8b 45 0c             	mov    0xc(%ebp),%eax
80107e68:	c1 e8 0c             	shr    $0xc,%eax
80107e6b:	25 ff 03 00 00       	and    $0x3ff,%eax
80107e70:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80107e77:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e7a:	01 d0                	add    %edx,%eax
}
80107e7c:	c9                   	leave  
80107e7d:	c3                   	ret    

80107e7e <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80107e7e:	55                   	push   %ebp
80107e7f:	89 e5                	mov    %esp,%ebp
80107e81:	83 ec 18             	sub    $0x18,%esp
  char *a, *last;
  pte_t *pte;
  
  a = (char*)PGROUNDDOWN((uint)va);
80107e84:	8b 45 0c             	mov    0xc(%ebp),%eax
80107e87:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107e8c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80107e8f:	8b 55 0c             	mov    0xc(%ebp),%edx
80107e92:	8b 45 10             	mov    0x10(%ebp),%eax
80107e95:	01 d0                	add    %edx,%eax
80107e97:	83 e8 01             	sub    $0x1,%eax
80107e9a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107e9f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80107ea2:	83 ec 04             	sub    $0x4,%esp
80107ea5:	6a 01                	push   $0x1
80107ea7:	ff 75 f4             	pushl  -0xc(%ebp)
80107eaa:	ff 75 08             	pushl  0x8(%ebp)
80107ead:	e8 2c ff ff ff       	call   80107dde <walkpgdir>
80107eb2:	83 c4 10             	add    $0x10,%esp
80107eb5:	89 45 ec             	mov    %eax,-0x14(%ebp)
80107eb8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80107ebc:	75 07                	jne    80107ec5 <mappages+0x47>
      return -1;
80107ebe:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107ec3:	eb 49                	jmp    80107f0e <mappages+0x90>
    if(*pte & PTE_P)
80107ec5:	8b 45 ec             	mov    -0x14(%ebp),%eax
80107ec8:	8b 00                	mov    (%eax),%eax
80107eca:	83 e0 01             	and    $0x1,%eax
80107ecd:	85 c0                	test   %eax,%eax
80107ecf:	74 0d                	je     80107ede <mappages+0x60>
      panic("remap");
80107ed1:	83 ec 0c             	sub    $0xc,%esp
80107ed4:	68 6c 8d 10 80       	push   $0x80108d6c
80107ed9:	e8 7e 86 ff ff       	call   8010055c <panic>
    *pte = pa | perm | PTE_P;
80107ede:	8b 45 18             	mov    0x18(%ebp),%eax
80107ee1:	0b 45 14             	or     0x14(%ebp),%eax
80107ee4:	83 c8 01             	or     $0x1,%eax
80107ee7:	89 c2                	mov    %eax,%edx
80107ee9:	8b 45 ec             	mov    -0x14(%ebp),%eax
80107eec:	89 10                	mov    %edx,(%eax)
    if(a == last)
80107eee:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ef1:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80107ef4:	75 08                	jne    80107efe <mappages+0x80>
      break;
80107ef6:	90                   	nop
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
80107ef7:	b8 00 00 00 00       	mov    $0x0,%eax
80107efc:	eb 10                	jmp    80107f0e <mappages+0x90>
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
    if(a == last)
      break;
    a += PGSIZE;
80107efe:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
    pa += PGSIZE;
80107f05:	81 45 14 00 10 00 00 	addl   $0x1000,0x14(%ebp)
  }
80107f0c:	eb 94                	jmp    80107ea2 <mappages+0x24>
  return 0;
}
80107f0e:	c9                   	leave  
80107f0f:	c3                   	ret    

80107f10 <setupkvm>:
};

// Set up kernel part of a page table.
pde_t*
setupkvm(void)
{
80107f10:	55                   	push   %ebp
80107f11:	89 e5                	mov    %esp,%ebp
80107f13:	53                   	push   %ebx
80107f14:	83 ec 14             	sub    $0x14,%esp
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
80107f17:	e8 f8 ac ff ff       	call   80102c14 <kalloc>
80107f1c:	89 45 f0             	mov    %eax,-0x10(%ebp)
80107f1f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80107f23:	75 0a                	jne    80107f2f <setupkvm+0x1f>
    return 0;
80107f25:	b8 00 00 00 00       	mov    $0x0,%eax
80107f2a:	e9 8e 00 00 00       	jmp    80107fbd <setupkvm+0xad>
  memset(pgdir, 0, PGSIZE);
80107f2f:	83 ec 04             	sub    $0x4,%esp
80107f32:	68 00 10 00 00       	push   $0x1000
80107f37:	6a 00                	push   $0x0
80107f39:	ff 75 f0             	pushl  -0x10(%ebp)
80107f3c:	e8 62 d5 ff ff       	call   801054a3 <memset>
80107f41:	83 c4 10             	add    $0x10,%esp
  if (p2v(PHYSTOP) > (void*)DEVSPACE)
80107f44:	83 ec 0c             	sub    $0xc,%esp
80107f47:	68 00 00 00 0e       	push   $0xe000000
80107f4c:	e8 0c fa ff ff       	call   8010795d <p2v>
80107f51:	83 c4 10             	add    $0x10,%esp
80107f54:	3d 00 00 00 fe       	cmp    $0xfe000000,%eax
80107f59:	76 0d                	jbe    80107f68 <setupkvm+0x58>
    panic("PHYSTOP too high");
80107f5b:	83 ec 0c             	sub    $0xc,%esp
80107f5e:	68 72 8d 10 80       	push   $0x80108d72
80107f63:	e8 f4 85 ff ff       	call   8010055c <panic>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107f68:	c7 45 f4 c0 b4 10 80 	movl   $0x8010b4c0,-0xc(%ebp)
80107f6f:	eb 40                	jmp    80107fb1 <setupkvm+0xa1>
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start, 
80107f71:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f74:	8b 48 0c             	mov    0xc(%eax),%ecx
80107f77:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f7a:	8b 50 04             	mov    0x4(%eax),%edx
80107f7d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f80:	8b 58 08             	mov    0x8(%eax),%ebx
80107f83:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f86:	8b 40 04             	mov    0x4(%eax),%eax
80107f89:	29 c3                	sub    %eax,%ebx
80107f8b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f8e:	8b 00                	mov    (%eax),%eax
80107f90:	83 ec 0c             	sub    $0xc,%esp
80107f93:	51                   	push   %ecx
80107f94:	52                   	push   %edx
80107f95:	53                   	push   %ebx
80107f96:	50                   	push   %eax
80107f97:	ff 75 f0             	pushl  -0x10(%ebp)
80107f9a:	e8 df fe ff ff       	call   80107e7e <mappages>
80107f9f:	83 c4 20             	add    $0x20,%esp
80107fa2:	85 c0                	test   %eax,%eax
80107fa4:	79 07                	jns    80107fad <setupkvm+0x9d>
                (uint)k->phys_start, k->perm) < 0)
      return 0;
80107fa6:	b8 00 00 00 00       	mov    $0x0,%eax
80107fab:	eb 10                	jmp    80107fbd <setupkvm+0xad>
  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (p2v(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107fad:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
80107fb1:	81 7d f4 00 b5 10 80 	cmpl   $0x8010b500,-0xc(%ebp)
80107fb8:	72 b7                	jb     80107f71 <setupkvm+0x61>
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start, 
                (uint)k->phys_start, k->perm) < 0)
      return 0;
  return pgdir;
80107fba:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80107fbd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80107fc0:	c9                   	leave  
80107fc1:	c3                   	ret    

80107fc2 <kvmalloc>:

// Allocate one page table for the machine for the kernel address
// space for scheduler processes.
void
kvmalloc(void)
{
80107fc2:	55                   	push   %ebp
80107fc3:	89 e5                	mov    %esp,%ebp
80107fc5:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80107fc8:	e8 43 ff ff ff       	call   80107f10 <setupkvm>
80107fcd:	a3 18 55 11 80       	mov    %eax,0x80115518
  switchkvm();
80107fd2:	e8 02 00 00 00       	call   80107fd9 <switchkvm>
}
80107fd7:	c9                   	leave  
80107fd8:	c3                   	ret    

80107fd9 <switchkvm>:

// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
80107fd9:	55                   	push   %ebp
80107fda:	89 e5                	mov    %esp,%ebp
  lcr3(v2p(kpgdir));   // switch to the kernel page table
80107fdc:	a1 18 55 11 80       	mov    0x80115518,%eax
80107fe1:	50                   	push   %eax
80107fe2:	e8 69 f9 ff ff       	call   80107950 <v2p>
80107fe7:	83 c4 04             	add    $0x4,%esp
80107fea:	50                   	push   %eax
80107feb:	e8 55 f9 ff ff       	call   80107945 <lcr3>
80107ff0:	83 c4 04             	add    $0x4,%esp
}
80107ff3:	c9                   	leave  
80107ff4:	c3                   	ret    

80107ff5 <switchuvm>:

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
80107ff5:	55                   	push   %ebp
80107ff6:	89 e5                	mov    %esp,%ebp
80107ff8:	56                   	push   %esi
80107ff9:	53                   	push   %ebx
  pushcli();
80107ffa:	e8 a2 d3 ff ff       	call   801053a1 <pushcli>
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
80107fff:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80108005:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
8010800c:	83 c2 08             	add    $0x8,%edx
8010800f:	89 d6                	mov    %edx,%esi
80108011:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80108018:	83 c2 08             	add    $0x8,%edx
8010801b:	c1 ea 10             	shr    $0x10,%edx
8010801e:	89 d3                	mov    %edx,%ebx
80108020:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80108027:	83 c2 08             	add    $0x8,%edx
8010802a:	c1 ea 18             	shr    $0x18,%edx
8010802d:	89 d1                	mov    %edx,%ecx
8010802f:	66 c7 80 a0 00 00 00 	movw   $0x67,0xa0(%eax)
80108036:	67 00 
80108038:	66 89 b0 a2 00 00 00 	mov    %si,0xa2(%eax)
8010803f:	88 98 a4 00 00 00    	mov    %bl,0xa4(%eax)
80108045:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
8010804c:	83 e2 f0             	and    $0xfffffff0,%edx
8010804f:	83 ca 09             	or     $0x9,%edx
80108052:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80108058:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
8010805f:	83 ca 10             	or     $0x10,%edx
80108062:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80108068:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
8010806f:	83 e2 9f             	and    $0xffffff9f,%edx
80108072:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80108078:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
8010807f:	83 ca 80             	or     $0xffffff80,%edx
80108082:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80108088:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
8010808f:	83 e2 f0             	and    $0xfffffff0,%edx
80108092:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80108098:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
8010809f:	83 e2 ef             	and    $0xffffffef,%edx
801080a2:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
801080a8:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
801080af:	83 e2 df             	and    $0xffffffdf,%edx
801080b2:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
801080b8:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
801080bf:	83 ca 40             	or     $0x40,%edx
801080c2:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
801080c8:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
801080cf:	83 e2 7f             	and    $0x7f,%edx
801080d2:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
801080d8:	88 88 a7 00 00 00    	mov    %cl,0xa7(%eax)
  cpu->gdt[SEG_TSS].s = 0;
801080de:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801080e4:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
801080eb:	83 e2 ef             	and    $0xffffffef,%edx
801080ee:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
  cpu->ts.ss0 = SEG_KDATA << 3;
801080f4:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801080fa:	66 c7 40 10 10 00    	movw   $0x10,0x10(%eax)
  cpu->ts.esp0 = (uint)proc->kstack + KSTACKSIZE;
80108100:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80108106:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
8010810d:	8b 52 08             	mov    0x8(%edx),%edx
80108110:	81 c2 00 10 00 00    	add    $0x1000,%edx
80108116:	89 50 0c             	mov    %edx,0xc(%eax)
  ltr(SEG_TSS << 3);
80108119:	83 ec 0c             	sub    $0xc,%esp
8010811c:	6a 30                	push   $0x30
8010811e:	e8 f7 f7 ff ff       	call   8010791a <ltr>
80108123:	83 c4 10             	add    $0x10,%esp
  if(p->pgdir == 0)
80108126:	8b 45 08             	mov    0x8(%ebp),%eax
80108129:	8b 40 04             	mov    0x4(%eax),%eax
8010812c:	85 c0                	test   %eax,%eax
8010812e:	75 0d                	jne    8010813d <switchuvm+0x148>
    panic("switchuvm: no pgdir");
80108130:	83 ec 0c             	sub    $0xc,%esp
80108133:	68 83 8d 10 80       	push   $0x80108d83
80108138:	e8 1f 84 ff ff       	call   8010055c <panic>
  lcr3(v2p(p->pgdir));  // switch to new address space
8010813d:	8b 45 08             	mov    0x8(%ebp),%eax
80108140:	8b 40 04             	mov    0x4(%eax),%eax
80108143:	83 ec 0c             	sub    $0xc,%esp
80108146:	50                   	push   %eax
80108147:	e8 04 f8 ff ff       	call   80107950 <v2p>
8010814c:	83 c4 10             	add    $0x10,%esp
8010814f:	83 ec 0c             	sub    $0xc,%esp
80108152:	50                   	push   %eax
80108153:	e8 ed f7 ff ff       	call   80107945 <lcr3>
80108158:	83 c4 10             	add    $0x10,%esp
  popcli();
8010815b:	e8 85 d2 ff ff       	call   801053e5 <popcli>
}
80108160:	8d 65 f8             	lea    -0x8(%ebp),%esp
80108163:	5b                   	pop    %ebx
80108164:	5e                   	pop    %esi
80108165:	5d                   	pop    %ebp
80108166:	c3                   	ret    

80108167 <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80108167:	55                   	push   %ebp
80108168:	89 e5                	mov    %esp,%ebp
8010816a:	83 ec 18             	sub    $0x18,%esp
  char *mem;
  
  if(sz >= PGSIZE)
8010816d:	81 7d 10 ff 0f 00 00 	cmpl   $0xfff,0x10(%ebp)
80108174:	76 0d                	jbe    80108183 <inituvm+0x1c>
    panic("inituvm: more than a page");
80108176:	83 ec 0c             	sub    $0xc,%esp
80108179:	68 97 8d 10 80       	push   $0x80108d97
8010817e:	e8 d9 83 ff ff       	call   8010055c <panic>
  mem = kalloc();
80108183:	e8 8c aa ff ff       	call   80102c14 <kalloc>
80108188:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(mem, 0, PGSIZE);
8010818b:	83 ec 04             	sub    $0x4,%esp
8010818e:	68 00 10 00 00       	push   $0x1000
80108193:	6a 00                	push   $0x0
80108195:	ff 75 f4             	pushl  -0xc(%ebp)
80108198:	e8 06 d3 ff ff       	call   801054a3 <memset>
8010819d:	83 c4 10             	add    $0x10,%esp
  mappages(pgdir, 0, PGSIZE, v2p(mem), PTE_W|PTE_U);
801081a0:	83 ec 0c             	sub    $0xc,%esp
801081a3:	ff 75 f4             	pushl  -0xc(%ebp)
801081a6:	e8 a5 f7 ff ff       	call   80107950 <v2p>
801081ab:	83 c4 10             	add    $0x10,%esp
801081ae:	83 ec 0c             	sub    $0xc,%esp
801081b1:	6a 06                	push   $0x6
801081b3:	50                   	push   %eax
801081b4:	68 00 10 00 00       	push   $0x1000
801081b9:	6a 00                	push   $0x0
801081bb:	ff 75 08             	pushl  0x8(%ebp)
801081be:	e8 bb fc ff ff       	call   80107e7e <mappages>
801081c3:	83 c4 20             	add    $0x20,%esp
  memmove(mem, init, sz);
801081c6:	83 ec 04             	sub    $0x4,%esp
801081c9:	ff 75 10             	pushl  0x10(%ebp)
801081cc:	ff 75 0c             	pushl  0xc(%ebp)
801081cf:	ff 75 f4             	pushl  -0xc(%ebp)
801081d2:	e8 8b d3 ff ff       	call   80105562 <memmove>
801081d7:	83 c4 10             	add    $0x10,%esp
}
801081da:	c9                   	leave  
801081db:	c3                   	ret    

801081dc <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
801081dc:	55                   	push   %ebp
801081dd:	89 e5                	mov    %esp,%ebp
801081df:	53                   	push   %ebx
801081e0:	83 ec 14             	sub    $0x14,%esp
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
801081e3:	8b 45 0c             	mov    0xc(%ebp),%eax
801081e6:	25 ff 0f 00 00       	and    $0xfff,%eax
801081eb:	85 c0                	test   %eax,%eax
801081ed:	74 0d                	je     801081fc <loaduvm+0x20>
    panic("loaduvm: addr must be page aligned");
801081ef:	83 ec 0c             	sub    $0xc,%esp
801081f2:	68 b4 8d 10 80       	push   $0x80108db4
801081f7:	e8 60 83 ff ff       	call   8010055c <panic>
  for(i = 0; i < sz; i += PGSIZE){
801081fc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80108203:	e9 95 00 00 00       	jmp    8010829d <loaduvm+0xc1>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80108208:	8b 55 0c             	mov    0xc(%ebp),%edx
8010820b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010820e:	01 d0                	add    %edx,%eax
80108210:	83 ec 04             	sub    $0x4,%esp
80108213:	6a 00                	push   $0x0
80108215:	50                   	push   %eax
80108216:	ff 75 08             	pushl  0x8(%ebp)
80108219:	e8 c0 fb ff ff       	call   80107dde <walkpgdir>
8010821e:	83 c4 10             	add    $0x10,%esp
80108221:	89 45 ec             	mov    %eax,-0x14(%ebp)
80108224:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80108228:	75 0d                	jne    80108237 <loaduvm+0x5b>
      panic("loaduvm: address should exist");
8010822a:	83 ec 0c             	sub    $0xc,%esp
8010822d:	68 d7 8d 10 80       	push   $0x80108dd7
80108232:	e8 25 83 ff ff       	call   8010055c <panic>
    pa = PTE_ADDR(*pte);
80108237:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010823a:	8b 00                	mov    (%eax),%eax
8010823c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108241:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(sz - i < PGSIZE)
80108244:	8b 45 18             	mov    0x18(%ebp),%eax
80108247:	2b 45 f4             	sub    -0xc(%ebp),%eax
8010824a:	3d ff 0f 00 00       	cmp    $0xfff,%eax
8010824f:	77 0b                	ja     8010825c <loaduvm+0x80>
      n = sz - i;
80108251:	8b 45 18             	mov    0x18(%ebp),%eax
80108254:	2b 45 f4             	sub    -0xc(%ebp),%eax
80108257:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010825a:	eb 07                	jmp    80108263 <loaduvm+0x87>
    else
      n = PGSIZE;
8010825c:	c7 45 f0 00 10 00 00 	movl   $0x1000,-0x10(%ebp)
    if(readi(ip, p2v(pa), offset+i, n) != n)
80108263:	8b 55 14             	mov    0x14(%ebp),%edx
80108266:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108269:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
8010826c:	83 ec 0c             	sub    $0xc,%esp
8010826f:	ff 75 e8             	pushl  -0x18(%ebp)
80108272:	e8 e6 f6 ff ff       	call   8010795d <p2v>
80108277:	83 c4 10             	add    $0x10,%esp
8010827a:	ff 75 f0             	pushl  -0x10(%ebp)
8010827d:	53                   	push   %ebx
8010827e:	50                   	push   %eax
8010827f:	ff 75 10             	pushl  0x10(%ebp)
80108282:	e8 0a 9c ff ff       	call   80101e91 <readi>
80108287:	83 c4 10             	add    $0x10,%esp
8010828a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
8010828d:	74 07                	je     80108296 <loaduvm+0xba>
      return -1;
8010828f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80108294:	eb 18                	jmp    801082ae <loaduvm+0xd2>
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
80108296:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
8010829d:	8b 45 f4             	mov    -0xc(%ebp),%eax
801082a0:	3b 45 18             	cmp    0x18(%ebp),%eax
801082a3:	0f 82 5f ff ff ff    	jb     80108208 <loaduvm+0x2c>
    else
      n = PGSIZE;
    if(readi(ip, p2v(pa), offset+i, n) != n)
      return -1;
  }
  return 0;
801082a9:	b8 00 00 00 00       	mov    $0x0,%eax
}
801082ae:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801082b1:	c9                   	leave  
801082b2:	c3                   	ret    

801082b3 <allocuvm>:

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
801082b3:	55                   	push   %ebp
801082b4:	89 e5                	mov    %esp,%ebp
801082b6:	83 ec 18             	sub    $0x18,%esp
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
801082b9:	8b 45 10             	mov    0x10(%ebp),%eax
801082bc:	85 c0                	test   %eax,%eax
801082be:	79 0a                	jns    801082ca <allocuvm+0x17>
    return 0;
801082c0:	b8 00 00 00 00       	mov    $0x0,%eax
801082c5:	e9 b0 00 00 00       	jmp    8010837a <allocuvm+0xc7>
  if(newsz < oldsz)
801082ca:	8b 45 10             	mov    0x10(%ebp),%eax
801082cd:	3b 45 0c             	cmp    0xc(%ebp),%eax
801082d0:	73 08                	jae    801082da <allocuvm+0x27>
    return oldsz;
801082d2:	8b 45 0c             	mov    0xc(%ebp),%eax
801082d5:	e9 a0 00 00 00       	jmp    8010837a <allocuvm+0xc7>

  a = PGROUNDUP(oldsz);
801082da:	8b 45 0c             	mov    0xc(%ebp),%eax
801082dd:	05 ff 0f 00 00       	add    $0xfff,%eax
801082e2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801082e7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; a < newsz; a += PGSIZE){
801082ea:	eb 7f                	jmp    8010836b <allocuvm+0xb8>
    mem = kalloc();
801082ec:	e8 23 a9 ff ff       	call   80102c14 <kalloc>
801082f1:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(mem == 0){
801082f4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801082f8:	75 2b                	jne    80108325 <allocuvm+0x72>
      cprintf("allocuvm out of memory\n");
801082fa:	83 ec 0c             	sub    $0xc,%esp
801082fd:	68 f5 8d 10 80       	push   $0x80108df5
80108302:	e8 b8 80 ff ff       	call   801003bf <cprintf>
80108307:	83 c4 10             	add    $0x10,%esp
      deallocuvm(pgdir, newsz, oldsz);
8010830a:	83 ec 04             	sub    $0x4,%esp
8010830d:	ff 75 0c             	pushl  0xc(%ebp)
80108310:	ff 75 10             	pushl  0x10(%ebp)
80108313:	ff 75 08             	pushl  0x8(%ebp)
80108316:	e8 61 00 00 00       	call   8010837c <deallocuvm>
8010831b:	83 c4 10             	add    $0x10,%esp
      return 0;
8010831e:	b8 00 00 00 00       	mov    $0x0,%eax
80108323:	eb 55                	jmp    8010837a <allocuvm+0xc7>
    }
    memset(mem, 0, PGSIZE);
80108325:	83 ec 04             	sub    $0x4,%esp
80108328:	68 00 10 00 00       	push   $0x1000
8010832d:	6a 00                	push   $0x0
8010832f:	ff 75 f0             	pushl  -0x10(%ebp)
80108332:	e8 6c d1 ff ff       	call   801054a3 <memset>
80108337:	83 c4 10             	add    $0x10,%esp
    mappages(pgdir, (char*)a, PGSIZE, v2p(mem), PTE_W|PTE_U);
8010833a:	83 ec 0c             	sub    $0xc,%esp
8010833d:	ff 75 f0             	pushl  -0x10(%ebp)
80108340:	e8 0b f6 ff ff       	call   80107950 <v2p>
80108345:	83 c4 10             	add    $0x10,%esp
80108348:	89 c2                	mov    %eax,%edx
8010834a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010834d:	83 ec 0c             	sub    $0xc,%esp
80108350:	6a 06                	push   $0x6
80108352:	52                   	push   %edx
80108353:	68 00 10 00 00       	push   $0x1000
80108358:	50                   	push   %eax
80108359:	ff 75 08             	pushl  0x8(%ebp)
8010835c:	e8 1d fb ff ff       	call   80107e7e <mappages>
80108361:	83 c4 20             	add    $0x20,%esp
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
80108364:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
8010836b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010836e:	3b 45 10             	cmp    0x10(%ebp),%eax
80108371:	0f 82 75 ff ff ff    	jb     801082ec <allocuvm+0x39>
      return 0;
    }
    memset(mem, 0, PGSIZE);
    mappages(pgdir, (char*)a, PGSIZE, v2p(mem), PTE_W|PTE_U);
  }
  return newsz;
80108377:	8b 45 10             	mov    0x10(%ebp),%eax
}
8010837a:	c9                   	leave  
8010837b:	c3                   	ret    

8010837c <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
8010837c:	55                   	push   %ebp
8010837d:	89 e5                	mov    %esp,%ebp
8010837f:	83 ec 18             	sub    $0x18,%esp
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80108382:	8b 45 10             	mov    0x10(%ebp),%eax
80108385:	3b 45 0c             	cmp    0xc(%ebp),%eax
80108388:	72 08                	jb     80108392 <deallocuvm+0x16>
    return oldsz;
8010838a:	8b 45 0c             	mov    0xc(%ebp),%eax
8010838d:	e9 a5 00 00 00       	jmp    80108437 <deallocuvm+0xbb>

  a = PGROUNDUP(newsz);
80108392:	8b 45 10             	mov    0x10(%ebp),%eax
80108395:	05 ff 0f 00 00       	add    $0xfff,%eax
8010839a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010839f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; a  < oldsz; a += PGSIZE){
801083a2:	e9 81 00 00 00       	jmp    80108428 <deallocuvm+0xac>
    pte = walkpgdir(pgdir, (char*)a, 0);
801083a7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801083aa:	83 ec 04             	sub    $0x4,%esp
801083ad:	6a 00                	push   $0x0
801083af:	50                   	push   %eax
801083b0:	ff 75 08             	pushl  0x8(%ebp)
801083b3:	e8 26 fa ff ff       	call   80107dde <walkpgdir>
801083b8:	83 c4 10             	add    $0x10,%esp
801083bb:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(!pte)
801083be:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801083c2:	75 09                	jne    801083cd <deallocuvm+0x51>
      a += (NPTENTRIES - 1) * PGSIZE;
801083c4:	81 45 f4 00 f0 3f 00 	addl   $0x3ff000,-0xc(%ebp)
801083cb:	eb 54                	jmp    80108421 <deallocuvm+0xa5>
    else if((*pte & PTE_P) != 0){
801083cd:	8b 45 f0             	mov    -0x10(%ebp),%eax
801083d0:	8b 00                	mov    (%eax),%eax
801083d2:	83 e0 01             	and    $0x1,%eax
801083d5:	85 c0                	test   %eax,%eax
801083d7:	74 48                	je     80108421 <deallocuvm+0xa5>
      pa = PTE_ADDR(*pte);
801083d9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801083dc:	8b 00                	mov    (%eax),%eax
801083de:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801083e3:	89 45 ec             	mov    %eax,-0x14(%ebp)
      if(pa == 0)
801083e6:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
801083ea:	75 0d                	jne    801083f9 <deallocuvm+0x7d>
        panic("kfree");
801083ec:	83 ec 0c             	sub    $0xc,%esp
801083ef:	68 0d 8e 10 80       	push   $0x80108e0d
801083f4:	e8 63 81 ff ff       	call   8010055c <panic>
      char *v = p2v(pa);
801083f9:	83 ec 0c             	sub    $0xc,%esp
801083fc:	ff 75 ec             	pushl  -0x14(%ebp)
801083ff:	e8 59 f5 ff ff       	call   8010795d <p2v>
80108404:	83 c4 10             	add    $0x10,%esp
80108407:	89 45 e8             	mov    %eax,-0x18(%ebp)
      kfree(v);
8010840a:	83 ec 0c             	sub    $0xc,%esp
8010840d:	ff 75 e8             	pushl  -0x18(%ebp)
80108410:	e8 63 a7 ff ff       	call   80102b78 <kfree>
80108415:	83 c4 10             	add    $0x10,%esp
      *pte = 0;
80108418:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010841b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80108421:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80108428:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010842b:	3b 45 0c             	cmp    0xc(%ebp),%eax
8010842e:	0f 82 73 ff ff ff    	jb     801083a7 <deallocuvm+0x2b>
      char *v = p2v(pa);
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
80108434:	8b 45 10             	mov    0x10(%ebp),%eax
}
80108437:	c9                   	leave  
80108438:	c3                   	ret    

80108439 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80108439:	55                   	push   %ebp
8010843a:	89 e5                	mov    %esp,%ebp
8010843c:	83 ec 18             	sub    $0x18,%esp
  uint i;

  if(pgdir == 0)
8010843f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80108443:	75 0d                	jne    80108452 <freevm+0x19>
    panic("freevm: no pgdir");
80108445:	83 ec 0c             	sub    $0xc,%esp
80108448:	68 13 8e 10 80       	push   $0x80108e13
8010844d:	e8 0a 81 ff ff       	call   8010055c <panic>
  deallocuvm(pgdir, KERNBASE, 0);
80108452:	83 ec 04             	sub    $0x4,%esp
80108455:	6a 00                	push   $0x0
80108457:	68 00 00 00 80       	push   $0x80000000
8010845c:	ff 75 08             	pushl  0x8(%ebp)
8010845f:	e8 18 ff ff ff       	call   8010837c <deallocuvm>
80108464:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80108467:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010846e:	eb 4f                	jmp    801084bf <freevm+0x86>
    if(pgdir[i] & PTE_P){
80108470:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108473:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
8010847a:	8b 45 08             	mov    0x8(%ebp),%eax
8010847d:	01 d0                	add    %edx,%eax
8010847f:	8b 00                	mov    (%eax),%eax
80108481:	83 e0 01             	and    $0x1,%eax
80108484:	85 c0                	test   %eax,%eax
80108486:	74 33                	je     801084bb <freevm+0x82>
      char * v = p2v(PTE_ADDR(pgdir[i]));
80108488:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010848b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80108492:	8b 45 08             	mov    0x8(%ebp),%eax
80108495:	01 d0                	add    %edx,%eax
80108497:	8b 00                	mov    (%eax),%eax
80108499:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010849e:	83 ec 0c             	sub    $0xc,%esp
801084a1:	50                   	push   %eax
801084a2:	e8 b6 f4 ff ff       	call   8010795d <p2v>
801084a7:	83 c4 10             	add    $0x10,%esp
801084aa:	89 45 f0             	mov    %eax,-0x10(%ebp)
      kfree(v);
801084ad:	83 ec 0c             	sub    $0xc,%esp
801084b0:	ff 75 f0             	pushl  -0x10(%ebp)
801084b3:	e8 c0 a6 ff ff       	call   80102b78 <kfree>
801084b8:	83 c4 10             	add    $0x10,%esp
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
801084bb:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801084bf:	81 7d f4 ff 03 00 00 	cmpl   $0x3ff,-0xc(%ebp)
801084c6:	76 a8                	jbe    80108470 <freevm+0x37>
    if(pgdir[i] & PTE_P){
      char * v = p2v(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
801084c8:	83 ec 0c             	sub    $0xc,%esp
801084cb:	ff 75 08             	pushl  0x8(%ebp)
801084ce:	e8 a5 a6 ff ff       	call   80102b78 <kfree>
801084d3:	83 c4 10             	add    $0x10,%esp
}
801084d6:	c9                   	leave  
801084d7:	c3                   	ret    

801084d8 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
801084d8:	55                   	push   %ebp
801084d9:	89 e5                	mov    %esp,%ebp
801084db:	83 ec 18             	sub    $0x18,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801084de:	83 ec 04             	sub    $0x4,%esp
801084e1:	6a 00                	push   $0x0
801084e3:	ff 75 0c             	pushl  0xc(%ebp)
801084e6:	ff 75 08             	pushl  0x8(%ebp)
801084e9:	e8 f0 f8 ff ff       	call   80107dde <walkpgdir>
801084ee:	83 c4 10             	add    $0x10,%esp
801084f1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pte == 0)
801084f4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801084f8:	75 0d                	jne    80108507 <clearpteu+0x2f>
    panic("clearpteu");
801084fa:	83 ec 0c             	sub    $0xc,%esp
801084fd:	68 24 8e 10 80       	push   $0x80108e24
80108502:	e8 55 80 ff ff       	call   8010055c <panic>
  *pte &= ~PTE_U;
80108507:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010850a:	8b 00                	mov    (%eax),%eax
8010850c:	83 e0 fb             	and    $0xfffffffb,%eax
8010850f:	89 c2                	mov    %eax,%edx
80108511:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108514:	89 10                	mov    %edx,(%eax)
}
80108516:	c9                   	leave  
80108517:	c3                   	ret    

80108518 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80108518:	55                   	push   %ebp
80108519:	89 e5                	mov    %esp,%ebp
8010851b:	53                   	push   %ebx
8010851c:	83 ec 24             	sub    $0x24,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
8010851f:	e8 ec f9 ff ff       	call   80107f10 <setupkvm>
80108524:	89 45 f0             	mov    %eax,-0x10(%ebp)
80108527:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010852b:	75 0a                	jne    80108537 <copyuvm+0x1f>
    return 0;
8010852d:	b8 00 00 00 00       	mov    $0x0,%eax
80108532:	e9 f8 00 00 00       	jmp    8010862f <copyuvm+0x117>
  for(i = 0; i < sz; i += PGSIZE){
80108537:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010853e:	e9 c8 00 00 00       	jmp    8010860b <copyuvm+0xf3>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80108543:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108546:	83 ec 04             	sub    $0x4,%esp
80108549:	6a 00                	push   $0x0
8010854b:	50                   	push   %eax
8010854c:	ff 75 08             	pushl  0x8(%ebp)
8010854f:	e8 8a f8 ff ff       	call   80107dde <walkpgdir>
80108554:	83 c4 10             	add    $0x10,%esp
80108557:	89 45 ec             	mov    %eax,-0x14(%ebp)
8010855a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
8010855e:	75 0d                	jne    8010856d <copyuvm+0x55>
      panic("copyuvm: pte should exist");
80108560:	83 ec 0c             	sub    $0xc,%esp
80108563:	68 2e 8e 10 80       	push   $0x80108e2e
80108568:	e8 ef 7f ff ff       	call   8010055c <panic>
    if(!(*pte & PTE_P))
8010856d:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108570:	8b 00                	mov    (%eax),%eax
80108572:	83 e0 01             	and    $0x1,%eax
80108575:	85 c0                	test   %eax,%eax
80108577:	75 0d                	jne    80108586 <copyuvm+0x6e>
      panic("copyuvm: page not present");
80108579:	83 ec 0c             	sub    $0xc,%esp
8010857c:	68 48 8e 10 80       	push   $0x80108e48
80108581:	e8 d6 7f ff ff       	call   8010055c <panic>
    pa = PTE_ADDR(*pte);
80108586:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108589:	8b 00                	mov    (%eax),%eax
8010858b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108590:	89 45 e8             	mov    %eax,-0x18(%ebp)
    flags = PTE_FLAGS(*pte);
80108593:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108596:	8b 00                	mov    (%eax),%eax
80108598:	25 ff 0f 00 00       	and    $0xfff,%eax
8010859d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if((mem = kalloc()) == 0)
801085a0:	e8 6f a6 ff ff       	call   80102c14 <kalloc>
801085a5:	89 45 e0             	mov    %eax,-0x20(%ebp)
801085a8:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
801085ac:	75 02                	jne    801085b0 <copyuvm+0x98>
      goto bad;
801085ae:	eb 6c                	jmp    8010861c <copyuvm+0x104>
    memmove(mem, (char*)p2v(pa), PGSIZE);
801085b0:	83 ec 0c             	sub    $0xc,%esp
801085b3:	ff 75 e8             	pushl  -0x18(%ebp)
801085b6:	e8 a2 f3 ff ff       	call   8010795d <p2v>
801085bb:	83 c4 10             	add    $0x10,%esp
801085be:	83 ec 04             	sub    $0x4,%esp
801085c1:	68 00 10 00 00       	push   $0x1000
801085c6:	50                   	push   %eax
801085c7:	ff 75 e0             	pushl  -0x20(%ebp)
801085ca:	e8 93 cf ff ff       	call   80105562 <memmove>
801085cf:	83 c4 10             	add    $0x10,%esp
    if(mappages(d, (void*)i, PGSIZE, v2p(mem), flags) < 0)
801085d2:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801085d5:	83 ec 0c             	sub    $0xc,%esp
801085d8:	ff 75 e0             	pushl  -0x20(%ebp)
801085db:	e8 70 f3 ff ff       	call   80107950 <v2p>
801085e0:	83 c4 10             	add    $0x10,%esp
801085e3:	89 c2                	mov    %eax,%edx
801085e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801085e8:	83 ec 0c             	sub    $0xc,%esp
801085eb:	53                   	push   %ebx
801085ec:	52                   	push   %edx
801085ed:	68 00 10 00 00       	push   $0x1000
801085f2:	50                   	push   %eax
801085f3:	ff 75 f0             	pushl  -0x10(%ebp)
801085f6:	e8 83 f8 ff ff       	call   80107e7e <mappages>
801085fb:	83 c4 20             	add    $0x20,%esp
801085fe:	85 c0                	test   %eax,%eax
80108600:	79 02                	jns    80108604 <copyuvm+0xec>
      goto bad;
80108602:	eb 18                	jmp    8010861c <copyuvm+0x104>
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80108604:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
8010860b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010860e:	3b 45 0c             	cmp    0xc(%ebp),%eax
80108611:	0f 82 2c ff ff ff    	jb     80108543 <copyuvm+0x2b>
      goto bad;
    memmove(mem, (char*)p2v(pa), PGSIZE);
    if(mappages(d, (void*)i, PGSIZE, v2p(mem), flags) < 0)
      goto bad;
  }
  return d;
80108617:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010861a:	eb 13                	jmp    8010862f <copyuvm+0x117>

bad:
  freevm(d);
8010861c:	83 ec 0c             	sub    $0xc,%esp
8010861f:	ff 75 f0             	pushl  -0x10(%ebp)
80108622:	e8 12 fe ff ff       	call   80108439 <freevm>
80108627:	83 c4 10             	add    $0x10,%esp
  return 0;
8010862a:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010862f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80108632:	c9                   	leave  
80108633:	c3                   	ret    

80108634 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80108634:	55                   	push   %ebp
80108635:	89 e5                	mov    %esp,%ebp
80108637:	83 ec 18             	sub    $0x18,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
8010863a:	83 ec 04             	sub    $0x4,%esp
8010863d:	6a 00                	push   $0x0
8010863f:	ff 75 0c             	pushl  0xc(%ebp)
80108642:	ff 75 08             	pushl  0x8(%ebp)
80108645:	e8 94 f7 ff ff       	call   80107dde <walkpgdir>
8010864a:	83 c4 10             	add    $0x10,%esp
8010864d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((*pte & PTE_P) == 0)
80108650:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108653:	8b 00                	mov    (%eax),%eax
80108655:	83 e0 01             	and    $0x1,%eax
80108658:	85 c0                	test   %eax,%eax
8010865a:	75 07                	jne    80108663 <uva2ka+0x2f>
    return 0;
8010865c:	b8 00 00 00 00       	mov    $0x0,%eax
80108661:	eb 29                	jmp    8010868c <uva2ka+0x58>
  if((*pte & PTE_U) == 0)
80108663:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108666:	8b 00                	mov    (%eax),%eax
80108668:	83 e0 04             	and    $0x4,%eax
8010866b:	85 c0                	test   %eax,%eax
8010866d:	75 07                	jne    80108676 <uva2ka+0x42>
    return 0;
8010866f:	b8 00 00 00 00       	mov    $0x0,%eax
80108674:	eb 16                	jmp    8010868c <uva2ka+0x58>
  return (char*)p2v(PTE_ADDR(*pte));
80108676:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108679:	8b 00                	mov    (%eax),%eax
8010867b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108680:	83 ec 0c             	sub    $0xc,%esp
80108683:	50                   	push   %eax
80108684:	e8 d4 f2 ff ff       	call   8010795d <p2v>
80108689:	83 c4 10             	add    $0x10,%esp
}
8010868c:	c9                   	leave  
8010868d:	c3                   	ret    

8010868e <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
8010868e:	55                   	push   %ebp
8010868f:	89 e5                	mov    %esp,%ebp
80108691:	83 ec 18             	sub    $0x18,%esp
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
80108694:	8b 45 10             	mov    0x10(%ebp),%eax
80108697:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(len > 0){
8010869a:	eb 7f                	jmp    8010871b <copyout+0x8d>
    va0 = (uint)PGROUNDDOWN(va);
8010869c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010869f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801086a4:	89 45 ec             	mov    %eax,-0x14(%ebp)
    pa0 = uva2ka(pgdir, (char*)va0);
801086a7:	8b 45 ec             	mov    -0x14(%ebp),%eax
801086aa:	83 ec 08             	sub    $0x8,%esp
801086ad:	50                   	push   %eax
801086ae:	ff 75 08             	pushl  0x8(%ebp)
801086b1:	e8 7e ff ff ff       	call   80108634 <uva2ka>
801086b6:	83 c4 10             	add    $0x10,%esp
801086b9:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(pa0 == 0)
801086bc:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
801086c0:	75 07                	jne    801086c9 <copyout+0x3b>
      return -1;
801086c2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801086c7:	eb 61                	jmp    8010872a <copyout+0x9c>
    n = PGSIZE - (va - va0);
801086c9:	8b 45 ec             	mov    -0x14(%ebp),%eax
801086cc:	2b 45 0c             	sub    0xc(%ebp),%eax
801086cf:	05 00 10 00 00       	add    $0x1000,%eax
801086d4:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(n > len)
801086d7:	8b 45 f0             	mov    -0x10(%ebp),%eax
801086da:	3b 45 14             	cmp    0x14(%ebp),%eax
801086dd:	76 06                	jbe    801086e5 <copyout+0x57>
      n = len;
801086df:	8b 45 14             	mov    0x14(%ebp),%eax
801086e2:	89 45 f0             	mov    %eax,-0x10(%ebp)
    memmove(pa0 + (va - va0), buf, n);
801086e5:	8b 45 0c             	mov    0xc(%ebp),%eax
801086e8:	2b 45 ec             	sub    -0x14(%ebp),%eax
801086eb:	89 c2                	mov    %eax,%edx
801086ed:	8b 45 e8             	mov    -0x18(%ebp),%eax
801086f0:	01 d0                	add    %edx,%eax
801086f2:	83 ec 04             	sub    $0x4,%esp
801086f5:	ff 75 f0             	pushl  -0x10(%ebp)
801086f8:	ff 75 f4             	pushl  -0xc(%ebp)
801086fb:	50                   	push   %eax
801086fc:	e8 61 ce ff ff       	call   80105562 <memmove>
80108701:	83 c4 10             	add    $0x10,%esp
    len -= n;
80108704:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108707:	29 45 14             	sub    %eax,0x14(%ebp)
    buf += n;
8010870a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010870d:	01 45 f4             	add    %eax,-0xc(%ebp)
    va = va0 + PGSIZE;
80108710:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108713:	05 00 10 00 00       	add    $0x1000,%eax
80108718:	89 45 0c             	mov    %eax,0xc(%ebp)
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
8010871b:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
8010871f:	0f 85 77 ff ff ff    	jne    8010869c <copyout+0xe>
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
80108725:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010872a:	c9                   	leave  
8010872b:	c3                   	ret    
