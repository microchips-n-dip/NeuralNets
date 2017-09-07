#include <sys/ioctl.h>

/* Basic mailbox functions */

int mbox_open()
{
  int file_desc = open(DEVICE_FILE_NAME, 0);

  if (file_desc < 0) {
    printf("Fatal error when opening device kernel\n");
    exit(-1);
  }

  return file_desc;
}

void mbox_close(int file_desc)
{
  close(file_desc);
}

/* Device mailing */

static int mbox_property(int file_desc, void* buf)
{
  int ret_val = ioctl(file_desc, IOCTL_MBOX_PROPERTY, buf);

  if (ret_val < 0) {
    printf("Error sending instructions\n");
  }

  return ret_val;
}

/* Enabling function */

unsigned qpu_enable(int file_desc, unsigned enable)
{
  unsigned i = 0;
  unsigned p[32];

  p[i++] = 0;
  p[i++] = 0x00000000;
  p[i++] = 0x30012;
  p[i++] = 4;
  p[i++] = 4;
  p[i++] = enable;

  p[i++] = 0x00000000;
  p[0] = i * (unsigned) sizeof(*p);

  mbox_property(file_desc, p);
  return p[5];
}

/* Memory functions */

unsigned qpu_malloc(int file_desc, unsigned size, unsigned aligned, unsigned flags)
{
  unsigned i = 0;
  unsigned p[32];

  p[i++] = 0;
  p[i++] = 0x00000000;

  p[i++] = 0x3000c;
  p[i++] = 12;
  p[i++] = 12;
  p[i++] = size;
  p[i++] = align;
  p[i++] = flags;

  p[i++] = 0x00000000;
  p[0] = i * (unsigned) sizeof(*p);

  mbox_property(file_desc, p);
  return p[5];
}

/* Execution function */

unsigned qpu_execute()
