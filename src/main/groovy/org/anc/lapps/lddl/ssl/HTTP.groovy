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

import javax.net.ssl.HttpsURLConnection
import javax.net.ssl.SSLContext
import java.security.SecureRandom

/**
 * @author Keith Suderman
 */
class HTTP {

    static final String UTF8 = 'UTF-8'

    List accept = []
    String url = null

    HTTP() { }

    HTTP(String url) {
        this.url = url
    }

    String encode(input) {
        if (input instanceof GString) {
            return URLEncoder.encode(input.toString(), UTF8)
        }
        if (input instanceof String) {
            return URLEncoder.encode(input, UTF8)
        }
        return input
    }

    void accept(String contentType) {
        accept << contentType
    }

    private HttpURLConnection open(URL url) {
        HttpURLConnection connection = (HttpURLConnection) url.openConnection()
        if (url.protocol == 'https') {
            HttpsURLConnection https = (HttpsURLConnection) connection
            SSLContext ssl = SSLContext.getInstance('TLS')
            ssl.init(null, [new TrustManager()] as TrustManager[], new SecureRandom())
            https.setSSLSocketFactory(ssl.getSocketFactory())
            https.setHostnameVerifier(new HostnameVerifier())
        }
        return connection
    }

    Response get(String query) {
        HttpURLConnection connection = open(new URL(query))
        connection.setRequestMethod("GET")

        Response response = new Response()
        response.status = connection.responseCode
        println response.status
        connection.headerFields.each { name,value ->
            if (name) {
                response.headers[name] = value
            }
        }
        if (response.status == 200) {
            BufferedReader reader = new BufferedReader(new InputStreamReader(connection.inputStream))
            StringBuilder buffer = new StringBuilder()
            String line = reader.readLine()
            while (line != null) {
                buffer << line
                buffer << "\n"
                line = reader.readLine()
            }
            response.body = buffer.toString()
        }
        return response
    }

    Response post(Map params) {
        if (this.url == null) {
            throw new IOException("No URL has been specified.")
        }
        return post(url, params)
    }

    Response post(String url, Map params) {
        String query = params.collect {k,v -> "$k=${encode(v)}"}.join('&')
        return post(url, query)
    }

    Response post(String query) {
        if (this.url == null) {
            throw new IOException("No URL has been specified.")
        }
        return post(url, query)
    }

    Response post(String url, String query) {
        URLConnection connection = open(url)

        connection.setDoOutput(true); // Triggers POST.
        connection.setRequestProperty("Accept-Charset", UTF8);
        if (accept.size() > 0) {
            connection.setRequestProperty('Accept', accept.join(','))
        }
        connection.setRequestProperty("Content-Type", "application/x-www-form-urlencoded;charset=" + UTF8);
        OutputStream output = connection.getOutputStream();
        try {
            output.write(query.getBytes(UTF8));
        } finally {
            try { output.close(); } catch (IOException ignored) {}
        }

        Response response = new Response()
        connection.headerFields.each { name,value ->
            if (name) {
                response.headers[name] = value
            }
        }

        response.status = connection.responseCode
        response.encoding = connection.contentEncoding
        response.contentType = connection.contentType
        response.message = connection.responseMessage
        if (response.status == 200) {
            response.body = connection.inputStream.text
        }
        else {
            response.body = connection.errorStream.text
        }
        return response
    }

    public class Response {
        int status
        String encoding
        String contentType
        String message
        Map headers = [:]
        String body
    }
}
