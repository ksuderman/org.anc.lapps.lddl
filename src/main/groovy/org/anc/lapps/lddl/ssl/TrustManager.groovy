/*
 * Copyright (c) 2017 The American National Corpus
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.anc.lapps.lddl.ssl

import javax.net.ssl.X509TrustManager
import java.security.cert.CertificateException
import java.security.cert.X509Certificate

/**
 * @author Keith Suderman
 */
class TrustManager implements X509TrustManager {
    @Override
    void checkClientTrusted(X509Certificate[] x509Certificates, String s) throws CertificateException {
        // Intentionally left blank.
    }

    @Override
    void checkServerTrusted(X509Certificate[] x509Certificates, String s) throws CertificateException {
        // Intentionally left blank.
    }

    @Override
    X509Certificate[] getAcceptedIssuers() {
        return new X509Certificate[0]
    }
}
