package com.patel.nirma.karate.library;

import com.intuit.karate.junit5.Karate;

class LibraryKarateTests {

    @Karate.Test
    Karate testAll() {
        return Karate.run().relativeTo(getClass());
    }
}