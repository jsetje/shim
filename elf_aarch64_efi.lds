OUTPUT_FORMAT("elf64-littleaarch64", "elf64-littleaarch64", "elf64-littleaarch64")
OUTPUT_ARCH(aarch64)
ENTRY(_start)
SECTIONS
{
  .text 0x0 : {
    _text = .;
    *(.text.head)
    *(.text)
    *(.text.*)
    *(.gnu.linkonce.t.*)
    *(.srodata)
    *(.rodata*)
    . = ALIGN(16);
    _etext = .;
  }

  . = ALIGN(4096);
  .dynamic  : { *(.dynamic) }

  . = ALIGN(4096);
  .note.gnu.build-id : {
    *(.note.gnu.build-id)
  }

  . = ALIGN(4096);
  .data.ident : {
    *(.data.ident)
  }

  . = ALIGN(4096);
  .data :
  {
   _data = .;
   *(.sdata)
   *(.data)
   *(.data1)
   *(.data.*)
   *(.got.plt)
   *(.got)

   /* the EFI loader doesn't seem to like a .bss section, so we stick
      it all into .data: */
   . = ALIGN(16);
   _bss = .;
   *(.sbss)
   *(.scommon)
   *(.dynbss)
   *(.bss)
   *(COMMON)
   . = ALIGN(4096);
   _bss_end = .;
  }
  _edata = .;
  _data_size = . - _data;

  . = ALIGN(4096);
  .sbat :
  {
    _sbat = .;
    *(.sbat)
    *(.sbat.*)
    . = ALIGN(4096);
  }
  _esbat = .;
  _sbat_vsize = . - _sbat;
  . = ALIGN(4096);
  _sbat_size = . - _sbat;

  . = ALIGN(4096);
  .vendor_cert :
  {
    _vendor_cert = .;
    *(.vendor_cert)
    _evirt_vendor_cert = .;
    . = ALIGN(4096);
  }
  _evendor_cert = .;
  _vendor_cert_vsize = _evirt_vendor_cert - _vendor_cert;
  _vendor_cert_size = . - _vendor_cert;
  _alldata_size = . - _data;

  .rela :
  {
    *(.rela.dyn)
    *(.rela.plt)
    *(.rela.got)
    *(.rela.data)
    *(.rela.data*)
  }

  . = ALIGN(4096);
  .dynsym   : { *(.dynsym) }
  . = ALIGN(4096);
  .dynstr   : { *(.dynstr) }
  . = ALIGN(4096);
  /DISCARD/ :
  {
    *(.rel.reloc)
    *(.eh_frame)
    *(.note.GNU-stack)
  }
  .comment 0 : { *(.comment) }
}
