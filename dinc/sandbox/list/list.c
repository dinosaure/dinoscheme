struct list {
  int           data;
  struct list * next;
};

int
main()
{
  struct list l;

  l.data = 5;
  l.next = 0;

  return (0);
}
