import std.stdio;
import std.file;

void main(string[] args)
{
    if (args.length != 2)
    {
        stderr.writeln("usage: d80 file.com");
        return;
    }

    ubyte[] program = cast(ubyte[]) read(args[1]);

    auto addr = 0;
    while (addr < program.length)
    {
        writef("%04x\t%s", addr, insn[program[addr]].mnemonic);
        if (insn[program[addr]].size > 1)
        {
            if (insn[program[addr]].size == 3)
                writef("%02x", program[addr + 2]);
            writef("%02xh", program[addr + 1]);
        }
        writeln();

        addr += insn[program[addr]].size;
    }
}
