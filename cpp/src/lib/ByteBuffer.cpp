
#include "ByteBuffer.h"

#include "CodePoint.h"

ByteBuffer::ByteBuffer() : data(), dataByteCount(), dataByteIndex(), libData() {}

void ByteBuffer::init(const unsigned char *dataIn, size_t dataByteCountIn, WolframLibraryData libDataIn) {
  
    data = dataIn;
    dataByteCount = dataByteCountIn;
    
    dataByteIndex = 0;
    
    libData = libDataIn;
}

void ByteBuffer::deinit() {}

unsigned char ByteBuffer::nextByte(unsigned char *eof) {
    
    assert(dataByteIndex <= dataByteCount && "Fix at call site");
    
#ifndef NDEBUG
    size_t oldProgress;
    if (dataByteCount != 0) {
        oldProgress= (100 * dataByteIndex / dataByteCount);
    }
#endif
    
    if (dataByteIndex == dataByteCount) {
        *eof = true;
        return 0xff;
    }
    
    *eof = false;
    
    auto b = data[dataByteIndex];
    dataByteIndex++;
    
#ifndef NDEBUG
#if USE_MATHLINK
    if (dataByteCount != 0) {
        
        size_t progress = (100 * dataByteIndex / dataByteCount);
        
        if (progress != oldProgress) {
            if (libData) {
                MLINK link = libData->getMathLink(libData);
                MLPutFunction(link, "EvaluatePacket", 1);
                MLPutFunction(link, "AST`Library`SetConcreteParseProgress", 1);
                MLPutInteger(link, static_cast<int>(progress));
                libData->processMathLink(link);
                auto pkt = MLNextPacket(link);
                if (pkt == RETURNPKT) {
                    if(!MLNewPacket(link)) {
                        b = -1;
                    }
                } else {
                    b = -1;
                }
            }
        }
    }
#endif // USE_MATHLINK
#endif
    
    //
    // if eof, then force 0xff to be returned
    //
    // but try really hard to be branchless
    // this will pay off more as more code becomes branchless
    //
    //return b | ((*eof ^ 0xff) - 0xff);
    return b;
}

size_t ByteBuffer::getDataByteIndex() const {
    return dataByteIndex;
}

void ByteBuffer::setDataByteIndex(size_t idx) {
    dataByteIndex = idx;
}

std::unique_ptr<ByteBuffer> TheByteBuffer = nullptr;

