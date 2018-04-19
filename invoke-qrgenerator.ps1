function new-qrsecret {
    
    $alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ234567"
    $builder = ""
    $random = ""

    for ($i = 0; $i -lt "16"; $i++) {
        $random = get-random -Maximum $alphabet.Length
        $builder = $builder + $alphabet[$random]
    }
    return $builder
}

function get-qrcodeurl {

    [cmdletbinding()]
    param (
        $builder
    )

    if ($builder -eq $null) {
        $builder = new-qrsecret
    }

    $googleUrlLabel = "otpauth://totp/screenconnect?secret=" + $builder;

    $EncodedURL = [System.Web.HttpUtility]::UrlEncode($googleUrlLabel)

    $qrcodeurl = "https://chart.googleapis.com/chart?cht=qr&chs=300x300&chl=" + $EncodedURL + "&chld=H|0";
    
    return $qrcodeurl
} 