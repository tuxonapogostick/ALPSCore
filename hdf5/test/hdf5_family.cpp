/*
 * Copyright (C) 1998-2016 ALPS Collaboration. See COPYRIGHT.TXT
 * All rights reserved. Use is subject to license terms. See LICENSE.TXT
 * For use in publications, see ACKNOWLEDGE.TXT
 */

#include <alps/hdf5/archive.hpp>

#include <boost/filesystem.hpp>
#include <boost/random.hpp>

#include <string>
#include <vector>
#include <iostream>
#include <algorithm>
#include "gtest/gtest.h"

TEST(hdf5, TestingFamilyFunctionality){
    std::string const filename = "test%05d.h5";
    if (boost::filesystem::exists(boost::filesystem::path(filename)))
        boost::filesystem::remove(boost::filesystem::path(filename));
    {
        using namespace alps;
        alps::hdf5::archive oar(filename, "al");
    }
    {
        using namespace alps;
        alps::hdf5::archive oar(filename, "al");
        oar << make_pvp("/data", 42);
    }
    {
        using namespace alps;
        alps::hdf5::archive iar(filename, "l");
        int test;
        iar >> make_pvp("/data", test);
        {
            alps::hdf5::archive iar2(filename, "l");
            int test2;
            iar2 >> make_pvp("/data", test2);
            iar >> make_pvp("/data", test);
        }
        iar >> make_pvp("/data", test);
        {
            alps::hdf5::archive iar3(filename, "l");
            int test3;
            iar >> make_pvp("/data", test);
            iar3 >> make_pvp("/data", test3);
        }
        iar >> make_pvp("/data", test);
    }
    {
        using namespace alps;
        alps::hdf5::archive iar4(filename, "l");
        int test4;
        iar4 >> make_pvp("/data", test4);
    }
    boost::filesystem::remove(boost::filesystem::path(filename));
}

