#pragma once

#include <DataStreams/IProfilingBlockInputStream.h>


namespace DB
{

/** Поток блоков, из которого можно прочитать один блок.
  * Также смотрите BlocksListBlockInputStream.
  */
class OneBlockInputStream : public IProfilingBlockInputStream
{
public:
    OneBlockInputStream(const Block & block_) : block(block_) {}

    String getName() const override { return "One"; }

    String getID() const override
    {
        std::stringstream res;
        res << this;
        return res.str();
    }

protected:
    Block readImpl() override
    {
        if (has_been_read)
            return Block();

        has_been_read = true;
        return block;
    }

private:
    Block block;
    bool has_been_read = false;
};

}
