# VK-Audio-Token-Swift
Get vkontakte token for audio access (Swift)

This code makes it possible to obtain VK token, that works for VK audio API, so you can query audio URIs. The code was obtained through reversing official VK client. VK login, VK password. No additional dependencies are required.

## Installation

``` pod 'VKAudioToken' ```

## Using

``` 
TokenReceiverOfficial(login: "USER_LOGIN (Email or Phone)", pass: "USER_PASSWORD").getToken(success: {(token, secret, deviceId) in
  print(token)
}, fail: {(error) in
  print(error)
})
```

## License
```
    VKAudioToken - Token generate for access to VKontakte official audio.
    Copyright (C) 2019  LUTSKII MIKHAIL

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
    ```
