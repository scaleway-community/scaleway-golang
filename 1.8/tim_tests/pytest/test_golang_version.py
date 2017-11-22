'''
Copyright (C) 2017 Scaleway. All rights reserved.
Use of this source code is governed by a MIT-style
license that can be found in the LICENSE file.
'''


def test_golang_version(host):
    res = host.run('/usr/lib/go-1.8/bin/go version')
    assert res.stdout.startswith('go version go1.8 linux')
