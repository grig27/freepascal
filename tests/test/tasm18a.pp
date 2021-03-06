{ %FAIL }
{ %CPU=i8086,i386,x86_64 }
program tasm18a;

{$ifdef FPC}
  {$asmmode intel}
{$else}
  {$define CPUI8086}
{$endif FPC}

const
  cval = 1;

type
  foo3 = packed record
    b1: byte;
    b2: byte;
    b3: byte;
  end;

begin
  asm
    { this should produce an error, because foo3 is a 3-byte record and there's
      no explicit operand size specified (i.e. no 'byte ptr' or 'word ptr') }
{$ifdef CPUI8086}
    test [di + foo3], cval
{$endif}
{$ifdef CPUI386}
    test [edi + foo3], cval
{$endif}
{$ifdef CPUX86_64}
    test [rdi + foo3], cval
{$endif}
  end;
end.
