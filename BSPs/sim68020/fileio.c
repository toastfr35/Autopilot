void fileio_open(void *filename, unsigned int len)
{
  char tmp[256];
  int i;
  for (i = 0; i < len; i++) {
    tmp[i] = ((char*)filename)[i];
  }
  tmp[i]=0;

  unsigned int *port = (unsigned int *)0x1;
  *port = (unsigned int)tmp;
}


void fileio_close()
{
  unsigned int *port = (unsigned int *)0x3;
  *port = 0;
}


void fileio_write(void *str, unsigned int len)
{
  unsigned char *port = (unsigned char *)0x2;
  int i;
  for (i = 0; i < len; i++) {
    *port = ((char*)str)[i];
  }
  *port = '\n';
}
